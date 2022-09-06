import 'package:http/http.dart' as http;
import 'package:gbk2utf8/gbk2utf8.dart';
import 'package:flutter/material.dart';

class GBK2utf8Demo extends StatefulWidget {
  const GBK2utf8Demo({Key? key}) : super(key: key);

  @override
  _GBK2utf8DemoState createState() => _GBK2utf8DemoState();
}

class _GBK2utf8DemoState extends State<GBK2utf8Demo> {
  String _text = "正在下載數據...";

  void download() async {
    try {
      http.Response response = await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
      String data = gbk.decode(response.bodyBytes);
      setState(() {
        _text = data;
      });
    } catch (e) {
      setState(() {
        _text = "網絡異常，請檢查";
      });
    }
  }

  @override
  void initState() {
    download();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('gbk2utf8 Demo'),
      ),
      body: SingleChildScrollView(
        child: Text(_text),
      ), // 這個尾隨逗號使構建方法的自動格式化更好。
    );
  }
}