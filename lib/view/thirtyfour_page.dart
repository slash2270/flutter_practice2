import 'package:flutter/material.dart';
import 'package:flutter_practice2/rubber/rubber_demo.dart';
import 'package:flutter_practice2/util/constants.dart';
import 'package:flutter_practice2/widget/circular_slider_widget.dart';
import 'package:flutter_practice2/widget/kumi_popup_window_widget.dart';
import 'package:flutter_practice2/widget/simple_gesture_detector_widget.dart';
import '../solid_bottom_sheet/solid_bottom_sheet_demo.dart';
import '../util/function_util.dart';
import '../widget/open_setting_widget.dart';

class ThirtyFourPage extends StatefulWidget {
  const ThirtyFourPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return ThirtyFourPageState();
  }
}

class ThirtyFourPageState extends State<ThirtyFourPage> {

  late FunctionUtil _functionUtil;

  @override
  void initState() {
    _functionUtil = FunctionUtil();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final sliverCircularSlider = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('CircularSlider 可手動滑的載入圈', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            const CircularSliderWidget(),
          ],
        )
    );

    final sliverOpenSetting = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('OpenSetting 螢幕所有設定', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            const OpenSettingDemo(),
          ],
        )
    );

    final sliverPopUp = SliverToBoxAdapter(
      child: Column(
        children: [
          _functionUtil.initSizedBox(20.0),
          _functionUtil.initText2('KumiPopupWindow 簡易彈窗', Constants.colorBlack, Constants.colorTransparent, 24),
          _functionUtil.initSizedBox(16.0),
          _functionUtil.initCuperTinoButton(context, 'Popup', const KumiPopupWindowWidget(title: 'Kumi Popup Window',))
        ],
      ),
    );

    final sliverSolidBottomSheet = SliverToBoxAdapter(
      child: Column(
        children: [
          _functionUtil.initSizedBox(20.0),
          _functionUtil.initText2('SolidBottomSheet 實心底版', Constants.colorBlack, Constants.colorTransparent, 24),
          _functionUtil.initSizedBox(16.0),
          _functionUtil.initCuperTinoButton(context, 'Solid', const SolidBottomSheetWidget())
        ],
      ),
    );

    final sliverGestureDetector = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('SimpleGestureDetector\n輕量級手勢檢測器', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            const SimpleGestureDetectorWidget(),
          ],
        )
    );

    final sliverRubber = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('Rubber 彈性底版', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            const RubberDemo(),
          ],
        )
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('ThirtyFour Page'),
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
          sliverCircularSlider,
          sliverOpenSetting,
          sliverGestureDetector,
          sliverPopUp,
          sliverSolidBottomSheet,
          sliverRubber,
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }

}