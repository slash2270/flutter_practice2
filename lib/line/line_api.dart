import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';

class LineAPIPage extends StatefulWidget {
  const LineAPIPage({Key? key}) : super(key: key);

  @override
  _LineAPIPageState createState() => _LineAPIPageState();
}

class _LineAPIPageState extends State<LineAPIPage> {
  String? _result;
  String? _error;

  @override
  void initState() {
    super.initState();
    _result = '';
    _error = '';
  }

  void _setState(Map<String, dynamic>? data, PlatformException? error) {
    setState(() {
      if (data != null) {
        _result = json.encode(data);
      } else {
        _result = '';
      }

      if (error != null) {
        _error = 'LineApi Error Code: ${error.code}\nError Message: ${error.message}';
      } else {
        _error = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final apis = _getAPIs();
    final isError = _error != '';

    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(16),
                color: const Color.fromARGB(30, 30, 30, 30),
                height: 200,
                child: SingleChildScrollView(
                  child: Text(
                    isError ? _error! : _result!,
                    style:
                    TextStyle(color: isError ? Colors.red : Colors.green),
                  ),
                ),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.separated(
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemCount: apis.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(apis[index].name),
                onTap: () {
                  apis[index].run();
                },
              );
            },
          ),
        ),
      ],
    );
  }

  List<_APIItem> _getAPIs() {
    return [
      _APIItem('獲取個人資料', () async {
        try {
          final result = await LineSDK.instance.getProfile();
          _setState(result.data, null);
        } on PlatformException catch (e) {
          _setState(null, e);
        }
      }),
      _APIItem('獲取當前訪問令牌', () async {
        try {
          final result = await LineSDK.instance.currentAccessToken;
          _setState(result?.data, null);
        } on PlatformException catch (e) {
          _setState(null, e);
        }
      }),
      _APIItem('刷新令牌', () async {
        try {
          final result = await LineSDK.instance.refreshToken();
          _setState(result.data, null);
        } on PlatformException catch (e) {
          _setState(null, e);
        }
      }),
      _APIItem('驗證訪問令牌', () async {
        try {
          final result = await LineSDK.instance.verifyAccessToken();
          _setState(result.data, null);
        } on PlatformException catch (e) {
          _setState(null, e);
        }
      }),
      _APIItem('機器人友誼狀態', () async {
        try {
          final result = await LineSDK.instance.getBotFriendshipStatus();
          _setState(result.data, null);
        } on PlatformException catch (e) {
          _setState(null, e);
        }
      }),
    ];
  }
}

class _APIItem {
  final String name;
  final Function run;
  _APIItem(this.name, this.run);
}