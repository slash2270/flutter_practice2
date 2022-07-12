///
///  photo_view_demo.dart
///  create by zmtzawqlp on 2019/4/4
///
// ignore_for_file: always_put_control_body_on_new_line

import 'package:extended_text/extended_text.dart';
import 'package:ff_annotation_route_library/ff_annotation_route_library.dart';
import 'package:flutter/material.dart' hide CircularProgressIndicator;
import 'package:url_launcher/url_launcher.dart';

import 'extended_special_text_span_builder.dart';
import 'extended_text_selection_controls.dart';

@FFRoute(
    name: 'fluttercandies://TextSelectionDemo',
    routeName: 'TextSelection',
    description: 'text selection support')
class ExtendedTextSelectionDemo extends StatefulWidget {
  const ExtendedTextSelectionDemo({Key? key}) : super(key: key);

  @override
  _ExtendedTextSelectionDemoState createState() => _ExtendedTextSelectionDemoState();
}

class _ExtendedTextSelectionDemoState extends State<ExtendedTextSelectionDemo> {
  late TextSelectionControls _myTextSelectionControls;
  final String _attachContent = '[愛]擴展文本幫助您快速構建富文本。 如果您想改進 Flutter，我很高興邀請您加入 \$FlutterCandies\$。[love] 如果您遇到任何問題，請告訴我@zmtzawqlp。[ 太陽鏡]';
  @override
  void initState() {
    super.initState();
    _myTextSelectionControls = ExtendedTextSelectionControls();
  }

  @override
  Widget build(BuildContext context) {
    final Widget result = Material(
      child: Column(
        children: <Widget>[
          AppBar(
            title: const Text('Text Selection Support'),
          ),
          Expanded(
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                //return SelectableText(_attachContent);

                return Padding(
                  padding: const EdgeInsets.all(20),
                  child: ExtendedText(
                    _attachContent,
                    onSpecialTextTap: (dynamic parameter) {
                      if (parameter.toString().startsWith('\$')) {
                        launch('https://github.com/fluttercandies');
                      } else if (parameter.toString().startsWith('@')) {
                        launch('mailto:zmtzawqlp@live.com');
                      }
                    },
                    specialTextSpanBuilder: ExtendedSpecialTextSpanBuilder(),
                    //overflow: ExtendedTextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                    maxLines: 4,
                    overflowWidget: TextOverflowWidget(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text('\u2026 '),
                          InkWell(
                            child: const Text('更多'),
                            onTap: () {
                              launch(
                                  'https://github.com/fluttercandies/extended_text');
                            },
                          )
                        ],
                      ),
                    ),
                    selectionEnabled: true,
                    selectionControls: _myTextSelectionControls,
                    shouldShowSelectionHandles: _shouldShowSelectionHandles,
                    textSelectionGestureDetectorBuilder: ({
                      required ExtendedTextSelectionGestureDetectorBuilderDelegate
                      delegate,
                      required Function showToolbar,
                      required Function hideToolbar,
                      required Function? onTap,
                      required BuildContext context,
                      required Function? requestKeyboard,
                    }) {
                      return MyCommonTextSelectionGestureDetectorBuilder(
                        delegate: delegate,
                        showToolbar: showToolbar,
                        hideToolbar: hideToolbar,
                        onTap: onTap,
                        context: context,
                        requestKeyboard: requestKeyboard,
                      );
                    },
                  ),
                );
              },
              itemCount: 100,
            ),
          ),
        ],
      ),
    );

    return ExtendedTextSelectionPointerHandler(
      //default behavior
      // child: result,
      //custom your behavior
      builder: (List<ExtendedTextSelectionState> states) {
        return Listener(
          child: result,
          behavior: HitTestBehavior.translucent,
          onPointerDown: (PointerDownEvent value) {
            for (final ExtendedTextSelectionState state in states) {
              if (!state.containsPosition(value.position)) {
                //clear other selection
                state.clearSelection();
              }
            }
          },
          onPointerMove: (PointerMoveEvent value) {
            //clear other selection
            for (final ExtendedTextSelectionState state in states) {
              state.clearSelection();
            }
          },
        );
      },
    );
  }

  bool _shouldShowSelectionHandles(
      SelectionChangedCause? cause,
      CommonTextSelectionGestureDetectorBuilder selectionGestureDetectorBuilder,
      TextEditingValue editingValue,
      ) {
    // When the text field is activated by something that doesn't trigger the
    // selection overlay, we shouldn't show the handles either.

    //
    // if (!selectionGestureDetectorBuilder.shouldShowSelectionToolbar)
    //   return false;

    if (cause == SelectionChangedCause.keyboard) return false;

    // if (widget.readOnly && _effectiveController.selection.isCollapsed)
    //   return false;

    // if (!_isEnabled) return false;

    if (cause == SelectionChangedCause.longPress) return true;

    if (editingValue.text.isNotEmpty) return true;

    return false;
  }
}

class MyCommonTextSelectionGestureDetectorBuilder
    extends CommonTextSelectionGestureDetectorBuilder {
  MyCommonTextSelectionGestureDetectorBuilder(
      {required ExtendedTextSelectionGestureDetectorBuilderDelegate delegate,
        required Function showToolbar,
        required Function hideToolbar,
        required Function? onTap,
        required BuildContext context,
        required Function? requestKeyboard})
      : super(
    delegate: delegate,
    showToolbar: showToolbar,
    hideToolbar: hideToolbar,
    onTap: onTap,
    context: context,
    requestKeyboard: requestKeyboard,
  );
  @override
  void onTapDown(TapDownDetails details) {
    super.onTapDown(details);

    /// always show toolbar
    shouldShowSelectionToolbar = true;
  }

  @override
  bool get showToolbarInWeb => true;
}