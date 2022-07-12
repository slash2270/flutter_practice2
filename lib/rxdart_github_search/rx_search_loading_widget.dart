import 'package:flutter/material.dart';

class RxLoadingWidget extends StatelessWidget {
  const RxLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: FractionalOffset.center,
      child: const CircularProgressIndicator(),
    );
  }
}