import 'package:flutter/material.dart';
import 'package:flutter_practice2/demo/battery_plus_demo.dart';
import 'package:flutter_practice2/demo/connectivity_plus_demo.dart';
import 'package:flutter_practice2/demo/gbk2utf8_demo.dart';
import 'package:flutter_practice2/demo/vercoder_inputer_demo.dart';
import 'package:flutter_practice2/picker/picker_demo.dart';
import 'package:flutter_practice2/sensor_plus/sensor_plus_demo.dart';
import '../demo/intent_plus_demo.dart';
import '../demo/slimy_card_demo.dart';
import '../mobile_scanner/mobile_scanner_demo.dart';
import '../offline/offline_demo.dart';
import '../share_plus/share_plus_demo.dart';
import '../util/constants.dart';
import '../util/function_util.dart';

class FortyThreePage extends StatefulWidget {
  const FortyThreePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FortyThreePageState();
  }
}

class FortyThreePageState extends State<FortyThreePage> {

  late FunctionUtil _functionUtil;

  @override
  void initState() {
    _functionUtil = FunctionUtil();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final sliverMobileScanner = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('MobileScanner 手機掃描', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initElevatedButton(context, 'Mobile Scanner', const MobileScannerDemo()),
          ],
        )
    );

    final sliverQRMobileVision = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('Connectivity 連線', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initElevatedButton(context, 'Connectivity', const ConnectivityPlusDemo()),
          ],
        )
    );

    final sliverIntentPlus = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('IntentPlus 意圖升級', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initElevatedButton(context, 'IntentPlus', const IntentPlusDemo()),
          ],
        )
    );

    final sliverBatteryPlus = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('BatteryPlus 電池電量', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initElevatedButton(context, 'BatteryPlus', const BatteryPlusDemo()),
          ],
        )
    );

    final sliverSensorPlus = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('SensorPlus 傳感器', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initElevatedButton(context, 'SensorPlus', const SensorPlusDemo()),
          ],
        )
    );

    final sliverSharePlus = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('SharePlus 分享', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initElevatedButton(context, 'SharePlus', const SharePlusDemo()),
          ],
        )
    );

    final sliverOffline = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('Offline 連線離線', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initElevatedButton(context, 'Offline', const OfflineDemo()),
          ],
        )
    );

    final sliverGbk = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('Gbk2utf8 解析', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initElevatedButton(context, 'Gbk2utf8', const GBK2utf8Demo()),
          ],
        )
    );

    final sliverSlimyCard = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('SlimyCard 一分為二的卡片', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initElevatedButton(context, 'SlimyCard', const SlimyCardDemo()),
          ],
        )
    );

    final sliverVercoderInputer = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('VercoderInputer 驗證碼輸入框控件', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initElevatedButton(context, 'VercoderInputer', const VercoderInputerDemo()),
          ],
        )
    );

    final sliverPicker = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('Picker 選擇器', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initElevatedButton(context, 'Picker', const PickerDemo()),
          ],
        )
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('FortyThree Page'),
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
            sliverMobileScanner,
            sliverQRMobileVision,
            sliverIntentPlus,
            sliverBatteryPlus,
            sliverSensorPlus,
            sliverSharePlus,
            sliverOffline,
            sliverGbk,
            sliverSlimyCard,
            sliverVercoderInputer,
            sliverPicker,
          ]
      ),
    );
  }

}