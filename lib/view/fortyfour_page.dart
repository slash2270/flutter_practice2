import 'package:flutter/material.dart';
import 'package:flutter_practice2/demo/account_selector_demo.dart';
import 'package:flutter_practice2/demo/flip_box_bar_plus_demo.dart';
import 'package:flutter_practice2/demo/ratingbar_demo.dart';
import 'package:flutter_practice2/demo/slide_to_act_demo.dart';
import 'package:flutter_practice2/highlight/highlight_demo.dart';
import 'package:flutter_practice2/left_scroll_actions/left_scroll_demo.dart';
import 'package:flutter_practice2/login/login_demo.dart';
import '../demo/credit_card_demo.dart';
import '../modal_bottom_sheet/modal_sheet_bottom_demo.dart';
import '../rate_my_app/rate_my_app_demo.dart';
import '../synchronized/synchronized_demo.dart';
import '../util/constants.dart';
import '../util/function_util.dart';

class FortyFourPage extends StatefulWidget {
  const FortyFourPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FortyFourPageState();
  }
}

class FortyFourPageState extends State<FortyFourPage> {

  late FunctionUtil _functionUtil;

  @override
  void initState() {
    _functionUtil = FunctionUtil();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final sliverCreditCard = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('CreditCard 信用卡', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initElevatedButton(context, 'CreditCard', const CreditCardDemo()),
          ],
        )
    );

    final sliverSlideAct = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('SlideAct 解鎖滑動元件', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initElevatedButton(context, 'SlideToAct', const SlideToActDemo()),
          ],
        )
    );

    final sliverAccountSelector = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('AccountSelector 解鎖滑動元件', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initElevatedButton(context, 'AccountSelector', const AccountSelectorWidget()),
          ],
        )
    );

    final sliverLeftScroll = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('LeftScroll 仿微信左滑', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initElevatedButton(context, 'LeftScroll', const LeftScrollDemo()),
          ],
        )
    );

    final sliverBoxBar = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('FlipBoxBarPlus 翻轉框條', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initElevatedButton(context, 'FlipBoxBarPlus', const FlipBoxBarPlusDemo()),
          ],
        )
    );

    final sliverBottomSheet = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('ModalBottomSheet 模態底頁', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initElevatedButton(context, 'ModalBottomSheet', const ModalBottomSheetDemo()),
          ],
        )
    );

    final sliverRateMyApp = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('RateMyApp 評價App', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initElevatedButton(context, 'RateMyApp', const RateMyAppDemo()),
          ],
        )
    );

    final sliverLogin = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('Login 登入/註冊UI', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initElevatedButton(context, 'Login', const LoginDemo()),
          ],
        )
    );

    final sliverRatingBar = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('RatingBar 評分', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initElevatedButton(context, 'RatingBar', const RatingBarDemo()),
          ],
        )
    );

    final sliverHighlight = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('Highlight 明亮突出', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initElevatedButton(context, 'highlight', const HighlightDemo()),
          ],
        )
    );

    final sliverSynchronized = SliverToBoxAdapter(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('Synchronized 同步', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            _functionUtil.initElevatedButton(context, 'synchronized', const SynchronizedDemo()),
          ],
        )
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('FortyFour Page'),
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
            sliverCreditCard,
            sliverSlideAct,
            sliverAccountSelector,
            sliverLeftScroll,
            sliverBoxBar,
            sliverBottomSheet,
            sliverRateMyApp,
            sliverLogin,
            sliverRatingBar,
            sliverHighlight,
            sliverSynchronized,
          ]
      ),
    );
  }

}