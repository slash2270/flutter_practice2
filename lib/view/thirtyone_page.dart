import 'package:flutter/material.dart';
import 'package:flutter_practice2/az_listview/az_listview_widget.dart';
import 'package:flutter_practice2/intro_slider/intro_screen_demo.dart';
import 'package:flutter_practice2/timelines/timelines_demo.dart';
import 'package:flutter_practice2/util/constants.dart';
import 'package:flutter_practice2/widget/palette_generator.dart';
import 'package:flutter_practice2/widget/rating_star_widget.dart';

import '../demo/sticky_headers_demo.dart';
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
    final sliverColumn = SliverToBoxAdapter(
          child: Column(
            children: [
              _functionUtil.initSizedBox(20.0),
              _functionUtil.initText2('RatingStar 星級評分', Constants.colorBlack, Constants.colorTransparent, 24),
              _functionUtil.initSizedBox(16.0),
              const RatingStarWidget(),
              _functionUtil.initSizedBox(20.0),
              _functionUtil.initText2('TimeLines 時間軸', Constants.colorBlack, Constants.colorTransparent, 24),
              _functionUtil.initSizedBox(16.0),
              const TimeLinesDemo(),
            ],
          )
    );

    final sliverIntroHeader = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('IntroScreen 前導頁', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
          ],
        )
    );

    final sliverStickyHeader = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('StickyHeaders 滑動變化Headers', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
          ],
        )
    );

    final sliverAzListHeader = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('AzList 關鍵字搜尋List', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
          ],
        )
    );

    final sliverPalette = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('PaletteGenerator 從圖像提取顏色', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            const PaletteGeneratorWidget()
          ],
        )
    );

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
          sliverColumn,
          sliverStickyHeader,
          const StickyHeadersDemo(),
          sliverIntroHeader,
          const IntroScreenDemo(),
          sliverAzListHeader,
          const AzListViewDemo(),
          sliverPalette
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }

}