import 'package:flutter/material.dart';
import 'package:flutter_practice2/map/search_bar_widget.dart';

import '../util/function_util.dart';

class SearchBarPage extends StatefulWidget {
  const SearchBarPage({Key? key}) : super(key: key);

  @override
  _SearchBarPageState createState() => _SearchBarPageState();
}

class _SearchBarPageState extends State<SearchBarPage> {

  late FunctionUtil _functionUtil;

  @override
  void initState() {
    super.initState();
    _functionUtil = FunctionUtil();
    /*_setAnimationController();
    _initAnimation();
    _startAnimation();*/
  }

  @override
  void dispose() {
    // 銷毀
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _ListView();
  }

  Widget _ListView(){
    return ListView.separated(
      itemBuilder: _itemBuilder,
      itemCount: 30,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          height: 1,
          color: Colors.grey,
        );
      },
    );
  }

  Widget _itemBuilder(BuildContext context, int index) {
    return Container(
      height: 30,
      padding: _functionUtil.initEdgeInsets(10.0, 5.0, 0.0, 5.0),
      child: Text('Column$index', style: const TextStyle(color: Colors.black, fontSize: 18),),
    );
  }
}