// ignore_for_file: public_member_api_docs

// This example demonstrates:
//
// - queues/playlists
// - switching between audio handlers (audio player / text-to-speech player)
// - logging
// - custom actions
// - custom events
// - Android 11 media session resumption
// - Android Auto
//
// To run this example, use:
//
// flutter run -t lib/example_multiple_handlers.dart

import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/util/function_util.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';

import '../just_audio/commom.dart';

late FunctionUtil _functionUtil;
late AudioHandler _audioHandler;

/// Extension methods for our custom actions.
extension DemoAudioHandler on AudioHandler {
  Future<void> switchToHandler(int? index) async {
    if (index == null) return;
    await _audioHandler.customAction('switchToHandler', <String, dynamic>{'index': index});
  }
}

class AudioMultiHandler extends StatefulWidget {
  const AudioMultiHandler({Key? key}) : super(key: key);

  @override
  State<AudioMultiHandler> createState() => _AudioMultiHandlerState();
}

class _AudioMultiHandlerState extends State<AudioMultiHandler> {

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
        androidNotificationChannelId: 'com.ryanheise.myapp.channel.audio3',
        androidNotificationChannelName: 'audio playback',
        androidNotificationOngoing: true,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MainScreen();
  }
}

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final _handlerNames = [
    'Audio Player',
    'Text-To-Speech',
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Queue display/controls.
            StreamBuilder<QueueState>(
              stream: _queueStateStream,
              builder: (context, snapshot) {
                final queueState = snapshot.data;
                final queue = queueState?.queue ?? const [];
                final mediaItem = queueState?.mediaItem;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    StreamBuilder<dynamic>(
                      stream: _audioHandler.customState,
                      builder: (context, snapshot) {
                        final handlerIndex =
                            (snapshot.data?.handlerIndex as int?) ?? 0;
                        return DropdownButton<int>(
                          value: handlerIndex,
                          items: [
                            for (var i = 0; i < _handlerNames.length; i++)
                              DropdownMenuItem<int>(
                                value: i,
                                child: Text(_handlerNames[i]),
                              ),
                          ],
                          onChanged: _audioHandler.switchToHandler,
                        );
                      },
                    ),
                    if (queue.isNotEmpty)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.skip_previous),
                            iconSize: 64.0,
                            onPressed: mediaItem == queue.first
                                ? null
                                : _audioHandler.skipToPrevious,
                          ),
                          IconButton(
                            icon: const Icon(Icons.skip_next),
                            iconSize: 64.0,
                            onPressed: mediaItem == queue.last
                                ? null
                                : _audioHandler.skipToNext,
                          ),
                        ],
                      ),
                    if (mediaItem?.title != null) Text(mediaItem!.title),
                  ],
                );
              },
            ),
            // Play/pause/stop buttons.
            StreamBuilder<bool>(
              stream: _audioHandler.playbackState
                  .map((state) => state.playing)
                  .distinct(),
              builder: (context, snapshot) {
                final playing = snapshot.data ?? false;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (playing) _pauseButton() else _playButton(),
                    _stopButton(),
                  ],
                );
              },
            ),
            // A seek bar.
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
            // Display the processing state.
            StreamBuilder<AudioProcessingState>(
              stream: _audioHandler.playbackState
                  .map((state) => state.processingState)
                  .distinct(),
              builder: (context, snapshot) {
                final processingState = snapshot.data ?? AudioProcessingState.idle;
                return _functionUtil.initText("處理狀態: ${describeEnum(processingState)}");
              },
            ),
            // Display the latest custom event.
            StreamBuilder<dynamic>(
              stream: _audioHandler.customEvent,
              builder: (context, snapshot) {
                return _functionUtil.initText("自定義事件: ${snapshot.data}");
              },
            ),
            // Display the notification click status.
            StreamBuilder<bool>(
              stream: AudioService.notificationClicked,
              builder: (context, snapshot) {
                return _functionUtil.initText('通知點擊狀態: ${snapshot.data}',
                );
              },
            ),
          ],
      ),
    );
  }

  /// 報告當前媒體項及其組合狀態的流
  /// 當前位置。
  Stream<MediaState> get _mediaStateStream => Rx.combineLatest2<MediaItem?, Duration, MediaState>(
          _audioHandler.mediaItem,
          AudioService.position,
              (mediaItem, position) => MediaState(mediaItem, position));

  /// 一個流報告當前隊列和當前隊列的組合狀態
  /// 該隊列中的媒體項目。
  Stream<QueueState> get _queueStateStream => Rx.combineLatest2<List<MediaItem>, MediaItem?, QueueState>(
          _audioHandler.queue,
          _audioHandler.mediaItem,
              (queue, mediaItem) => QueueState(queue, mediaItem));

  Widget _playButton() => _functionUtil.initIconButton1(() => _audioHandler.play, const Icon(Icons.play_arrow), 64.0);
  Widget _pauseButton() => _functionUtil.initIconButton1(() => _audioHandler.pause, const Icon(Icons.pause), 64.0);
  Widget _stopButton() => _functionUtil.initIconButton1(() => _audioHandler.stop, const Icon(Icons.stop), 64.0);
}

