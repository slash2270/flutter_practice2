import 'package:flutter/material.dart';
import 'package:flutter_practice2/calendar_view/calendar_day_widget.dart';
import 'package:flutter_practice2/calendar_view/calendar_month_widget.dart';
import 'package:flutter_practice2/calendar_view/calendar_week_widget.dart';
import 'package:flutter_practice2/util/function_util.dart';

class CalendarViewDemo extends StatefulWidget {
  const CalendarViewDemo({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => CalendarViewDemoState();
}

class CalendarViewDemoState extends State<CalendarViewDemo> {

  late FunctionUtil _functionUtil;

  @override
  void initState() {
    super.initState();
    _functionUtil = FunctionUtil();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _functionUtil.initSizedBox(12.0),
          ElevatedButton(
            child: _functionUtil.initText2('Day', Colors.black, Colors.transparent, 20),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CalendarDayWidget()),
            ),
          ),
          _functionUtil.initSizedBox(12.0),
          ElevatedButton(
            child: _functionUtil.initText2('Week', Colors.black, Colors.transparent, 20),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CalendarWeekWidget()),
            ),
          ),
          _functionUtil.initSizedBox(12.0),
          ElevatedButton(
            child: _functionUtil.initText2('Month', Colors.black, Colors.transparent, 20),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CalendarMonthWidget()),
            ),
          ),
        ],
    );
  }

}