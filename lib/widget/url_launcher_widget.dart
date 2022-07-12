import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherDemo extends StatefulWidget {
  const UrlLauncherDemo({Key? key}) : super(key: key);

  @override
  State<UrlLauncherDemo> createState() => _UrlLauncherDemoState();
}

class _UrlLauncherDemoState extends State<UrlLauncherDemo> {
  List<Map> buttons = [
    {'title': '打开浏览器', 'scheme': 'https://www.baidu.com'},
    {'title': '打开地图', 'scheme': 'geo:52.32.4.917'},
    {'title': '打开微信', 'scheme': 'weixin://'},
    {'title': '打开京东', 'scheme': 'openapp.jdmoble://'},
    {'title': '打开淘宝', 'scheme': 'taobao://'},
    {'title': '打开百度地图', 'scheme': ' baidumap://'},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            Column(
              children: buttons
                  .map((item) => _launchButton(
                  title: item['title'],
                  scheme: item['scheme'],
                  context: context))
                  .toList(),
            ),
          ],
        );
  }

  void _launchURL() async {
    const url = 'https://baidu.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {}
  }

  void _launchMap() async {
    //android
    const url = 'geo:52.32.4.917'; //App 提供的 schema
    if (await canLaunch(url)) {
      await launch(url);
    } else {}
  }

  Widget _launchButton(
      {required String title,
        required String scheme,
        required BuildContext context}) {
    return FlatButton(
      onPressed: () {
        _launchScheme(scheme: scheme, context: context);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 18),
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xff88ff22),
          borderRadius: BorderRadius.circular(25),
          boxShadow: const [
            BoxShadow(
                color: Colors.redAccent, blurRadius: 3, offset: Offset(0, 1))
          ],
        ),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  void _launchScheme(
      {required String scheme, required BuildContext context}) async {
    if (await canLaunch(scheme)) {
      await launch(scheme);
    } else {
      LogUtil.e('不支援開啟');

      // 需要设置Scaffold的key才能弹出SnackBar
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('無法開啟'),
      ));

      // Scaffold.of(context).showSnackBar(SnackBar(
      //   content: Text('老孟，一枚有态度的程序员'),
      // ));
    }
  }
}