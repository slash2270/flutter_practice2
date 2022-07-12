import 'package:extended_text/extended_text.dart';
import 'package:ff_annotation_route_library/ff_annotation_route_library.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

@FFRoute(
    name: 'fluttercandies://BackgroundTextDemo',
    routeName: 'BackgroundText',
    description: 'workaround for issue 24335/24337 about background')
class ExtendedBackgroundTextDemo extends StatelessWidget {
  const ExtendedBackgroundTextDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nick Background For Text'),
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text.rich(TextSpan(children: <TextSpan>[
                  TextSpan(
                      text: '24335',
                      style: const TextStyle(
                        color: Colors.blue,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launch(
                              'https://github.com/flutter/flutter/issues/24335');
                        }),
                  const TextSpan(text: '/'),
                  TextSpan(
                      text: '24337',
                      style: const TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launch(
                              'https://github.com/flutter/flutter/issues/24337');
                        }),
                ])),
                const Text(
                  '官方文本背景，顏色為 Alpha 255，缺少中文單詞',
                ),
                Text(
                  '錯誤演示 12345',
                  style: TextStyle(background: Paint()..color = Colors.orange),
                ),
                Container(
                  height: 20.0,
                ),
                const Text('官方文本背景，顏色為 Alpha 102，頂部有一條高亮線',
                ),
                Text(
                  '錯誤演示 12345',
                  style: TextStyle(
                      background: Paint()
                        ..color = Colors.orange.withOpacity(0.4)),
                ),
                Container(
                  height: 20.0,
                ),
                const Text('以下演示是關於背景的問題 24335/24337 的解決方法，您也可以定義自定義背景。'),
                Container(
                  height: 20.0,
                ),
                ExtendedText.rich(
                  TextSpan(children: <TextSpan>[
                    BackgroundTextSpan(
                      text: '錯誤演示 12345',
                      background: Paint()..color = Colors.blue,
                    ),
                    BackgroundTextSpan(
                        text: '錯誤演示 12345',
                        background: Paint()..color = Colors.blue,
                        style: const TextStyle(color: Colors.white)),
                    const TextSpan(
                        text: ' 帶有漂亮背景的擴展文本 '),
                    BackgroundTextSpan(
                      text:
                      '錯誤演示 12345  錯誤演示 12345  錯誤演示 12345  錯誤演示 12345  錯誤演示 12345  錯誤演示 12345',
                      background: Paint()..color = Colors.orange,
                    ),
                    const TextSpan(
                        text:
                        '  帶有漂亮背景的擴展文本，唯一的問題是我們可以得到省略號的偏移量，所以不能在省略號末尾繪製背景。 請讓我知道是否有任何方法可以抵消省略號。'),
                    BackgroundTextSpan(
                      text: '繪製背景行尾 錯誤演示 12345',
                      style: const TextStyle(color: Colors.red),
                      background: Paint()..color = Colors.red.withOpacity(0.1),
                    ),
                  ]),
                  maxLines: 8,
                  overflow: TextOverflow.ellipsis,
                ),
                Container(
                  height: 20.0,
                ),
                ExtendedText.rich(TextSpan(children: <TextSpan>[
                  BackgroundTextSpan(
                      text:
                      '這段文字有很好的背景和邊框半徑，不管有多少行，它都喜歡漂亮',
                      background: Paint()..color = Colors.indigo,
                      clipBorderRadius:
                      const BorderRadius.all(Radius.circular(3.0))),
                ])),
                Container(
                  height: 20.0,
                ),
                ExtendedText.rich(TextSpan(children: <TextSpan>[
                  BackgroundTextSpan(
                      text:
                      '如果你不喜歡默認背景，你可以使用paintBackground回調來繪製你的背景',
                      background: Paint()..color = Colors.teal,
                      clipBorderRadius:
                      const BorderRadius.all(Radius.circular(3.0)),
                      paintBackground: (BackgroundTextSpan backgroundTextSpan,
                          Canvas canvas,
                          Offset offset,
                          TextPainter? painter,
                          Rect rect,
                          {Offset? endOffset,
                            TextPainter? wholeTextPainter}) {
                        final Rect textRect = offset & painter!.size;

                        ///top-right
                        if (endOffset != null) {
                          final Rect firstLineRect = offset &
                          Size(rect.right - offset.dx, painter.height);

                          if (backgroundTextSpan.clipBorderRadius != null) {
                            canvas.save();
                            canvas.clipPath(Path()
                              ..addRRect(backgroundTextSpan.clipBorderRadius!
                                  .resolve(painter.textDirection)
                                  .toRRect(firstLineRect)));
                          }

                          ///start
                          canvas.drawRect(
                              firstLineRect, backgroundTextSpan.background);

                          if (backgroundTextSpan.clipBorderRadius != null) {
                            canvas.restore();
                          }

                          ///endOffset.y has deviation,so we calculate with text height
                          final int fullLinesAndLastLine =
                          ((endOffset.dy - offset.dy) / painter.height)
                              .round();

                          double y = offset.dy;
                          for (int i = 0; i < fullLinesAndLastLine; i++) {
                            y += painter.height;
                            //last line
                            if (i == fullLinesAndLastLine - 1) {
                              final Rect lastLineRect = Offset(0.0, y) &
                              Size(endOffset.dx, painter.height);
                              if (backgroundTextSpan.clipBorderRadius != null) {
                                canvas.save();
                                canvas.clipPath(Path()
                                  ..addRRect(backgroundTextSpan
                                      .clipBorderRadius!
                                      .resolve(painter.textDirection)
                                      .toRRect(lastLineRect)));
                              }
                              canvas.drawRect(
                                  lastLineRect, backgroundTextSpan.background);
                              if (backgroundTextSpan.clipBorderRadius != null) {
                                canvas.restore();
                              }
                            }

                            ///draw full line
                            else {
                              final Rect fullLineRect = Offset(0.0, y) &
                              Size(rect.width, painter.height);

                              if (backgroundTextSpan.clipBorderRadius != null) {
                                canvas.save();
                                canvas.clipPath(Path()
                                  ..addRRect(backgroundTextSpan
                                      .clipBorderRadius!
                                      .resolve(painter.textDirection)
                                      .toRRect(fullLineRect)));
                              }

                              ///draw full line
                              canvas.drawRect(
                                  fullLineRect, backgroundTextSpan.background);

                              if (backgroundTextSpan.clipBorderRadius != null) {
                                canvas.restore();
                              }
                            }
                          }
                        } else {
                          if (backgroundTextSpan.clipBorderRadius != null) {
                            canvas.save();
                            canvas.clipPath(Path()
                              ..addRRect(backgroundTextSpan.clipBorderRadius!
                                  .resolve(painter.textDirection)
                                  .toRRect(textRect)));
                          }

                          canvas.drawRect(
                              textRect, backgroundTextSpan.background);

                          if (backgroundTextSpan.clipBorderRadius != null) {
                            canvas.restore();
                          }
                        }

                        ///remember return true to igore default background
                        return true;
                      }),
                ])),
              ],
            )),
      ),
    );
  }
}