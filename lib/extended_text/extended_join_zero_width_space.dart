import 'package:extended_text/extended_text.dart';
import 'package:ff_annotation_route_library/ff_annotation_route_library.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'extended_special_text_span_builder.dart';
import 'extended_text_selection_controls.dart';

@FFRoute(
    name: 'fluttercandies://JoinZeroWidthSpace',
    routeName: 'JoinZeroWidthSpace',
    description:
    'make line breaking and overflow style better, workaround for issue 18761.')
class ExtendedJoinZeroWidthSpaceDemo extends StatelessWidget {
  ExtendedJoinZeroWidthSpaceDemo({Key? key}) : super(key: key);

  final String content =
      'relate to \$issue 26748\$ .[love]擴展文本幫助您快速構建富文本。 任何帶有擴展文本的特殊文本。 '
      '如果你想改進 Flutter，我很高興邀請你加入 \$FlutterCandies\$。[love]'
      '1234567 如果您遇到任何問題，請告訴我@zmtzawqlp。';
  final ExtendedSpecialTextSpanBuilder builder = ExtendedSpecialTextSpanBuilder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Zero-Width Space'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildText(
                joinZeroWidthSpace: false,
              ),
              _buildText(
                joinZeroWidthSpace: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildText({
    int? maxLines = 4,
    String? title,
    bool joinZeroWidthSpace = false,
  }) {
    return Card(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                title ?? 'joinZeroWidthSpace: $joinZeroWidthSpace',
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
                joinZeroWidthSpace: joinZeroWidthSpace,
                overflow: TextOverflow.ellipsis,
                maxLines: maxLines,
                selectionEnabled: true,
                // 如果 betterLineBreakingAndOverflowStyle 為真，則必須注意複製文本。
                // 覆蓋 [TextSelectionControls.handleCopy]，移除零寬度空間。
                selectionControls: ExtendedTextSelectionControls(
                  joinZeroWidthSpace: joinZeroWidthSpace,
                ),
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