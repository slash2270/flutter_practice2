import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

class ReoderablesTableWidget extends StatefulWidget {
  const ReoderablesTableWidget({Key? key}) : super(key: key);

  @override
  _ReoderablesTableWidgetState createState() => _ReoderablesTableWidgetState();
}

class _ReoderablesTableWidgetState extends State<ReoderablesTableWidget> {
  //ReorderableTableRow 的子項必須是 ReorderableTableRow 類型
  late List<ReorderableTableRow> _itemRows;

  @override
  void initState() {
    super.initState();
    var data = [
      ['Alex', 'D', 'B+', 'AA', ''],
      ['Bob', 'AAAAA+', '', 'B', ''],
      ['Cindy', '', 'To Be Confirmed', '', ''],
      ['Duke', 'C-', '', 'Failed', ''],
      ['Ellenina', 'C', 'B', 'A', 'A'],
      ['Floral', '', 'BBB', 'A', 'A'],
    ];

    Widget _textWithPadding(String text) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Text(text, textScaleFactor: 1.1),
      );
    }

    _itemRows = data.map((row) {
      return ReorderableTableRow(
        //a key must be specified for each row
        key: ObjectKey(row),
        mainAxisSize: MainAxisSize.max,
        decoration: BoxDecoration(border: Border.all()),
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          _textWithPadding(row[0]),
          _textWithPadding(row[1]),
          _textWithPadding(row[2]),
          _textWithPadding(row[3]),
        ],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    var headerRow = ReorderableTableRow(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Text('Name', textScaleFactor: 1.5),
          Text('Math', textScaleFactor: 1.5),
          Text('Science', textScaleFactor: 1.5),
          Text('Physics', textScaleFactor: 1.5),
        ]);

    void _onReorder(int oldIndex, int newIndex) {
      setState(() {
        ReorderableTableRow row = _itemRows.removeAt(oldIndex);
        _itemRows.insert(newIndex, row);
      });
    }

    return ReorderableTable(
      header: headerRow,
      borderColor: const Color(0xFFE0E0E0),
      onReorder: _onReorder,
      onNoReorder: (int index) {
        //這個回調是可選的
        debugPrint('${DateTime.now().toString().substring(5, 22)} 重新訂購已取消。 指數:$index');
      },
      children: _itemRows,
    );
  }
}