class QueueState {
  final List<MediaItem> queue;
  final MediaItem? mediaItem;

  QueueState(this.queue, this.mediaItem);
}

class MediaState {
  final MediaItem? mediaItem;
  final Duration position;

  MediaState(this.mediaItem, this.position);
}

class CustomEvent {
  final int handlerIndex;

  CustomEvent(this.handlerIndex);
}

class MainSwitchHandler extends SwitchAudioHandler {
  final List<AudioHandler> handlers;
  @override
  BehaviorSubject<dynamic> customState = BehaviorSubject<dynamic>.seeded(CustomEvent(0));

  MainSwitchHandler(this.handlers) : super(handlers.first) {
    // 配置應用程序的音頻類別和語音屬性。
    AudioSession.instance.then((session) {
      session.configure(const AudioSessionConfiguration.speech());
    });
  }

  @override
  Future<dynamic> customAction(String name,
      [Map<String, dynamic>? extras]) async {
    switch (name) {
      case 'switchToHandler':
        stop();
        final index = extras!['index'] as int;
        inner = handlers[index];
        customState.add(CustomEvent(index));
        return null;
      default:
        return super.customAction(name, extras);
    }
  }
}

/// 用於播放播客劇集列表的 [AudioHandler]。
class AudioPlayerHandler extends BaseAudioHandler
    with QueueHandler, SeekHandler {
  // ignore: close_sinks
  final BehaviorSubject<List<MediaItem>> _recentSubject = BehaviorSubject.seeded(<MediaItem>[]);
  final _mediaLibrary = MediaLibrary();
  final _player = AudioPlayer();

  int? get index => _player.currentIndex;

  AudioPlayerHandler() {
    _init();
  }

  Future<void> _init() async {
    // Load and broadcast the queue
    queue.add(_mediaLibrary.items[MediaLibrary.albumsRootId]!);
    // For Android 11, record the most recent item so it can be resumed.
    mediaItem
        .whereType<MediaItem>()
        .listen((item) => _recentSubject.add([item]));
    // Broadcast media item changes.
    _player.currentIndexStream.listen((index) {
      if (index != null) mediaItem.add(queue.value![index]);
    });
    // Propagate all events from the audio player to AudioService clients.
    _player.playbackEventStream.listen(_broadcastState);
    // In this example, the service stops when reaching the end.
    _player.processingStateStream.listen((state) {
      if (state == ProcessingState.completed) stop();
    });
    try {
      // After a cold restart (on Android), _player.load jumps straight from
      // the loading state to the completed state. Inserting a delay makes it
      // work. Not sure why!
      //await Future.delayed(Duration(seconds: 2)); // magic delay
      await _player.setAudioSource(ConcatenatingAudioSource(
        children: queue.value!
            .map((item) => AudioSource.uri(Uri.parse(item.id)))
            .toList(),
      ));
    } catch (e) {
      // ignore: avoid_print
      print("Error: $e");
    }
  }

  @override
  Future<List<MediaItem>> getChildren(String parentMediaId,
      [Map<String, dynamic>? options]) async {
    switch (parentMediaId) {
      case AudioService.recentRootId:
      // When the user resumes a media session, tell the system what the most
      // recently played item was.
        return _recentSubject.value!;
      default:
      // Allow client to browse the media library.
        return _mediaLibrary.items[parentMediaId]!;
    }
  }

  @override
  ValueStream<Map<String, dynamic>> subscribeToChildren(String parentMediaId) {
    switch (parentMediaId) {
      case AudioService.recentRootId:
        final stream = _recentSubject.map((_) => <String, dynamic>{});
        return _recentSubject.hasValue
            ? stream.shareValueSeeded(<String, dynamic>{})
            : stream.shareValue();
      default:
        return Stream.value(_mediaLibrary.items[parentMediaId])
            .map((_) => <String, dynamic>{})
            .shareValue();
    }
  }

  @override
  Future<void> skipToQueueItem(int index) async {
    // Then default implementations of skipToNext and skipToPrevious provided by
    // the [QueueHandler] mixin will delegate to this method.
    if (index < 0 || index >= queue.value!.length) return;
    // This jumps to the beginning of the queue item at newIndex.
    _player.seek(Duration.zero, index: index);
    // Demonstrate custom events.
    customEvent.add('skip to $index');
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  @override
  Future<void> stop() async {
    await _player.stop();
    await playbackState.firstWhere(
            (state) => state.processingState == AudioProcessingState.idle);
  }

  /// 向所有客戶端廣播當前狀態。
  void _broadcastState(PlaybackEvent event) {
    final playing = _player.playing;
    playbackState.add(playbackState.value!.copyWith(
      controls: [
        MediaControl.skipToPrevious,
        if (playing) MediaControl.pause else MediaControl.play,
        MediaControl.stop,
        MediaControl.skipToNext,
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
      playing: playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: event.currentIndex,
    ));
  }
}

/// 提供對媒體項目庫的訪問。 在您的應用中，這可能會出現
/// 來自數據庫或 Web 服務。
class MediaLibrary {
  static const albumsRootId = 'albums';

  final items = <String, List<MediaItem>>{
    AudioService.browsableRootId: const [
      MediaItem(
        id: albumsRootId,
        title: "Albums",
        playable: false,
      ),
    ],
    albumsRootId: [
      MediaItem(
        id: 'https://s3.amazonaws.com/scifri-episodes/scifri20181123-episode.mp3',
        album: "Science Friday",
        title: "向令人頭疼的科學致敬",
        artist: "科學星期五和 WNYC 工作室",
        duration: const Duration(milliseconds: 5739820),
        artUri: Uri.parse('https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg'),
      ),
      MediaItem(
        id: 'https://s3.amazonaws.com/scifri-segments/scifri201711241.mp3',
        album: "Science Friday",
        title: "從貓流變到操作無能",
        artist: "科學星期五和 WNYC 工作室",
        duration: const Duration(milliseconds: 2856950),
        artUri: Uri.parse('https://media.wnyc.org/i/1400/1400/l/80/1/ScienceFriday_WNYCStudios_1400.jpg'),
      ),
    ],
  };
}

/// 此任務定義了使用以下方法說出一系列數字的邏輯
/// 文字轉語音。
class TextPlayerHandler extends BaseAudioHandler with QueueHandler {
  final _tts = Tts();
  final _sleeper = Sleeper();
  Completer<void>? _completer;
  var _index = 0;
  bool _interrupted = false;
  var _running = false;

  bool get _playing => playbackState.value!.playing;

  TextPlayerHandler() {
    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    // 處理音頻中斷。
    session.interruptionEventStream.listen((event) {
      if (event.begin) {
        if (_playing) {
          pause();
          _interrupted = true;
        }
      } else {
        switch (event.type) {
          case AudioInterruptionType.pause:
          case AudioInterruptionType.duck:
            if (!_playing && _interrupted) {
              play();
            }
            break;
          case AudioInterruptionType.unknown:
            break;
        }
        _interrupted = false;
      }
    });
    // Handle unplugged headphones.
    session.becomingNoisyEventStream.listen((_) {
      if (_playing) pause();
    });
    queue.add(List.generate(
        10,
            (i) => MediaItem(
          id: 'tts_${i + 1}',
          album: 'Numbers',
          title: 'Number ${i + 1}',
          artist: 'Sample Artist',
          extras: <String, int>{'number': i + 1},
          duration: const Duration(seconds: 1),
        )));
  }

  Future<void> run() async {
    _completer = Completer<void>();
    _running = true;
    while (_running) {
      try {
        if (_playing) {
          mediaItem.add(queue.value![_index]);
          playbackState.add(playbackState.value!.copyWith(
            updatePosition: Duration.zero,
            queueIndex: _index,
          ));
          AudioService.androidForceEnableMediaButtons();
          await Future.wait([
            _tts.speak('${mediaItem.value!.extras!["number"]}'),
            _sleeper.sleep(const Duration(seconds: 1)),
          ]);
          if (_index + 1 < queue.value!.length) {
            _index++;
          } else {
            _running = false;
          }
        } else {
          await _sleeper.sleep();
        }
        // ignore: empty_catches
      } on SleeperInterruptedException {
        // ignore: empty_catches
      } on TtsInterruptedException {}
    }
    _index = 0;
    mediaItem.add(queue.value![_index]);
    playbackState.add(playbackState.value!.copyWith(
      updatePosition: Duration.zero,
    ));
    if (playbackState.value!.processingState != AudioProcessingState.idle) {
      stop();
    }
    _completer?.complete();
    _completer = null;
  }

  @override
  Future<void> skipToQueueItem(int index) async {
    _index = index;
    _signal();
  }

  @override
  Future<void> play() async {
    if (_playing) return;
    final session = await AudioSession.instance;
    // flutter_tts 不會激活會話，所以我們在這裡做。
    // 這個允許應用程序在我們播放時停止其他應用程序播放音頻
    // 播放音頻。
    if (await session.setActive(true)) {
      // 如果我們成功激活了會話，將狀態設置為正在播放
      // 並恢復播放。
      playbackState.add(playbackState.value!.copyWith(
        controls: [MediaControl.pause, MediaControl.stop],
        processingState: AudioProcessingState.ready,
        playing: true,
      ));
      if (_completer == null) {
        run();
      } else {
        _sleeper.interrupt();
      }
    }
  }

  @override
  Future<void> pause() async {
    _interrupted = false;
    playbackState.add(playbackState.value!.copyWith(
      controls: [MediaControl.play, MediaControl.stop],
      processingState: AudioProcessingState.ready,
      playing: false,
    ));
    _signal();
  }

  @override
  Future<void> stop() async {
    playbackState.add(playbackState.value!.copyWith(
      controls: [],
      processingState: AudioProcessingState.idle,
      playing: false,
    ));
    _running = false;
    _signal();
    // 等待語音停止
    await _completer?.future;
    // 關閉這個任務
    await super.stop();
  }

  void _signal() {
    _sleeper.interrupt();
    _tts.interrupt();
  }
}

/// 執行可中斷睡眠的對象。
class Sleeper {
  Completer<void>? _blockingCompleter;

  /// 休眠一段時間。 如果睡眠被中斷，將拋出 [SleeperInterruptedException]。
  Future<void> sleep([Duration? duration]) async {
    _blockingCompleter = Completer();
    if (duration != null) {
      await Future.any<void>(
          [Future.delayed(duration), _blockingCompleter!.future]);
    } else {
      await _blockingCompleter!.future;
    }
    final interrupted = _blockingCompleter!.isCompleted;
    _blockingCompleter = null;
    if (interrupted) {
      throw SleeperInterruptedException();
    }
  }

  /// 中斷任何正在進行的睡眠。
  void interrupt() {
    if (_blockingCompleter?.isCompleted == false) {
      _blockingCompleter!.complete();
    }
  }
}

class SleeperInterruptedException {}

/// FlutterTts 的包裝器，可以更輕鬆地等待語音
/// 完全的。
class Tts {
  final FlutterTts _flutterTts = FlutterTts();
  Completer<void>? _speechCompleter;
  bool _interruptRequested = false;
  bool _playing = false;

  Tts() {
    _flutterTts.setCompletionHandler(() {
      _speechCompleter?.complete();
    });
  }

  bool get playing => _playing;

  Future<void> speak(String text) async {
    _playing = true;
    if (!_interruptRequested) {
      _speechCompleter = Completer();
      await _flutterTts.speak(text);
      await _speechCompleter!.future;
      _speechCompleter = null;
    }
    _playing = false;
    if (_interruptRequested) {
      _interruptRequested = false;
      throw TtsInterruptedException();
    }
  }

  Future<void> stop() async {
    if (_playing) {
      await _flutterTts.stop();
      _speechCompleter?.complete();
    }
  }

  void interrupt() {
    if (_playing) {
      _interruptRequested = true;
      stop();
    }
  }
}

class TtsInterruptedException {}