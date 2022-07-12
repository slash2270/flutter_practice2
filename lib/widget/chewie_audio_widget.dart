import 'package:chewie_audio/chewie_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/util/function_util.dart';
import 'package:video_player/video_player.dart';

class ChewieAudioWidget extends StatefulWidget {
  const ChewieAudioWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ChewieAudioWidgetState();
  }
}

class _ChewieAudioWidgetState extends State<ChewieAudioWidget> {
  TargetPlatform? _platform;
  late FunctionUtil _functionUtil;
  late VideoPlayerController _videoPlayerController1;
  late VideoPlayerController _videoPlayerController2;
  ChewieAudioController? _chewieAudioController;

  @override
  void initState() {
    super.initState();
    _functionUtil = FunctionUtil();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayerController1.dispose();
    _videoPlayerController2.dispose();
    _chewieAudioController!.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    _videoPlayerController1 = VideoPlayerController.network('https://www.w3schools.com/html/mov_bbb.mp4');
    _videoPlayerController2 = VideoPlayerController.network('https://assets.mixkit.co/videos/preview/mixkit-a-girl-blowing-a-bubble-gum-at-an-amusement-park-1226-large.mp4');
    await Future.wait([
      _videoPlayerController1.initialize(),
      _videoPlayerController2.initialize()
    ]);
    _chewieAudioController = ChewieAudioController(
      videoPlayerController: _videoPlayerController1,
      autoPlay: true,
      looping: true,
      // 嘗試使用其他一些選項：

      // showControls: false,
      // materialProgressColors: ChewieProgressColors(
      // playColor: Colors.red,
      // handleColor: Colors.blue,
      // backgroundColor: Colors.grey,
      // bufferedColor: Colors.lightGreen,
      // ),
      //佔位符：容器（
      // 顏色：Colors.grey,
      // ),
      // 自動初始化: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          _chewieAudioController != null && _chewieAudioController!.videoPlayerController.value.isInitialized
              ? ChewieAudio(
            controller: _chewieAudioController!,
          )
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              _functionUtil.initSizedBox(20),
              _functionUtil.initText('載入中...'),
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      if (_chewieAudioController != null) {
                        _chewieAudioController!.dispose();
                      }
                      _videoPlayerController1.pause();
                      _videoPlayerController1.seekTo(const Duration());
                      _chewieAudioController = ChewieAudioController(
                        videoPlayerController: _videoPlayerController1,
                        autoPlay: true,
                        looping: true,
                      );
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: _functionUtil.initText("聲音 1"),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      if (_chewieAudioController != null) {
                        _chewieAudioController!.dispose();
                      }
                      _videoPlayerController2.pause();
                      _videoPlayerController2.seekTo(const Duration());
                      _chewieAudioController = ChewieAudioController(
                        videoPlayerController: _videoPlayerController2,
                        autoPlay: true,
                        looping: true,
                      );
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: _functionUtil.initText("聲音 2"),
                  ),
                ),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _platform = TargetPlatform.android;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: _functionUtil.initText("Android 控制"),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _platform = TargetPlatform.iOS;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: _functionUtil.initText("iOS 控制"),
                  ),
                ),
              )
            ],
          )
        ],
    );
  }
}