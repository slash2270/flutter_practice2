import 'package:flutter/material.dart';

import '../util/constants.dart';
import './reoderables_column_widget1.dart';
import './reoderables_column_widget2.dart';
import './reoderables_nested_wrap_widget.dart';
import './reoderables_row_widget.dart';
import './reoderables_sliver_widget.dart';
import './reoderables_table_widget.dart';
import './reoderables_wrap_widget.dart';

class ReoderablesDemo extends StatefulWidget {
  const ReoderablesDemo({Key? key}) : super(key: key);

  // 這個小部件是您的應用程序的主頁。 它是有狀態的，意思是它有一個 State 對象（定義如下），其中包含影響的字段它看起來如何。
  // 這個類是狀態的配置。 它保存值（在這個由父級（在本例中為 App 小部件）提供的標題）和由 State 的 build 方法使用。 Widget 子類中的字段是始終標記為“最終”。

  @override
  _ReoderablesDemoState createState() => _ReoderablesDemoState();
}

class _ReoderablesDemoState extends State<ReoderablesDemo> {
  int _currentIndex = 0;
  final List<Widget> _examples = [
    const ReoderablesTableWidget(),
    const ReoderablesWrapWidget(),
    ReoderablesNestedWrapWidget(),
    const ReoderablesColumnWidget1(),
    const ReoderablesColumnWidget2(),
    const ReoderablesRowWidget(),
    const ReoderablesSliverWidget(),
  ];
  final _bottomNavigationColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ThirtyFive Page'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, Constants.routeHome);
            },
          ),
        ],
      ),
      body: _examples[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: _bottomNavigationColor,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        currentIndex: _currentIndex,
        // 這將在點擊新標籤時設置
        // 類型：BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.grid_on, color: _bottomNavigationColor),
              tooltip: "Reorderable Table",
              label: "Table"),
          BottomNavigationBarItem(
              icon: Icon(Icons.apps, color: _bottomNavigationColor),
              tooltip: "Reorderable Wrap",
              label: "Wrap"),
          BottomNavigationBarItem(
              icon: Icon(Icons.view_quilt, color: _bottomNavigationColor),
              tooltip: 'Nested Reroderable Wrap',
              label: "Nested"),
          BottomNavigationBarItem(
              icon: Icon(Icons.more_vert, color: _bottomNavigationColor),
              tooltip: "Reorderable Column 1",
              label: "Column 1"),
          BottomNavigationBarItem(
              icon: Icon(Icons.more_vert, color: _bottomNavigationColor),
              tooltip: "Reroderable Column 2",
              label: "Column 2"),
          BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz, color: _bottomNavigationColor),
              tooltip: "Reorderable Row",
              label: "Row"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_view_day, color: _bottomNavigationColor),
              tooltip: "Reroderable SliverList",
              label: "SliverList"),
        ],
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}
