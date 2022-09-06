// @dart = 2.9
import 'dart:async';
import 'dart:io';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart' show ImagePicker, ImageSource;
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';

class VideoCompressDemo extends StatefulWidget {
  const VideoCompressDemo({Key key}) : super(key: key);

  @override
  _VideoCompressState createState() => _VideoCompressState();
}

class _VideoCompressState extends State<VideoCompressDemo> {

  Subscription _subscription;

  Image _thumbnailFileImage;
  Image _gifFileImage;

  MediaInfo _originalVideoInfo = MediaInfo(path: '');
  MediaInfo _compressedVideoInfo = MediaInfo(path: '');
  String _taskName;
  double _progressState = 0;

  final _loadingStreamCtrl = StreamController<bool>.broadcast();

  @override
  void initState() {
    super.initState();
    _subscription =
        VideoCompress.compressProgress$.subscribe((progress) {
          setState(() {
            _progressState = progress;
          });
        });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.unsubscribe();
    _loadingStreamCtrl.close();
  }

  Future<void> runFlutterVideoCompressMethods(File videoFile) async {
    _loadingStreamCtrl.sink.add(true);

    final now = DateTime.now();

    var startDateTime = DateTime.now();
    _taskName = '[Compressing Video]';
    LogUtil.e('壓縮影片開始');
    final compressedVideoInfo = await VideoCompress.compressVideo(
      videoFile.path,
      quality: VideoQuality.DefaultQuality,
      deleteOrigin: false,
    );
    LogUtil.e('壓縮影片完成! ${now.difference(startDateTime).inSeconds}s');
    _taskName = null;

    startDateTime = DateTime.now();
    _taskName = '[Compressing Image]';
    LogUtil.e('取得壓縮圖片開始');
    final thumbnailFile = await VideoCompress.getFileThumbnail(videoFile.path, quality: 50);
    LogUtil.e('取得壓縮圖片完成! ${now.difference(startDateTime).inSeconds}s');
    _taskName = null;

    // startDateTime = DateTime.now();
    // LogUtil.e('取得Gif文件開始');
    // _taskName = '[Getting Gif File]';
    // final gifFile = await VideoCompress.convertVideoToGif(videoFile.path, startTime: 0, duration: 5);
    // LogUtil.e('取得Gif文件完成! ${now.difference(startDateTime).inSeconds}s');
    // _taskName = null;

    final videoInfo = await VideoCompress.getMediaInfo(videoFile.path);

    setState(() {
      _thumbnailFileImage = Image.file(thumbnailFile);
      // _gifFileImage = Image.file(gifFile);
      _originalVideoInfo = videoInfo;
      _compressedVideoInfo = compressedVideoInfo;
    });
    _loadingStreamCtrl.sink.add(false);
  }

  Widget _buildMaterialWarp(Widget body) {
    return Scaffold(
          appBar: AppBar(
            title: const Text('Video Compress Demo'),
            actions: <Widget>[
              IconButton(
                onPressed: () async {
                  await VideoCompress.deleteAllCache();
                },
                icon: const Icon(Icons.delete_forever),
              ),
            ],
          ),
          body: body
    );
  }

  Widget _buildRoundedRectangleButton(String text, ImageSource source) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: RaisedButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        color: Colors.grey[800],
        onPressed: () async {
          final videoFile = await ImagePicker().pickVideo(source: source);
          if (videoFile != null) {
            runFlutterVideoCompressMethods(File(videoFile.path));
          }
        },
        child: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  String _infoConvert(MediaInfo info) {
    return 'path: ${info.path}\n'
        'duration: ${info.duration} microseconds\n'
        'size: ${info.filesize} bytes\n'
        'size: ${info.width} x ${info.height}\n'
        'orientation: ${info.orientation}°\n'
        'compression cancelled: ${info.isCancel}\n'
        'author: ${info.author}';
  }

  List<Widget> _buildInfoPanel(String title,
      {MediaInfo info, Image image, bool isVideoModel = false}) {
    if (info?.file == null && image == null && !isVideoModel) return [];
    return [
      if (!isVideoModel || info?.file != null)
        Card(
          child: ListTile(
            title: Text(title),
            dense: true,
          ),
        ),
      if (info?.file != null)
        Padding(
          padding: const EdgeInsets.all(8),
          child: Text(_infoConvert(info)),
        ),
      if (image != null) image,
      if (isVideoModel && info?.file != null) VideoPlayerView(file: info.file)
    ];
  }

  @override
  Widget build(context) {
    return _buildMaterialWarp(
      Stack(children: <Widget>[
        ListView(
          children: <Widget>[
            const SizedBox(height: 20),
            _buildRoundedRectangleButton(
              '使用圖像選擇器從相機中獲取視頻',
              ImageSource.camera,
            ),
            _buildRoundedRectangleButton(
              '使用圖像選擇器從圖庫中獲取視頻',
              ImageSource.gallery,
            ),
            ..._buildInfoPanel(
              '原始視頻信息',
              info: _originalVideoInfo,
            ),
            ..._buildInfoPanel(
              '原始視頻視圖',
              info: _originalVideoInfo,
              isVideoModel: true,
            ),
            ..._buildInfoPanel(
              '壓縮視頻信息',
              info: _compressedVideoInfo,
            ),
            ..._buildInfoPanel(
              '壓縮視頻視圖',
              info: _compressedVideoInfo,
              isVideoModel: true,
            ),
            ..._buildInfoPanel(
              '文件預覽中的縮略圖',
              image: _thumbnailFileImage,
            ),
            ..._buildInfoPanel(
              '來自原始視頻預覽的 Gif 圖像',
              image: _gifFileImage,
            ),
          ].expand((widget) {
            if (widget is SizedBox || widget is Card) {
              return [widget];
            }
            return [widget, const SizedBox(height: 8)];
          }).toList(),
        ),
        StreamBuilder<bool>(
          stream: _loadingStreamCtrl.stream,
          builder: (context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.data == true) {
              return GestureDetector(
                onTap: () {
                  VideoCompress.cancelCompression();
                },
                child: Card(
                  child: Container(
                    color: Colors.black54,
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        const CircularProgressIndicator(),
                        if (_taskName != null)
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Text('[$_taskName] $_progressState％'),
                          ),
                        const Padding(
                          padding: EdgeInsets.all(8),
                          child: Text('點擊取消...'),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }
            return Container();
          },
        ),
      ]),
    );
  }
}

class VideoPlayerView extends StatefulWidget {
  const VideoPlayerView({Key key, this.file}) : super(key: key);

  final File file;

  @override
  _VideoPlayerViewState createState() => _VideoPlayerViewState();
}

class _VideoPlayerViewState extends State<VideoPlayerView> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.file)
      ..initialize().then((_) {
        setState(() {});
      })
      ..setVolume(1)
      ..play();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _controller.value.isPlaying
              ? _controller.pause()
              : _controller.play();
        });
      },
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Stack(
              alignment: Alignment.center,
              children: <Widget>[
                _controller.value.isInitialized
                    ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
                    : Container(),
                Icon(
                  _controller.value.isPlaying ? null : Icons.play_arrow,
                  size: 80,
                ),
              ],
            ),
            VideoProgressIndicator(
              _controller,
              allowScrubbing: true,
              colors: const VideoProgressColors(
                playedColor: Color.fromRGBO(255, 255, 255, 0.1),
              ),
            ),
          ],
        ),
      ),
    );
  }
}