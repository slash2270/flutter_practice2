// This example demonstrates simultaneous playback and caching of downloaded
// audio.
//
// To run:
//
// flutter run -t lib/example_caching.dart

import 'package:audio_session/audio_session.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import 'commom.dart';

class JustAudioCatchingWidget extends StatefulWidget {
  const JustAudioCatchingWidget({Key? key}) : super(key: key);

  @override
  JustAudioCatchingWidgetState createState() => JustAudioCatchingWidgetState();
}

class JustAudioCatchingWidgetState extends State<JustAudioCatchingWidget> with WidgetsBindingObserver {
  late AudioPlayer _player;
  late LockCachingAudioSource _audioSource;

  @override
  void initState() {
    super.initState();
    ambiguate(WidgetsBinding.instance)!.addObserver(this);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    _init();
  }

  Future<void> _init() async {
    _player = AudioPlayer();
    _audioSource = LockCachingAudioSource(Uri.parse(
      // 支持範圍請求：
      "https://dovetail.prxu.org/70/66673fd4-6851-4b90-a762-7c0538c76626/CoryCombs_2021T_VO_Intro.mp3",
      // 不支持範圍請求：
      //"https://filesamples.com/samples/audio/mp3/sample4.mp3",
    ));
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
          LogUtil.e('JustAudio Catching A stream error occurred: $e');
        });
    try {
      //await _audioSource.clearCache();
      await _player.setAudioSource(_audioSource);
    } catch (e) {
      LogUtil.e('JustAudio Catching Error loading audio source: $e');
    }
  }

  @override
  void dispose() {
    ambiguate(WidgetsBinding.instance)!.removeObserver(this);
    // 將解碼器和緩衝區釋放回操作系統製作它們
    // 可供其他應用使用。
    _player.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      // 不使用時釋放播放器的資源。 我們使用“停止”，這樣
      // 如果應用程序稍後恢復，它仍然會記住要定位的位置
      // 恢復自。
      _player.stop();
    }
  }

  /// 收集對在搜索欄中顯示有用的數據，使用方便的
  /// rx_dart 的功能將 3 個感興趣的流合併為一個。
  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, double, Duration?, PositionData>(
          _player.positionStream,
          _audioSource.downloadProgressStream,
          _player.durationStream,
              (position, downloadProgress, reportedDuration) {
            final duration = reportedDuration ?? Duration.zero;
            final bufferedPosition = duration * downloadProgress;
            return PositionData(position, bufferedPosition, duration);
          });

  @override
  Widget build(BuildContext context) {
    return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 顯示播放/暫停按鈕和音量/速度滑塊。
              ControlButtons(_player),
              // 顯示搜索欄。 使用 StreamBuilder，這個小部件重建
              // 每次位置、緩衝位置或持續時間發生變化。
              StreamBuilder<PositionData>(
                stream: _positionDataStream,
                builder: (context, snapshot) {
                  final positionData = snapshot.data;
                  return SeekBar(
                    duration: positionData?.duration ?? Duration.zero,
                    position: positionData?.position ?? Duration.zero,
                    bufferedPosition:
                    positionData?.bufferedPosition ?? Duration.zero,
                    onChangeEnd: _player.seek,
                  );
                },
              ),
              ElevatedButton(
                onPressed: _audioSource.clearCache,
                child: const Text('清除快取'),
              ),
            ],
    );
  }
}

/// 顯示播放/暫停按鈕和音量/速度滑塊。
class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  const ControlButtons(this.player, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 打開音量滑塊對話框
        IconButton(
          icon: const Icon(Icons.volume_up),
          onPressed: () {
            showSliderDialog(
              context: context,
              title: "Adjust 音量",
              divisions: 10,
              min: 0.0,
              max: 1.0,
              value: player.volume,
              stream: player.volumeStream,
              onChanged: player.setVolume,
            );
          },
        ),

        /// 每當播放器狀態發生變化時，此 StreamBuilder 都會重新構建，這
        /// 包括播放/暫停狀態以及
        /// 加載/緩衝/就緒狀態。 根據狀態，我們顯示
        /// 適當的按鈕或加載指示器。
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                width: 64.0,
                height: 64.0,
                child: const CircularProgressIndicator(),
              );
            } else if (playing != true) {
              return IconButton(
                icon: const Icon(Icons.play_arrow),
                iconSize: 64.0,
                onPressed: player.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: const Icon(Icons.pause),
                iconSize: 64.0,
                onPressed: player.pause,
              );
            } else {
              return IconButton(
                icon: const Icon(Icons.replay),
                iconSize: 64.0,
                onPressed: () => player.seek(Duration.zero),
              );
            }
          },
        ),
        // Opens speed slider dialog
        StreamBuilder<double>(
          stream: player.speedStream,
          builder: (context, snapshot) => IconButton(
            icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            onPressed: () {
              showSliderDialog(
                context: context,
                title: "Adjust 速度",
                divisions: 10,
                min: 0.5,
                max: 1.5,
                value: player.speed,
                stream: player.speedStream,
                onChanged: player.setSpeed,
              );
            },
          ),
        ),
      ],
    );
  }
}