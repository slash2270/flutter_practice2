import 'package:flutter/material.dart';
import 'package:flutter_practice2/demo/pimp_my_button_demo.dart';
import 'package:flutter_practice2/util/constants.dart';
import 'package:flutter_practice2/widget/draggable_bottom_sheet_widget.dart';
import '../demo/story_demo.dart';
import '../util/function_util.dart';

class ThirtyNinePage extends StatefulWidget {
  const ThirtyNinePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ThirtyNinePageState();
  }
}

class ThirtyNinePageState extends State<ThirtyNinePage> {

  late FunctionUtil _functionUtil;

  @override
  void initState() {
    _functionUtil = FunctionUtil();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final sliverDraggableBottomSheet = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('DraggableBottomSheet 拖曳底部', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initCuperTinoButton(context, 'draggable', const DraggableBottomSheetDemo(),)
          ],
        )
    );

    final sliverPimpMyButton = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('PimpMyButton 粒子效果', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initCuperTinoButton(context, 'pimp', const PimpMyButtonDemo(),)
          ],
        )
    );

    final sliverStory = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('Story Instagram故事', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initCuperTinoButton(context, 'story', const StoryDemo(),)
          ],
        )
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('ThirtyNine Page'),
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
          sliverDraggableBottomSheet,
          sliverPimpMyButton,
          sliverStory,
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }

}