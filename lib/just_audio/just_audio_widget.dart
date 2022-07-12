// 這是一個演示播放/暫停按鈕和搜索欄的最小示例。
// 更多演示其他功能的高級示例可以在同一個文件中找到
// 目錄作為 GitHub 存儲庫中的示例。

import 'package:audio_session/audio_session.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import 'commom.dart';

class JustAudioWidget extends StatefulWidget {
  const JustAudioWidget({Key? key}) : super(key: key);

  @override
  JustAudioWidgetState createState() => JustAudioWidgetState();
}

class JustAudioWidgetState extends State<JustAudioWidget> with WidgetsBindingObserver {
  late AudioPlayer _player;

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
    // 通知操作系統我們應用的音頻屬性等
    // 我們為播放語音的應用選擇一個合理的默認值。
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    // 在播放期間收聽錯誤。
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
          LogUtil.e('JustAudioWidget A stream error occurred: $e');
        });
    // 嘗試從源加載音頻並捕獲任何錯誤。
    try {
      // AAC example: https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.aac
      await _player.setAudioSource(AudioSource.uri(Uri.parse("https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3")));
    } catch (e) {
      LogUtil.e('JustAudioWidget Error loading audio source: $e');
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

  /// Collects the data useful for displaying in a seek bar, using a handy
  /// feature of rx_dart to combine the 3 streams of interest into one.
  Stream<PositionData> get _positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          _player.positionStream,
          _player.bufferedPositionStream,
          _player.durationStream,
              (position, bufferedPosition, duration) => PositionData(
              position, bufferedPosition, duration ?? Duration.zero));

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
        // 打開速度滑塊對話框
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