import 'package:flutter/material.dart';
import 'package:reorderables/reorderables.dart';

class ReoderablesSliverWidget extends StatefulWidget {
  const ReoderablesSliverWidget({Key? key}) : super(key: key);

  @override
  _ReoderablesSliverWidgetState createState() => _ReoderablesSliverWidgetState();
}

class _ReoderablesSliverWidgetState extends State<ReoderablesSliverWidget> {
  late List<Widget> _rows;

  @override
  void initState() {
    super.initState();
    _rows = List<Widget>.generate(
        50,
        (int index) => SizedBox(
            width: double.infinity,
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text('這是銀孩兒$index', textScaleFactor: 2))));
  }

  @override
  Widget build(BuildContext context) {
    void _onReorder(int oldIndex, int newIndex) {
      setState(() {
        Widget row = _rows.removeAt(oldIndex);
        _rows.insert(newIndex, row);
      });
    }

    // 確保有一個滾動控制器附加到包含 ReorderableSliverList 的滾動視圖。
    // 否則會拋出錯誤。
    ScrollController _scrollController = PrimaryScrollController.of(context) ?? ScrollController();

    return CustomScrollView(
      // ScrollController 必須包含在 CustomScrollView 中，否則ReorderableSliverList 不起作用
      controller: _scrollController,
      slivers: <Widget>[
        SliverAppBar(
          expandedHeight: 210.0,
          flexibleSpace: FlexibleSpaceBar(
            title: const Text('Reorderable SliverList'),
            background: Image.network(
                'https://upload.wikimedia.org/wikipedia/commons/thumb/6/68/Yushan'
                '_main_east_peak%2BHuang_Chung_Yu%E9%BB%83%E4%B8%AD%E4%BD%91%2B'
                '9030.png/640px-Yushan_main_east_peak%2BHuang_Chung_Yu%E9%BB%83'
                '%E4%B8%AD%E4%BD%91%2B9030.png'),
          ),
        ),
        ReorderableSliverList(
          delegate: ReorderableSliverChildListDelegate(_rows),
          // 或者如果需要使用 ReorderableSliverChildBuilderDelegate
          // 委託：ReorderableSliverChildBuilderDelegate(
          // (BuildContext context, int index) => _rows[index],
          // childCount: _rows.length),
          onReorder: _onReorder,
          onNoReorder: (int index) { //這個回調是可選的
            debugPrint('${DateTime.now().toString().substring(5, 22)} 重新訂購已取消。 指數:$index');
          },
          onReorderStarted: (int index) {
            debugPrint('${DateTime.now().toString().substring(5, 22)} 重新訂購已取消。 指數:$index');
          },
        )
      ],
    );
  }
}
