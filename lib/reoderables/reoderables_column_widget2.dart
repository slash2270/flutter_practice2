import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

class ReoderablesColumnWidget2 extends StatefulWidget {
  const ReoderablesColumnWidget2({Key? key}) : super(key: key);

  @override
  _ReoderablesColumnWidget2State createState() => _ReoderablesColumnWidget2State();
}

class _ReoderablesColumnWidget2State extends State<ReoderablesColumnWidget2> {
  late List<Widget> _rows;

  @override
  void initState() {
    super.initState();
    _rows = List<Widget>.generate(
        10,
        (int index) => SizedBox(
              key: ValueKey(index),
              child: Center(
                child: Text('這是行$index', textScaleFactor: 1.5),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    void _onReorder(int oldIndex, int newIndex) {
      setState(() {
        Widget row = _rows.removeAt(oldIndex);
        _rows.insert(newIndex, row);
      });
    }

    Widget reorderableColumn = IntrinsicWidth(
        child: ReorderableColumn(
      header: const Text('類似列表的視圖，但支持 IntrinsicWidth'),
      onReorder: _onReorder,
      onNoReorder: (int index) {
        //this callback is optional
        debugPrint('${DateTime.now().toString().substring(5, 22)} 重新訂購已取消。 指數:$index');
      },
//        crossAxisAlignment: CrossAxisAlignment.start,
      children: _rows,
    ));

    return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Transform(
              transform: Matrix4.rotationZ(0),
              alignment: FractionalOffset.center,
              child: Material(
                elevation: 6.0,
                color: Colors.transparent,
                borderRadius: BorderRadius.zero,
                child: Card(child: reorderableColumn),
              ),
            ),
          )
        )
    );
  }
}
