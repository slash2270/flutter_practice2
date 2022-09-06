import 'package:flutter/material.dart';
import 'package:flutter_practice2/demo/pdf_demo.dart';
import 'package:flutter_practice2/demo/secure_storage_demo.dart';
import 'package:flutter_practice2/demo/swithcer_demo.dart';
import 'package:flutter_practice2/demo/vertical_tabs_demo.dart';
import 'package:flutter_practice2/graphql/graphql_demo.dart';
import 'package:flutter_practice2/video_trimmer/video_trimmer_demo.dart';
import 'package:flutter_practice2/villains/villain_demo.dart';
import '../az_listview/common/index.dart';
import '../motion/motion_demo.dart';
import '../pinput/pinput_demo.dart';
import '../util/constants.dart';
import '../util/function_util.dart';
import "package:unorm_dart/unorm_dart.dart" as unorm;

class FortyFivePage extends StatefulWidget {
  const FortyFivePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FortyFivePageState();
  }
}

class FortyFivePageState extends State<FortyFivePage> {

  late FunctionUtil _functionUtil;
  String getUnorm = '';

  @override
  void initState() {
    _functionUtil = FunctionUtil();
    super.initState();
  }

  _unorm(){
    final combining = RegExp(r"[\u0300-\u036F]/g");
    const text = "The \u212B symbol invented by A. J. \u00C5ngstr\u00F6m (1814, L\u00F6gd\u00F6, \u2013 1874) denotes the length 10\u207B\u00B9\u2070 m.";
    setState((){
      getUnorm = "${unorm.nfkd("㍍ガバヴァぱばぐゞちぢ十人十色\n")}Regular: $text\nNFC: ${unorm.nfc(text)}\nNFKC: ${unorm.nfkc(text)}\nNFKD: * ${unorm.nfkd(text).replaceAll(combining, "")}\n * = Combining characters removed from decomposed form.";
      LogUtil.e('Unorm: $getUnorm');
    });
  }

  @override
  Widget build(BuildContext context) {

    final sliverMotion = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('Motion 陀螺儀', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initElevatedButton(context, 'motion', const MotionDemo()),
          ],
        )
    );

    final sliverUnorm = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('Unorm Unicode8.0', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            ElevatedButton(
              onPressed: () => _unorm,
              child: _functionUtil.initText2('unorm', Colors.white, Constants.colorTransparent, 20),
            ),
            getUnorm.isNotEmpty ? _functionUtil.initText2(getUnorm, Constants.colorBlack, Constants.colorTransparent, 24) : Container(),
          ],
        )
    );

    final sliverSwitcher = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('Switcher 優化切換器', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initElevatedButton(context, 'switcher', const SwitcherDemo()),
          ],
        )
    );

    final sliverGraphQL = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('GraphQL 超圖', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initElevatedButton(context, 'graphql', const GraphQLDemo()),
          ],
        )
    );

    final sliverPdf = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('Pdf 文件', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initElevatedButton(context, 'pdf', const PDFDemo()),
          ],
        )
    );

    final sliverVillains = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('Villain 惡棍', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initElevatedButton(context, 'villain', const VillainContent()),
          ],
        )
    );

    final sliverVideoTrimmer = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('VideoTrimmer 影片剪輯', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initElevatedButton(context, 'video trimmer', const VideoTrimmerDemo()),
          ],
        )
    );

    final sliverSecureStorage = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('SecureStorage 安全儲存', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initElevatedButton(context, 'secure storage', const SecureStorageDemo()),
          ],
        )
    );

    final sliverVerticalTabs = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('VerticalTabs 垂直標籤', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initElevatedButton(context, 'vertical tabs', const VerticalTabsDemo()),
          ],
        )
    );

    final sliverPinput = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('Pinput 簡訊驗證', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initElevatedButton(context, 'pinput', const PinputDemo()),
          ],
        )
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('FortyFive Page'),
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
            sliverMotion,
            sliverUnorm,
            sliverSwitcher,
            sliverGraphQL,
            sliverPdf,
            sliverVillains,
            sliverVideoTrimmer,
            sliverSecureStorage,
            sliverVerticalTabs,
            sliverPinput,
          ]
      ),
    );
  }

}