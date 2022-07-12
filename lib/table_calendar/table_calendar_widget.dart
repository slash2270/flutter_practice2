import 'package:flutter/material.dart';
import 'package:flutter_practice2/util/function_util.dart';

import 'calendar_basic_example.dart';
import 'calendar_complex_example.dart';
import 'calendar_events_example.dart';
import 'calendar_multi_example.dart';
import 'calendar_range_example.dart';

class TableCalendarWidget extends StatefulWidget {
  const TableCalendarWidget({Key? key}) : super(key: key);

  @override
  _TableCalendarWidgetState createState() => _TableCalendarWidgetState();
}

class _TableCalendarWidgetState extends State<TableCalendarWidget> {
  @override
  Widget build(BuildContext context) {
    FunctionUtil _functionUtil = FunctionUtil();
    return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: _functionUtil.initText2('基本', Colors.black, Colors.transparent, 20),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CalendarBasicsExample()),
              ),
            ),
            _functionUtil.initSizedBox(12.0),
            ElevatedButton(
              child: _functionUtil.initText2('範圍選擇', Colors.black, Colors.transparent, 20),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CalendarRangeExample()),
              ),
            ),
            _functionUtil.initSizedBox(12.0),
            ElevatedButton(
              child: _functionUtil.initText2('活動', Colors.black, Colors.transparent, 20),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CalendarEventsExample()),
              ),
            ),
            _functionUtil.initSizedBox(12.0),
            ElevatedButton(
              child: _functionUtil.initText2('多項選擇', Colors.black, Colors.transparent, 20),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CalendarMultiExample()),
              ),
            ),
            _functionUtil.initSizedBox(12.0),
            ElevatedButton(
              child: _functionUtil.initText2('複雜的', Colors.black, Colors.transparent, 20),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CalendarComplexExample()),
              ),
            ),
          ],
    );
  }
}