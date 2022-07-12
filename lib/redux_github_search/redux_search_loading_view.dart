import 'package:flutter/material.dart';

class ReduxSearchLoadingView extends StatelessWidget {
  const ReduxSearchLoadingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: FractionalOffset.center,
      child: const CircularProgressIndicator(),
    );
  }
}
