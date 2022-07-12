import 'package:flutter/material.dart';
import 'package:flutter_practice2/demo/marquee_demo.dart';
import 'package:flutter_practice2/demo/vibrate_demo.dart';
import 'package:flutter_practice2/redux_counter/redux_counter_widget.dart';
import 'package:flutter_practice2/table_calendar/table_calendar_widget.dart';
import 'package:flutter_practice2/util/constants.dart';
import 'package:flutter_practice2/util/function_util.dart';
import 'package:flutter_practice2/widget/url_launcher_widget.dart';

import '../calendar_view/calendar_view_demo.dart';

class TwentyFourPage extends StatefulWidget {
  const TwentyFourPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TwentyFourPageState();
  }
}

class TwentyFourPageState extends State<TwentyFourPage> {

  late FunctionUtil _functionUtil;

  @override
  void initState() {
    _functionUtil = FunctionUtil();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // 一个不需要GlobalKey就可以openDrawer的AppBar
      appBar: AppBar(
        title: const Text('TwentyFour Page'),
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('Url Launcher 和本機或App互動', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            const UrlLauncherDemo(),
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('Redux Counter 簡化版小部件', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            const ReduxCounterWidget(),
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('Table Calendar 日曆', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            const TableCalendarWidget(),
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('Calendar View 日曆', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            const CalendarViewDemo(),
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('Vibrating 振動', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            const VibratingDemo(),
            _functionUtil.initSizedBox(20.0),
            _functionUtil.initText2('Marquee 跑馬燈', Constants.colorBlack, Constants.colorTransparent, 24),
            _functionUtil.initSizedBox(16.0),
            const MarqueeDemo(),
            _functionUtil.initSizedBox(20.0),
          ],
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }

}