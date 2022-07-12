
import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/util/function_util.dart';

class CalendarMonthWidget extends StatefulWidget {
  const CalendarMonthWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return CalendarMonthWidgetState();
  }
}

class CalendarMonthWidgetState extends State<CalendarMonthWidget> {

  late FunctionUtil _functionUtil;

  @override
  void initState() {
    _functionUtil = FunctionUtil();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: MonthView(
        controller: EventController(),
        // to provide custom UI for month cells.
        cellBuilder: (date, events, isToday, isInMonth) {
          // Return your widget to display as month cell.
          return Container();
        },
        minMonth: DateTime(1990),
        maxMonth: DateTime(2050),
        initialMonth: DateTime(2022),
        cellAspectRatio: 1,
        onPageChange: (date, pageIndex) => print("$date, $pageIndex"),
        onCellTap: (events, date) {
          // Implement callback when user taps on a cell.
          print(events);
        },
        startDay: WeekDays.sunday,
        // To change the first day of the week.
        // This callback will only work if cellBuilder is null.
        onEventTap: (event, date) => print(event),
        onDateLongPress: (date) => print(date),
      ),
    );
  }

}