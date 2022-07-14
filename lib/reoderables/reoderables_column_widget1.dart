import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

class ReoderablesColumnWidget1 extends StatefulWidget {
  const ReoderablesColumnWidget1({Key? key}) : super(key: key);

  @override
  _ReoderablesColumnWidget1State createState() => _ReoderablesColumnWidget1State();
}

class _ReoderablesColumnWidget1State extends State<ReoderablesColumnWidget1> {
  late List<Widget> _rows;

  @override
  void initState() {
    super.initState();

    _rows = List<ReorderableWidget>.generate(
        10,
        (int index) => ReorderableWidget(
              reorderable: true,
              key: ValueKey(index),
              child: SizedBox(
                  width: double.infinity,
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text('這是行$index', textScaleFactor: 1.5))),
            ));

    _rows += <ReorderableWidget>[
      ReorderableWidget(
        reorderable: false,
        key: const ValueKey(10),
        child: const Text('此行不可重新排序', textScaleFactor: 2),
      )
    ];

    _rows += List<ReorderableWidget>.generate(
        40,
        (int index) => ReorderableWidget(
              reorderable: true,
              key: ValueKey(11 + index),
              child: SizedBox(
                width: double.infinity,
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text('這是行$index', textScaleFactor: 1.5)),
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

    return ReorderableColumn(
      header: const Text('這是標題行'),
      footer: const Text('這是頁腳行'),
      crossAxisAlignment: CrossAxisAlignment.start,
      onReorder: _onReorder,
      onNoReorder: (int index) {
        //this callback is optional
        debugPrint('${DateTime.now().toString().substring(5, 22)} reorder cancelled. index:$index');
      },
      children: _rows,
    );
  }
}
