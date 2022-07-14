import 'package:flutter/material.dart';
import 'package:flutter_practice2/util/function_util.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ListSlidableWidget1 extends StatefulWidget {
  const ListSlidableWidget1({Key? key,}) : super(key: key);

  @override
  State<ListSlidableWidget1> createState() => _ListSlidableWidget1State();
}

class _ListSlidableWidget1State extends State<ListSlidableWidget1> {

  late FunctionUtil _functionUtil;

  @override
  void initState() {
    _functionUtil = FunctionUtil();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverFixedExtentList(
      itemExtent: 50.0,
      delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
          //创建列表项
          return _setListItemView(index);
        },
        childCount: 10,
      ),
    );
    /*return ListView(
          children: [
            _setListItemView();
          ],
    );*/
  }

  Widget _setListItemView(int index){
    return Slidable(
      // 如果 Slidable 是可關閉的，則指定一個鍵。
        key: ValueKey(index),

        // 開始操作窗格位於左側或頂部。
        startActionPane: ActionPane(
          // 動作是用於控制窗格動畫方式的小部件。
          motion: const ScrollMotion(),

          // 窗格可以關閉 Slidable。
          dismissible: DismissiblePane(onDismissed: () {}),

          // 所有動作都在 children 參數中定義。
          children: const [
            // SlidableAction 可以有一個圖標和/或標籤。
            SlidableAction(
              onPressed: doNothing,
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: doNothing,
              backgroundColor: Color(0xFF21B7CA),
              foregroundColor: Colors.white,
              icon: Icons.share,
              label: 'Share',
            ),
          ],
        ),

        // 結束操作窗格位於右側或底部。
        endActionPane: const ActionPane(
          motion: ScrollMotion(),
          children: [
            SlidableAction(
              // An action can be bigger than the others.
              //flex: 2,
              onPressed: doNothing,
              backgroundColor: Color(0xFF7BC043),
              foregroundColor: Colors.white,
              icon: Icons.archive,
              label: 'Archive',
            ),
            SlidableAction(
              onPressed: doNothing,
              backgroundColor: Color(0xFF0392CF),
              foregroundColor: Colors.white,
              icon: Icons.save,
              label: 'Save',
            ),
          ],
        ),

        // Slidable 的子項是用戶在未拖動組件時看到的內容。
        child: Container(
          alignment: Alignment.center,
          color: Colors.blue[100 * (index % 10)],
          child: const Text('Style1', style: TextStyle(color: Colors.black, backgroundColor: Colors.transparent, fontSize: 18.0), textAlign: TextAlign.center,)
        )
    );
  }
}

void doNothing(BuildContext context) {}