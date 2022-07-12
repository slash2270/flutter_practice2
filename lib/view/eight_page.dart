import 'package:flutter/material.dart';
import 'package:flutter_practice2/demo/staggered_grid_view_demo.dart';
import 'package:flutter_practice2/util/constants.dart';
import 'package:flutter_practice2/util/function_util.dart';
import 'package:flutter_practice2/widget/list_slidable_widget1.dart';

import '../widget/list_slidable_widget4.dart';

class EightPage extends StatefulWidget {
  const EightPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return EightPageState();
  }
}

class EightPageState extends State<EightPage> {

  late FunctionUtil _functionUtil;

  @override
  void initState() {
    _functionUtil = FunctionUtil();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = SliverAppBar(
      title: const Text('Eight Page'),
      pinned: true, // 固定在顶部
      centerTitle: true,
      floating: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: () {
            Navigator.pushNamed(context, Constants.routeHome);
          },
        ),
      ],
    );
    final paddingGridText = _setPadding('StaggeredGridView 交錯網格');
    final paddingGrid = SliverPadding(
      padding: _functionUtil.initEdgeInsetsTop(20.0),
      sliver: const StaggeredGridViewDemo()
    );
    final paddingListText = _setPadding('SlidableListView 上下左右滑列表');
    final paddingList1 = SliverPadding(
        padding: _functionUtil.initEdgeInsetsTop(20.0),
        sliver: const ListSlidableWidget1()
    );
    final paddingList4 = SliverPadding(
        padding: _functionUtil.initEdgeInsetsTop(20.0),
        sliver: const ListSlidableWidget4()
    );
    return Material(
      child: CustomScrollView(
          slivers: [
              appBar,
              paddingGridText,
              paddingGrid,
              paddingListText,
              paddingList1,
              _setSizeBox(),
              paddingList4,
              _setSizeBox(),
              _setSizeBox(),
            ]
      ),
    );
  }

  Widget _setPadding(String title){
    return SliverPadding(
        padding: _functionUtil.initEdgeInsetsTop(20.0),
        sliver: SliverToBoxAdapter(
          child: _functionUtil.initText2(title, Colors.black, Colors.transparent, 24),
        ),
    );
  }

  Widget _setSizeBox(){
    return SliverToBoxAdapter(
      child: _functionUtil.initSizedBox(20.0),
    );
  }

}