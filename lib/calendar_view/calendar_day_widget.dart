
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/util/function_util.dart';

class CalendarDayWidget extends StatefulWidget {
  const CalendarDayWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CalendarDayWidgetState();
  }
}

class CalendarDayWidgetState extends State<CalendarDayWidget> {

  late FunctionUtil _functionUtil;

  @override
  void initState() {
    _functionUtil = FunctionUtil();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: DayView(
        controller: EventController(),
        eventTileBuilder: (date, events, boundary, start, end) {
          // Return your widget to display as event tile.
          return Container();
        },
        showVerticalLine: true,
        // To display live time line in day view.
        showLiveTimeLineInAllDays: true,
        // To display live time line in all pages in day view.
        initialDay: DateTime(2022),
        heightPerMinute: 1,
        // height occupied by 1 minute time span.
        eventArranger: const SideEventArranger(),
        // To define how simultaneous events will be arranged.
        onEventTap: (events, date) => print(events),
        onDateLongPress: (date) => print(date),
      ),
    );
  }

}