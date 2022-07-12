import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_practice2/util/constants.dart';
import 'package:flutter_practice2/util/function_util.dart';

class CookieJarWidget extends StatefulWidget {
  const CookieJarWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CookieJarWidgetState();
  }
}

class CookieJarWidgetState extends State<CookieJarWidget> {

  late FunctionUtil _functionUtil;
  String _result1 = '', _result2 = '', _result3 = '', _result4 = '';

  @override
  void initState() {
    _functionUtil = FunctionUtil();
    _initCookie();
    super.initState();
  }

  _initCookie() async{
    final cookies = <Cookie>[
      Cookie('name', 'wendux'),
      Cookie('location', 'china'),
    ];
    final cookiesExpired = <Cookie>[
      Cookie('name', 'wendux')..maxAge = 1,
      Cookie('location', 'china')..expires = DateTime.now().add(const Duration(hours: 1)),
    ];
    //final cj = CookieJar();
    //final cj = PersistCookieJar();
    final cj = PersistCookieJar(storage: FileStorage('./example/.cookies'));
    await cj.saveFromResponse(Uri.parse('https://google.com'), cookies);
    var results = await cj.loadForRequest(Uri.parse('https://www.baidu.com/'));
    assert(results.length == 2);
    results = await cj.loadForRequest(Uri.parse('https://www.google.com/doodles'));
    LogUtil.e('Cookie Jar $_result1');
    assert(results.length == 2);
    results = await cj.loadForRequest(Uri.parse('https://www.google.com.sg/imghp?hl=zh-TW&ogbl'));
    LogUtil.e('Cookie Jar $_result2');
    assert(results.isEmpty);
    await cj.saveFromResponse(Uri.parse('https://google.com'), cookiesExpired);
    results = await cj.loadForRequest(Uri.parse('https://google.com'));
    LogUtil.e('Cookie Jar $_result3');
    assert(results.length == 2);
    await Future<void>.delayed(const Duration(seconds: 2), () async {
    results = await cj.loadForRequest(Uri.parse('https://google.com'));
    LogUtil.e('Cookie Jar $_result4');
    assert(results.length == 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _functionUtil.initText2(_result1, Constants.colorBlack, Constants.colorTransparent, 20),
        _functionUtil.initText2(_result2, Constants.colorBlack, Constants.colorTransparent, 20),
        _functionUtil.initText2(_result3, Constants.colorBlack, Constants.colorTransparent, 20),
        _functionUtil.initText2(_result4, Constants.colorBlack, Constants.colorTransparent, 20),
      ],
    );
  }

}