import 'package:flutter/material.dart';
import 'package:flutter_practice2/widget/gzx_dropdown_menu_widget.dart';

class FortyFourPage extends StatefulWidget {
  const FortyFourPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FortyFourPageState();
  }
}

class FortyFourPageState extends State<FortyFourPage> {

  @override
  Widget build(BuildContext context) {
    return const GZXDropDownMenuWidget();
  }

}