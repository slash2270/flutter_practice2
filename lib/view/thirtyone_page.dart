import 'package:flutter/material.dart';
import 'package:flutter_practice2/timelines/timelines_demo.dart';
import 'package:flutter_practice2/util/constants.dart';
import 'package:flutter_practice2/widget/rating_star_widget.dart';

import '../util/function_util.dart';

class ThirtyOnePage extends StatefulWidget {
  const ThirtyOnePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ThirtyOnePageState();
}

class ThirtyOnePageState extends State<ThirtyOnePage> {

  late FunctionUtil _functionUtil;

  @override
  void initState() {
    _functionUtil = FunctionUtil();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final sliverList = SliverList(
          delegate: SliverChildListDelegate(<Widget>[
          _functionUtil.initSizedBox(20.0),
          _functionUtil.initText2('RatingStar 星級評分', Constants.colorBlack, Constants.colorTransparent, 24),
          _functionUtil.initSizedBox(16.0),
          const RatingStarWidget(),
          _functionUtil.initSizedBox(20.0),
          _functionUtil.initText2('TimeLines 時間軸', Constants.colorBlack, Constants.colorTransparent, 24),
          _functionUtil.initSizedBox(16.0),
          const TimeLinesDemo(),
          _functionUtil.initSizedBox(20.0),
    ]));

    return Scaffold(
      appBar: AppBar(
        title: const Text('ThirtyOne Page'),
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
      body: CustomScrollView(
        slivers: [
          sliverList
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }

}