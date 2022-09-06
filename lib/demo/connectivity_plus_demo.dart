import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConnectivityPlusDemo extends StatefulWidget {
  const ConnectivityPlusDemo({Key? key}) : super(key: key);

  @override
  _ConnectivityPlusDemoState createState() => _ConnectivityPlusDemoState();
}

class _ConnectivityPlusDemoState extends State<ConnectivityPlusDemo> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // 平台消息是異步的，所以我們在異步方法中初始化。
  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // 平台消息可能會失敗，所以我們使用 try/catch PlatformException。
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      LogUtil.e('無法檢查連接狀態');
      return;
    }

    // 如果小部件在異步平台時從樹中移除
    // 消息在傳輸中，我們想丟棄回复而不是調用
    // setState 更新我們不存在的外觀。
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Connectivity Plus Demo'),
      ),
      body: Center(
          child: Text('連接狀態: ${_connectionStatus.toString()}')),
    );
  }

}