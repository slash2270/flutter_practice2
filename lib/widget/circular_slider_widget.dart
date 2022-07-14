import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_circular_slider/flutter_circular_slider.dart';

class CircularSliderWidget extends StatelessWidget {
  const CircularSliderWidget ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background_morning.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: const SleepPage());
  }
}

class SleepPage extends StatefulWidget {
  const SleepPage({Key? key}) : super(key: key);

  @override
  _SleepPageState createState() => _SleepPageState();
}

class _SleepPageState extends State<SleepPage> {
  final baseColor = const Color.fromRGBO(255, 255, 255, 0.3);

  int initTime = 0;
  int endTime = 0;
  int inBedTime = 0;
  int outBedTime = 0;
  int days = 0;

  @override
  void initState() {
    super.initState();
    _shuffle();
  }

  void _shuffle() {
    setState(() {
      initTime = _generateRandomTime();
      endTime = _generateRandomTime();
      inBedTime = initTime;
      outBedTime = endTime;
    });
  }

  void _updateLabels(int init, int end, int laps) {
    setState(() {
      inBedTime = init;
      outBedTime = end;
      days = laps;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text(
          '你在床上呆了多久?',
          style: TextStyle(color: Colors.white),
        ),
        // SingleCircularSlider(
        //   288,
        //   endTime,
        //   height: 220.0,
        //   width: 220.0,
        //   primarySectors: 6,
        //   secondarySectors: 24,
        //   baseColor: Color.fromRGBO(255, 255, 255, 0.1),
        //   selectionColor: baseColor,
        //   handlerColor: Colors.white,
        //   handlerOutterRadius: 12.0,
        //   onSelectionChange: _updateLabels,
        //   showRoundedCapInSelection: true,
        //   showHandlerOutter: false,
        //   child: Padding(
        //       padding: const EdgeInsets.all(42.0),
        //       child: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: [
        //           SizedBox(height: 20),
        //           Text('${_formatIntervalTime(inBedTime, outBedTime)}',
        //               style: TextStyle(fontSize: 24.0, color: Colors.white)),
        //           Text('${_formatDays(days)}',
        //               style: TextStyle(
        //                   fontSize: 16.0,
        //                   color: Colors.white,
        //                   fontStyle: FontStyle.italic)),
        //         ],
        //       )),
        //   shouldCountLaps: true,
        // ),
        DoubleCircularSlider(
          288,
          initTime,
          endTime,
          height: 260.0,
          width: 260.0,
          primarySectors: 6,
          secondarySectors: 24,
          baseColor: const Color.fromRGBO(255, 255, 255, 0.1),
          selectionColor: baseColor,
          handlerColor: Colors.white,
          handlerOutterRadius: 12.0,
          onSelectionChange: _updateLabels,
          onSelectionEnd: (a, b, c) => print('onSelectionEnd $a $b $c'),
          sliderStrokeWidth: 12.0,
          shouldCountLaps: true,
          child: Padding(
              padding: const EdgeInsets.all(42.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  Text(_formatIntervalTime(inBedTime, outBedTime),
                      style: const TextStyle(fontSize: 36.0, color: Colors.white)),
                  Text(_formatDays(days),
                      style: const TextStyle(
                          fontSize: 28.0,
                          color: Colors.white,
                          fontStyle: FontStyle.italic)),
                ],
              )),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          _formatBedTime('IN THE', inBedTime),
          _formatBedTime('OUT OF', outBedTime),
        ]),
        FlatButton(
          color: baseColor,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          onPressed: _shuffle,
          child: const Text('S H U F F L E'),
        ),
      ],
    );
  }

  Widget _formatBedTime(String pre, int time) {
    return Column(
      children: [
        Text(pre, style: TextStyle(color: baseColor)),
        Text('BED AT', style: TextStyle(color: baseColor)),
        Text(_formatTime(time), style: const TextStyle(color: Colors.white),)
      ],
    );
  }

  String _formatDays(int days) {
    return days > 0 ? ' (+$days)' : '';
  }

  String _formatTime(int time) {
    if (time == 0 || time.toString().isEmpty) {
      return '00:00';
    }
    var hours = time ~/ 12;
    var minutes = (time % 12) * 5;
    return '$hours:$minutes';
  }

  String _formatIntervalTime(int init, int end) {
    var sleepTime = end > init ? end - init : 288 - init + end;
    var hours = sleepTime ~/ 12;
    var minutes = (sleepTime % 12) * 5;
    return '${hours}h${minutes}m';
  }

  int _generateRandomTime() => Random().nextInt(288);
}