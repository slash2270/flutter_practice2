import 'package:flutter/material.dart';
import 'package:flutter_practice2/demo/account_selector_demo.dart';
import 'package:flutter_practice2/demo/slide_to_act_demo.dart';
import 'package:flutter_practice2/left_scroll_actions/left_scroll_demo.dart';
import '../demo/credit_card_demo.dart';
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
          ]
      ),
    );
  }

}