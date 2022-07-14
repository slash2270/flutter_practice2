import 'package:flutter/material.dart';

import 'package:reorderables/reorderables.dart';

class ReoderablesRowWidget extends StatefulWidget {
  const ReoderablesRowWidget({Key? key}) : super(key: key);

  @override
  _ReoderablesRowWidgetState createState() => _ReoderablesRowWidgetState();
}

class _ReoderablesRowWidgetState extends State<ReoderablesRowWidget> {
  late List<Widget> _columns;

  @override
  void initState() {
    super.initState();
    _columns = <Widget>[
      Image.asset('assets/river1.jpg', key: const ValueKey('river1.jpg')),
      Image.asset('assets/river2.jpg', key: const ValueKey('river2.jpg')),
      Image.asset('assets/river3.jpg', key: const ValueKey('river3.jpg')),
    ];
  }

  @override
  Widget build(BuildContext context) {
    void _onReorder(int oldIndex, int newIndex) {
      setState(() {
        Widget col = _columns.removeAt(oldIndex);
        _columns.insert(newIndex, col);
      });
    }

    return ReorderableRow(
      crossAxisAlignment: CrossAxisAlignment.start,
      onReorder: _onReorder,
      onNoReorder: (int index) {
        //這個回調是可選的
        debugPrint('${DateTime.now().toString().substring(5, 22)} 重新訂購已取消。 指數:$index');
      },
      children: _columns,
    );
  }
}
