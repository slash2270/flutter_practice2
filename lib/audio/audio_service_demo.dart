// ignore_for_file: public_member_api_docs

// FOR MORE EXAMPLES, VISIT THE GITHUB REPOSITORY AT:
//
//  https://github.com/ryanheise/audio_service
//
// This example implements a minimal audio handler that renders the current
// media item and playback state to the system notification and responds to 4
// media actions:
//
// - play
// - pause
// - seek
// - stop
//
// To run this example, use:
//
// flutter run

import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/util/function_util.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import '../just_audio/commom.dart';

late FunctionUtil _functionUtil;
late AudioHandler _audioHandler;

class AudioServiceDemo extends StatefulWidget {
  const AudioServiceDemo({Key? key}) : super(key: key);

  @override
  State<AudioServiceDemo> createState() => _AudioServiceDemoState();
}

class _AudioServiceDemoState extends State<AudioServiceDemo> {

  @override
  void initState() {
    super.initState();
    _init();
  }

  _init() async{
    _functionUtil = FunctionUtil();
    _audioHandler = await AudioService.init(
      builder: () => AudioPlayerHandler(),
      config: const AudioServiceConfig(
        androidNotificationChannelId: 'com.ryanheise.myapp.channel.audio1',
        androidNotificationChannelName: 'Audio Playback',
        androidNotificationOngoing: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const MainScreen();
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 顯示媒體項目標題
        StreamBuilder<MediaItem?>(
          stream: _audioHandler.mediaItem,
          builder: (context, snapshot) {
            final mediaItem = snapshot.data;
            return _functionUtil.initText(mediaItem?.title ?? '');
          },
        ),
        // 播放/暫停/停止按鈕。
        StreamBuilder<bool>(
          stream: _audioHandler.playbackState
              .map((state) => state.playing)
              .distinct(),
          builder: (context, snapshot) {
            final playing = snapshot.data ?? false;
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _button(Icons.fast_rewind, _audioHandler.rewind),
                if (playing)
                  _button(Icons.pause, _audioHandler.pause)
                else
                  _button(Icons.play_arrow, _audioHandler.play),
                _button(Icons.stop, _audioHandler.stop),
                _button(Icons.fast_forward, _audioHandler.fastForward),
              ],
            );
          },
        ),
        // 一個搜索欄。
        StreamBuilder<MediaState>(
          stream: _mediaStateStream,
          builder: (context, snapshot) {
            final mediaState = snapshot.data;
            return SeekBarC(
              duration: mediaState?.mediaItem?.duration ?? Duration.zero,
              position: mediaState?.position ?? Duration.zero,
              onChangeEnd: (newPosition) {
                _audioHandler.seek(newPosition);
              },
            );
          },
        ),
        // 顯示處理狀態。
        StreamBuilder<AudioProcessingState>(
          stream: _audioHandler.playbackState
              .map((state) => state.processingState)
              .distinct(),
          builder: (context, snapshot) {
            final processingState = snapshot.data ?? AudioProcessingState.idle;
            return _functionUtil.initText("處理狀態: ${describeEnum(processingState)}");
          },
        ),
      ],
    );
  }

  /// 報告當前媒體項及其組合狀態的流
  /// 當前位置。
  Stream<MediaState> get _mediaStateStream => Rx.combineLatest2<MediaItem?, Duration, MediaState>(
      _audioHandler.mediaItem,
      AudioService.position,
          (mediaItem, position) => MediaState(mediaItem, position));

  IconButton _button(IconData iconData, VoidCallback onPressed) => IconButton(
    icon: Icon(iconData),
    iconSize: 64.0,
    onPressed: onPressed,
  );
}

class MediaState {
  final MediaItem? mediaItem;
  final Duration position;

  MediaState(this.mediaItem, this.position);
}

/// 用於播放單個項目的 [AudioHandler]。
class AudioPlayerHandler extends BaseAudioHandler with SeekHandler {
  static final _item = MediaItem(
    id: 'https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3',
    album: "Science Friday",
    title: "向令人頭疼的科學致敬",
    artist: "科學星期五和 WNYC 工作室",
    duration: const Duration(milliseconds: 5739820),
    artUri: Uri.parse('https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg'),
  );

  final _player = AudioPlayer();

  /// 初始化我們的音頻處理程序。
  AudioPlayerHandler() {
    // 以便我們的客戶端（Flutter UI 和系統通知）知道
    // 顯示什麼狀態，這裡我們設置我們的音頻處理程序來廣播所有
    // 播放狀態會隨著它們通過播放狀態發生變化...
    _player.playbackEventStream.map(_transformEvent).pipe(playbackState);
    // ... 以及通過 mediaItem 的當前媒體項。
    mediaItem.add(_item);

    // 加載播放器。
    _player.setAudioSource(AudioSource.uri(Uri.parse(_item.id)));
  }

  // 在這個簡單的例子中，我們只處理 4 個動作：播放、暫停、搜索和
  // 停止。 Flutter UI、通知、鎖定屏幕或
  // 耳機會被路由到這4個方法，這樣你就可以處理了
  // 你的音頻播放邏輯在一個地方。

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> stop() => _player.stop();

  /// 將 just_audio 事件轉換為 audio_service 狀態。
  ///
  /// 這個方法在構造函數中使用。 從收到的每個事件
  /// just_audio 播放器將轉換為 audio_service 狀態，以便
  /// 它可以廣播到 audio_service 客戶端。
  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      controls: [
        MediaControl.rewind,
        if (_player.playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
        MediaControl.fastForward,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0, 1, 3],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: _player.playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: event.currentIndex,
    );
  }
}