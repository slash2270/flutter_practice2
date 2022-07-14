import 'package:flutter/material.dart';
import 'package:flutter_practice2/widget/search_choices_widget.dart';

class ThirtySevenPage extends StatefulWidget {
  const ThirtySevenPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ThirtySevenPageState();
  }
}

class ThirtySevenPageState extends State<ThirtySevenPage> {

  @override
  Widget build(BuildContext context) {
    return const SearchChoicesWidget();
  }

}