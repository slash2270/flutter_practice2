import 'package:flutter/material.dart';
import 'package:flutter_practice2/widget/gzx_dropdown_menu_widget.dart';

class FortyThreePage extends StatefulWidget {
  const FortyThreePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FortyThreePageState();
  }
}

class FortyThreePageState extends State<FortyThreePage> {

  @override
  Widget build(BuildContext context) {
    return const GZXDropDownMenuWidget();
  }

}