import 'package:extended_text/extended_text.dart';
import 'package:ff_annotation_route_library/ff_annotation_route_library.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'extended_special_text_span_builder.dart';
import 'extended_text_selection_controls.dart';

@FFRoute(
    name: 'fluttercandies://CustomTextOverflowDemo',
    routeName: 'CustomTextOverflow',
    description: 'workaround for issue 26748. how to custom text overflow')
class ExtendedCustomTextOverflowDemo extends StatefulWidget {
  const ExtendedCustomTextOverflowDemo({Key? key}) : super(key: key);

  @override
  _ExtendedCustomTextOverflowDemoState createState() => _ExtendedCustomTextOverflowDemoState();
}

class _ExtendedCustomTextOverflowDemoState extends State<ExtendedCustomTextOverflowDemo> {
  final String content = ''
      'relate to \$issue 26748\$ .[love]擴展文本幫助您快速構建富文本。 任何帶有擴展文本的特殊文本。 '
      '如果你想改進 Flutter，我很高興邀請你加入 \$FlutterCandies\$。[love]'
      '1234567 如果您遇到任何問題，請告訴我@zmtzawqlp。';
  final ExtendedSpecialTextSpanBuilder builder = ExtendedSpecialTextSpanBuilder();
  bool _joinZeroWidthSpace = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Custom Text OverFlow'),
        actions: <Widget>[
          IconButton(
              icon: const Icon(Icons.style),
              onPressed: () {
                setState(() {
                  _joinZeroWidthSpace = !_joinZeroWidthSpace;
                });
              })
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildText(maxLines: null, title: 'Full Text'),
              _buildText(position: TextOverflowPosition.end),
              _buildText(position: TextOverflowPosition.start),
              _buildText(position: TextOverflowPosition.middle),
              _buildText(position: TextOverflowPosition.middle, maxLines: 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildText({
    TextOverflowPosition position = TextOverflowPosition.end,
    int? maxLines = 4,
    String? title,
  }) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title ?? 'position: ${position.toString().replaceAll('TextOverflowPosition.', '')}${maxLines != null ? ' , maxLines: $maxLines' : ''}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Divider(
                  height: 1,
                  color: Colors.grey,
                ),
              ),
              ExtendedText(
                content,
                onSpecialTextTap: onSpecialTextTap,
                specialTextSpanBuilder: builder,
                selectionEnabled: true,
                // if joinZeroWidthSpace is true, you must take care of copy text.
                // override [TextSelectionControls.handleCopy], remove zero width space.
                selectionControls: ExtendedTextSelectionControls(
                  joinZeroWidthSpace: _joinZeroWidthSpace,
                ),
                joinZeroWidthSpace: _joinZeroWidthSpace,
                overflowWidget: TextOverflowWidget(
                  position: position,
                  align: TextOverflowAlign.center,
                  // just for debug
                  debugOverflowRectColor: Colors.red.withOpacity(0.1),
                  child: Container(
                    //color: Colors.yellow,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        const Text('\u2026 '),
                        InkWell(
                          child: const Text(
                            'more',
                          ),
                          onTap: () {
                            launch(
                                'https://github.com/fluttercandies/extended_text');
                          },
                        )
                      ],
                    ),
                  ),
                ),
                maxLines: maxLines,
              ),
            ],
          )),
    );
  }

  void onSpecialTextTap(dynamic parameter) {
    if (parameter.toString().startsWith('\$')) {
      if (parameter.toString().contains('issue')) {
        launch('https://github.com/flutter/flutter/issues/26748');
      } else {
        launch('https://github.com/fluttercandies');
      }
    } else if (parameter.toString().startsWith('@')) {
      launch('mailto:zmtzawqlp@live.com');
    }
  }
}