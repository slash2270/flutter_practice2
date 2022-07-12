// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_practice2/util/function_util.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarMultiExample extends StatefulWidget {
  const CalendarMultiExample({Key? key}) : super(key: key);

  @override
  _CalendarMultiExampleState createState() => _CalendarMultiExampleState();
}

class _CalendarMultiExampleState extends State<CalendarMultiExample> {
  late FunctionUtil _functionUtil;
  final ValueNotifier<List<EventTitle>> _selectedEvents = ValueNotifier([]);

  // 由於相等比較覆蓋，建議使用 `LinkedHashSet`
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
   _functionUtil = FunctionUtil();
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<EventTitle> _getEventsForDay(DateTime day) {
    // 實現示例
    return kEvents[day] ?? [];
  }

  List<EventTitle> _getEventsForDays(Set<DateTime> days) {
    // 實現示例
    // 請注意，日期是按選擇順序排列的（同樣適用於事件）
    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      _focusedDay = focusedDay;
      // 更新 Set 中的值
      if (_selectedDays.contains(selectedDay)) {
        _selectedDays.remove(selectedDay);
      } else {
        _selectedDays.add(selectedDay);
      }
    });
    _selectedEvents.value = _getEventsForDays(_selectedDays);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _functionUtil.initText('TableCalendar - Multi'),
      ),
      body: Column(
        children: [
          TableCalendar<EventTitle>(
            firstDay: kFirstDay,
            lastDay: kLastDay,
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            eventLoader: _getEventsForDay,
            startingDayOfWeek: StartingDayOfWeek.monday,
            selectedDayPredicate: (day) {
              // 使用 Set 中的值將多天標記為選中
              return _selectedDays.contains(day);
            },
            onDaySelected: _onDaySelected,
            onFormatChanged: (format) {
              if (_calendarFormat != format) {
                setState(() {
                  _calendarFormat = format;
                });
              }
            },
            onPageChanged: (focusedDay) {
              _focusedDay = focusedDay;
            },
          ),
          ElevatedButton(
            child: _functionUtil.initText('清除選擇'),
            onPressed: () {
              setState(() {
                _selectedDays.clear();
                _selectedEvents.value = [];
              });
            },
          ),
          _functionUtil.initSizedBox(8.0),
          Expanded(
            child: ValueListenableBuilder<List<EventTitle>>(
              valueListenable: _selectedEvents,
              builder: (context, value, _) {
                return ListView.builder(
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 12.0,
                        vertical: 4.0,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: ListTile(
                        onTap: () => print('${value[index]}'),
                        title: _functionUtil.initText('${value[index]}'),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}