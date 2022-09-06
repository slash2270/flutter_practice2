import 'package:flutter/services.dart';

class FlutterRtmpPlugin {
//1、创建channel
  static const MethodChannel _channel = MethodChannel('flutter_rtmp_plugin');
//2、开始直播的api，参数为推流地址
  static startLive(String url) async {
    await _channel.invokeMethod('startLive', {"url" : url});
  }

}