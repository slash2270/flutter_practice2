import 'package:apivideo_live_stream/apivideo_live_stream.dart';
import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_practice2/api_video/setting_screen.dart';

import 'api_video_constants.dart';
import 'api_video_params.dart';

MaterialColor apiVideoOrange = const MaterialColor(0xFFFA5B30, {
  50: Color(0xFFFBDDD4),
  100: Color(0xFFFFD6CB),
  200: Color(0xFFFFD1C5),
  300: Color(0xFFFFB39E),
  400: Color(0xFFFA5B30),
  500: Color(0xFFF8572A),
  600: Color(0xFFF64819),
  700: Color(0xFFEE4316),
  800: Color(0xFFEC3809),
  900: Color(0xFFE53101)
});

class ApiVideoDemo extends StatefulWidget {
  const ApiVideoDemo({Key? key}) : super(key: key);

  @override
  _ApiVideoDemoState createState() => _ApiVideoDemoState();
}

class _ApiVideoDemoState extends State<ApiVideoDemo> with WidgetsBindingObserver {
  final ButtonStyle buttonStyle = ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
  ApiVideoParams config = ApiVideoParams();
  late final LiveStreamController _controller;
  late final Future<int> textureId;

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);

    _controller = initLiveStreamController();
    textureId = _controller.create(initialAudioConfig: config.audio, initialVideoConfig: config.video);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.inactive) {
      _controller.stop();
    } else if (state == AppLifecycleState.resumed) {
      _controller.startPreview();
    }
  }

  LiveStreamController initLiveStreamController() {
    return LiveStreamController(onConnectionSuccess: () {
      LogUtil.e('ApiVideo 連接成功');
    }, onConnectionFailed: (error) {
      LogUtil.e('ApiVideo 無法連接: $error');
      _showDialog(context, '無法連接', error);
      if (mounted) {
        setState(() {});
      }
    }, onDisconnection: () {
      showInSnackBar('無法連接');
      if (mounted) {
        setState(() {});
      }
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('ApiLive Stream Demo'),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (choice) => _onMenuSelected(choice, context),
            itemBuilder: (BuildContext context) {
              return ApiVideoConstants.choices.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(1.0),
                child: Center(
                  child: buildPreview(controller: _controller),
                ),
              ),
            ),
            _controlRowWidget()
          ],
        ),
      ),
    );
  }

  void _onMenuSelected(String choice, BuildContext context) {
    if (choice == ApiVideoConstants.settings) {
      _awaitResultFromSettingsFinal(context);
    }
  }

  void _awaitResultFromSettingsFinal(BuildContext context) async {
    await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SettingsScreen(params: config)));
    _controller.setVideoConfig(config.video);
    _controller.setAudioConfig(config.audio);
  }

  /// 顯示帶有按鈕的控制欄以拍照和錄製視頻。
  Widget _controlRowWidget() {
    final LiveStreamController liveStreamController = _controller;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        IconButton(
          icon: const Icon(Icons.cameraswitch),
          color: apiVideoOrange,
          onPressed:
          liveStreamController != null ? onSwitchCameraButtonPressed : null,
        ),
        IconButton(
          icon: const Icon(Icons.mic_off),
          color: apiVideoOrange,
          onPressed: liveStreamController != null
              ? onToggleMicrophoneButtonPressed
              : null,
        ),
        IconButton(
          icon: const Icon(Icons.fiber_manual_record),
          color: Colors.red,
          onPressed:
          !liveStreamController.isStreaming
              ? onStartStreamingButtonPressed
              : null,
        ),
        IconButton(
          icon: const Icon(Icons.stop),
          color: Colors.red,
          onPressed:
          liveStreamController.isStreaming
              ? onStopStreamingButtonPressed
              : null,
        ),
      ],
    );
  }

  void showInSnackBar(String message) {
    // 忽略：deprecated_member_use
    _scaffoldKey.currentState?.showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> switchCamera() async {
    final LiveStreamController liveStreamController = _controller;

    if (liveStreamController == null) {
      showInSnackBar('錯誤：請先開啟相機控制器');
      return;
    }

    try {
      liveStreamController.switchCamera();
    } catch (error) {
      if (error is PlatformException) {
        _showDialog(
            context, "錯誤", "無法切換相機: ${error.message}");
      } else {
        _showDialog(context, "錯誤", "無法切換相機: $error");
      }
    }
  }

  Future<void> toggleMicrophone() async {
    final LiveStreamController liveStreamController = _controller;

    if (liveStreamController == null) {
      showInSnackBar('錯誤：請先開啟相機控制器');
      return;
    }

    try {
      liveStreamController.toggleMute();
    } catch (error) {
      if (error is PlatformException) {
        _showDialog(
            context, "錯誤", "無法切換靜音: ${error.message}");
      } else {
        _showDialog(context, "錯誤", "無法切換靜音: $error");
      }
    }
  }

  Future<void> startStreaming() async {
    final LiveStreamController liveStreamController = _controller;

    if (liveStreamController == null) {
      showInSnackBar('錯誤：請先開啟相機控制器');
      return;
    }

    try {
      await liveStreamController.startStreaming(
          streamKey: config.streamKey, url: config.rtmpUrl);
    } catch (error) {
      if (error is PlatformException) {
        LogUtil.e('ApiVideo 錯誤：無法啟動流: ${error.message}');
      } else {
            LogUtil.e('ApiVideo 錯誤：無法啟動流: $error');
      }
    }
  }

  Future<void> stopStreaming() async {
    final LiveStreamController liveStreamController = _controller;

    if (liveStreamController == null) {
      showInSnackBar('錯誤：首先創建一個相機控制器。');
      return;
    }

    try {
      liveStreamController.stopStreaming();
    } catch (error) {
      if (error is PlatformException) {
        _showDialog(
            context, "錯誤", "無法停止直播: ${error.message}");
      } else {
        _showDialog(context, "錯誤", "無法停止直播: $error");
      }
    }
  }

  void onSwitchCameraButtonPressed() {
    switchCamera().then((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  void onToggleMicrophoneButtonPressed() {
    toggleMicrophone().then((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  void onStartStreamingButtonPressed() {
    startStreaming().then((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  void onStopStreamingButtonPressed() {
    stopStreaming().then((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  Widget buildPreview({required LiveStreamController controller}) {
    // Wait for [LiveStreamController.create] to finish.
    return FutureBuilder<int>(
        future: textureId,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          if (!snapshot.hasData) {
            // while data is loading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return CameraPreview(controller: controller);
          }
        });
  }
}

Future<void> _showDialog(
    BuildContext context, String title, String description) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: SingleChildScrollView(
          child: Text(description),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('解僱'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}