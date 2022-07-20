import 'package:flutter/material.dart';
import 'package:flutter_practice2/widget/gzx_dropdown_menu_widget.dart';

class FortyTwoPage extends StatefulWidget {
  const FortyTwoPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FortyTwoPageState();
  }
}

class FortyTwoPageState extends State<FortyTwoPage> {

  @override
  Widget build(BuildContext context) {
    return const GZXDropDownMenuWidget();
  }

}