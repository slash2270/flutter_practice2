import 'dart:math';

import 'package:audio_session/audio_session.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/util/function_util.dart';
import 'package:just_audio/just_audio.dart' as ja;

class AudioSessionWidget extends StatefulWidget {
  const AudioSessionWidget({Key? key}) : super(key: key);

  @override
  _AudioSessionWidgetState createState() => _AudioSessionWidgetState();
}

class _AudioSessionWidgetState extends State<AudioSessionWidget> {

  late FunctionUtil _functionUtil;

  final _player = ja.AudioPlayer(
    // 出於本演示的目的，我們自己處理 audio_session 事件
    handleInterruptions: false,
    androidApplyAudioAttributes: false,
    handleAudioSessionActivation: false,
  );

  @override
  void initState() {
    super.initState();
    _functionUtil = FunctionUtil();
    AudioSession.instance.then((audioSession) async {
      // 此行配置應用程序的音頻會話，向操作系統指示
      // 我們打算播放的音頻類型。 使用“演講”配方而不是
      // “音樂”，因為我們正在播放播客。
      await audioSession.configure(const AudioSessionConfiguration.speech());
      // 收聽音頻中斷並酌情暫停或閃避。
      _handleInterruptions(audioSession);
      // 使用另一個插件加載要播放的音頻。
      await _player.setUrl("https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3");
    });
  }

  void _handleInterruptions(AudioSession audioSession) {
    // just_audio can handle interruptions for us, but we have disabled that in
    // order to demonstrate manual configuration.
    bool playInterrupted = false;
    audioSession.becomingNoisyEventStream.listen((_) {
      LogUtil.e('AudioSession 暫停');
      _player.pause();
    });
    _player.playingStream.listen((playing) {
      playInterrupted = false;
      if (playing) {
        audioSession.setActive(true);
      }
    });
    audioSession.interruptionEventStream.listen((event) {
      LogUtil.e('AudioSession 中斷開始:${event.begin} AudioSession 中斷型態:${event.type}');
      if (event.begin) {
        switch (event.type) {
          case AudioInterruptionType.duck:
            if (audioSession.androidAudioAttributes!.usage ==
                AndroidAudioUsage.game) {
              _player.setVolume(_player.volume / 2);
            }
            playInterrupted = false;
            break;
          case AudioInterruptionType.pause:
          case AudioInterruptionType.unknown:
            if (_player.playing) {
              _player.pause();
              playInterrupted = true;
            }
            break;
        }
      } else {
        switch (event.type) {
          case AudioInterruptionType.duck:
            _player.setVolume(min(1.0, _player.volume * 2));
            playInterrupted = false;
            break;
          case AudioInterruptionType.pause:
            if (playInterrupted) _player.play();
            playInterrupted = false;
            break;
          case AudioInterruptionType.unknown:
            playInterrupted = false;
            break;
        }
      }
    });
    audioSession.devicesChangedEventStream.listen((event) {
      LogUtil.e('AudioSession 設備 增加:${event.devicesAdded} 移除:${event.devicesRemoved}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                  child: StreamBuilder<ja.PlayerState>(
                    stream: _player.playerStateStream,
                    builder: (context, snapshot) {
                      final playerState = snapshot.data;
                      if (playerState?.processingState != ja.ProcessingState.ready) {
                        return Container(
                          margin: _functionUtil.initEdgeInsetsAll(8.0),
                          width: 64.0,
                          height: 64.0,
                          child: const CircularProgressIndicator(),
                        );
                      } else if (playerState?.playing == true) {
                        return IconButton(
                          icon: _functionUtil.initIcon(Icons.pause),
                          iconSize: 64.0,
                          onPressed: _player.pause,
                        );
                      } else {
                        return IconButton(
                          icon: _functionUtil.initIcon(Icons.play_arrow),
                          iconSize: 64.0,
                          onPressed: _player.play,
                        );
                      }
                    },
                  ),
              ),
              FutureBuilder<AudioSession>(
                  future: AudioSession.instance,
                  builder: (context, snapshot) {
                    final session = snapshot.data;
                    if (session == null) return const SizedBox();
                    return StreamBuilder<Set<AudioDevice>>(
                      stream: session.devicesStream,
                      builder: (context, snapshot) {
                        final devices = snapshot.data ?? {};
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("輸入裝置", style: Theme.of(context).textTheme.headline6),
                            for (var device
                            in devices.where((device) => device.isInput))
                              _functionUtil.initText('${device.name} (${describeEnum(device.type)})'),
                              _functionUtil.initSizedBox(16.0),
                            Text("輸出裝置", style: Theme.of(context).textTheme.headline6),
                            for (var device
                            in devices.where((device) => device.isOutput))
                              _functionUtil.initText('${device.name} (${describeEnum(device.type)})'),
                          ],
                        );
                      },
                    );
                  },
                ),
            ],
    );
  }
}