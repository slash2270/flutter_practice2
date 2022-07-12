import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';

class MarqueeDemo extends StatefulWidget {
  const MarqueeDemo({Key? key}) : super(key: key);

  @override
  _MarqueeDemoState createState() => _MarqueeDemoState();
}

class _MarqueeDemoState extends State<MarqueeDemo> {
  bool _useRtlText = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildMarquee(),
        _buildComplexMarquee(),
        ElevatedButton(
          onPressed: ()=> setState(() => _useRtlText = !_useRtlText),
          child: !_useRtlText
              ? const Text('切換到希伯來語')
              : const Text('החלף לאנגלית'),
        ),
      ].map(_wrapWithStuff).toList(),
    );
  }

  Widget _buildMarquee() {
    return Marquee(
      key: Key("$_useRtlText"),
      text: !_useRtlText
          ? '從前有一個男孩講了一個關於一個男孩的故事："'
          : 'פעם היה ילד אשר סיפר סיפור על ילד:"',
      velocity: 50.0,
    );
  }

  Widget _buildComplexMarquee() {
    return Marquee(
      key: Key("$_useRtlText"),
      text: !_useRtlText
          ? '一些佔用空間的示例文本。'
          : 'זהו משפט ראשון של הטקסט הארוך. זהו המשפט השני של הטקסט הארוך',
      style: const TextStyle(fontWeight: FontWeight.bold),
      scrollAxis: Axis.horizontal,
      crossAxisAlignment: CrossAxisAlignment.start,
      blankSpace: 20,
      velocity: 100,
      pauseAfterRound: const Duration(seconds: 1),
      showFadingOnlyWhenScrolling: true,
      fadingEdgeStartFraction: 0.1,
      fadingEdgeEndFraction: 0.1,
      numberOfRounds: 3,
      startPadding: 10,
      accelerationDuration: const Duration(seconds: 1),
      accelerationCurve: Curves.linear,
      decelerationDuration: const Duration(milliseconds: 500),
      decelerationCurve: Curves.easeOut,
      textDirection: _useRtlText ? TextDirection.rtl : TextDirection.ltr,
    );
  }

  Widget _wrapWithStuff(Widget child) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(height: 50, color: Colors.white, child: child),
    );
  }
}