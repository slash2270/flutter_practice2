import 'package:flutter/material.dart';
import 'package:flutter_practice2/util/function_util.dart';

class InstagramTokenView extends StatelessWidget {
  const InstagramTokenView({Key? key, required this.token, required this.name}) : super(key: key);
  final String token;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome $name'),
      ),
      body: Center(
        child: FunctionUtil().initText2('Token: $token', Colors.black, Colors.transparent, 20),
      ),
    );
  }
}