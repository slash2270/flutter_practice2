
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/util/function_util.dart';

class CalendarWeekWidget extends StatefulWidget {
  const CalendarWeekWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CalendarWeekWidgetState();
  }
}

class CalendarWeekWidgetState extends State<CalendarWeekWidget> {

  late FunctionUtil _functionUtil;

  @override
  void initState() {
    _functionUtil = FunctionUtil();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: WeekView(
        controller: EventController(),
        eventTileBuilder: (date, events, boundary, start, end) {
          // Return your widget to display as event tile.
          return Container();
        },
        showLiveTimeLineInAllDays: true,
        // To display live time line in all pages in week view.
        //width: 400,
        // width of week view.
        minDay: DateTime(1990),
        maxDay: DateTime(2050),
        initialDay: DateTime(2022),
        heightPerMinute: 1,
        // height occupied by 1 minute time span.
        eventArranger: const SideEventArranger(),
        // To define how simultaneous events will be arranged.
        onEventTap: (events, date) => print(events),
        onDateLongPress: (date) => print(date),
        startDay: WeekDays.sunday, // To change the first day of the week.
      ),
    );
  }

}