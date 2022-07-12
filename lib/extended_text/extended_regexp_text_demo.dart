import 'package:extended_text/extended_text.dart';
import 'package:ff_annotation_route_library/ff_annotation_route_library.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'extended_regexp_text_span_builder.dart';

@FFRoute(
    name: 'fluttercandies://RegExpTextDemo',
    routeName: 'RegExText',
    description: 'quickly build special text with RegExp')
class ExtendedRegExpTextDemo extends StatelessWidget {
  const ExtendedRegExpTextDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('quickly build special text'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: ExtendedText(
          '[愛]擴展文本幫助您快速構建富文本。 任何帶有擴展文本的特殊文本。 '
              '\n\n如果你想改進 Flutter，我很高興邀請你加入 \$FlutterCandies\$。[love]'
              '\n\n如果您遇到任何問題，請告訴我@zmtzawqlp 並發送郵件至：zmtzawqlp@live.com 給我。[sun_glasses] ',
          onSpecialTextTap: (dynamic parameter) {
            if (parameter.toString().startsWith('\$')) {
              launch('https://github.com/fluttercandies');
            } else if (parameter.toString().startsWith('@')) {
              launch('mailto:zmtzawqlp@live.com');
            } else if (parameter.toString().startsWith('mailto:')) {
              launch(parameter.toString());
            }
          },
          specialTextSpanBuilder: ExtendedRegExpTextSpanBuilder(),
          overflow: TextOverflow.ellipsis,
          selectionEnabled: true,
          //style: TextStyle(background: Paint()..color = Colors.red),
          maxLines: 10,
        ),
      ),
    );
  }
}