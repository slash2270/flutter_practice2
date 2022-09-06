// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_beautiful_popup/pinput_demo.dart';
// import 'package:flutter_beautiful_popup/templates/Authentication.dart';
// import 'package:flutter_beautiful_popup/templates/BlueRocket.dart';
// import 'package:flutter_beautiful_popup/templates/Camera.dart';
// import 'package:flutter_beautiful_popup/templates/Coin.dart';
// import 'package:flutter_beautiful_popup/templates/Fail.dart';
// import 'package:flutter_beautiful_popup/templates/Geolocation.dart';
// import 'package:flutter_beautiful_popup/templates/Gift.dart';
// import 'package:flutter_beautiful_popup/templates/GreenRocket.dart';
// import 'package:flutter_beautiful_popup/templates/Notification.dart';
// import 'package:flutter_beautiful_popup/templates/OrangeRocket2.dart';
// import 'package:flutter_beautiful_popup/templates/RedPacket.dart';
// import 'package:flutter_beautiful_popup/templates/Success.dart';
// import 'package:flutter_beautiful_popup/templates/Term.dart';
// import 'package:flutter_beautiful_popup/templates/Thumb.dart';
// import 'package:flutter_colorpicker/flutter_colorpicker.dart';
// import 'package:flutter_highlight/flutter_highlight.dart';
// import 'package:flutter_highlight/themes/github-gist.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'beautiful_popup_template.dart';
//
// class BeautifulPopupDemo extends StatefulWidget {
//   const BeautifulPopupDemo({Key? key}) : super(key: key);
//
//   @override
//   _BeautifulPopupDemoState createState() => _BeautifulPopupDemoState();
// }
//
// class _BeautifulPopupDemoState extends State<BeautifulPopupDemo> {
//   @override
//   initState() {
//     super.initState();
//     final templates = [
//       TemplateGift,
//       TemplateCamera,
//       TemplateNotification,
//       TemplateGeolocation,
//       TemplateSuccess,
//       TemplateFail,
//       // TemplateOrangeRocket,
//       TemplateGreenRocket,
//       TemplateOrangeRocket2,
//       TemplateCoin,
//       TemplateBlueRocket,
//       TemplateThumb,
//       TemplateAuthentication,
//       TemplateTerm,
//       TemplateRedPacket,
//     ];
//
//     demos = templates.map((template) {
//       return BeautifulPopup(
//         context: context,
//         template: template,
//       );
//     }).toList();
//   }
//
//   List<BeautifulPopup> demos = [];
//   BeautifulPopup? activeDemo;
//
//   Widget get showcases {
//     final popup = BeautifulPopup.customize(
//       context: context,
//       build: (options) => BeautifulPopupTemp(options:options),
//     );
//     return Flex(
//       mainAxisSize: MainAxisSize.max,
//       direction: Axis.vertical,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Container(
//           margin: const EdgeInsets.fromLTRB(20, 20, 10, 10),
//           decoration: const BoxDecoration(
//             border: Border(
//               top: BorderSide(
//                 color: Colors.white,
//                 width: 1,
//               ),
//             ),
//           ),
//           child: Flex(
//             direction: Axis.horizontal,
//             children: <Widget>[
//               Text(
//                 '所有模板:',
//                 style: Theme.of(context).textTheme.headline4?.merge(
//                   const TextStyle(
//                     backgroundColor: Colors.transparent,
//                   ),
//                 ),
//               ),
//               const Spacer(),
//               FlatButton(
//                 child: const Text('客製化'),
//                 onPressed: () {
//                   popup.show(
//                     title: '範例',
//                     content: Container(
//                       color: Colors.black12,
//                       child: const Text(
//                           '此彈出窗口向您展示如何自定義您自己的美麗彈出模板。'),
//                     ),
//                     actions: [
//                       popup.button(
//                         label: 'Code',
//                         labelStyle: const TextStyle(),
//                         onPressed: () async {
//                           await _launchURL(
//                             'https://github.com/jaweii/Flutter_beautiful_popup/blob/master/example/lib/MyTemplate.dart',
//                           );
//                         },
//                       ),
//                     ],
//                   );
//                 },
//               )
//             ],
//           ),
//         ),
//         Expanded(
//           child: SingleChildScrollView(
//             padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
//             child: Wrap(
//               alignment: WrapAlignment.start,
//               spacing: 20,
//               runSpacing: 30,
//               children: demos.map((demo) {
//                 final i = demos.indexWhere((d) => d.template == demo.template);
//                 return InkWell(
//                   borderRadius: BorderRadius.circular(10),
//                   child: Container(
//                     constraints: const BoxConstraints(minWidth: 160),
//                     padding: const EdgeInsets.all(10),
//                     decoration: BoxDecoration(
//                       color: demo.primaryColor?.withOpacity(0.25),
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
//                         Image.asset(
//                           demo.instance.illustrationKey,
//                           height: 54,
//                           width: 100,
//                           fit: BoxFit.fitWidth,
//                           alignment: Alignment.topCenter,
//                         ),
//                         const SizedBox(height: 10),
//                         Text(
//                           'Demo-${i + 1}\n${demo.instance.runtimeType}',
//                           textAlign: TextAlign.center,
//                         )
//                       ],
//                     ),
//                   ),
//                   onTap: () {
//                     openDemo(demo: demo);
//                   },
//                 );
//               }).toList(),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget get body {
//     final exampleCode = '''
// final popup = BeautifulPopup(
//   context: context,
//   template: ${activeDemo?.instance.runtimeType ?? '// Select a template in right'},
// );
//
// popup.show(
//   title: 'String',
//   content: 'BeautifulPopup is a flutter package that is responsible for beautify your app popups.',
//   actions: [
//     popup.button(
//       label: 'Close',
//       onPressed: Navigator.of(context).pop,
//     ),
//   ],
// );
//     ''';
//     if (MediaQuery.of(context).size.width > 1024) {
//       return Flex(
//         direction: Axis.horizontal,
//         children: <Widget>[
//           Flexible(
//             flex: 1,
//             fit: FlexFit.tight,
//             child: Container(
//               color: activeDemo?.primaryColor?.withOpacity(0.25) ??
//                   Theme.of(context).primaryColor.withOpacity(0.25),
//               child: Flex(
//                 mainAxisSize: MainAxisSize.max,
//                 direction: Axis.vertical,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Container(
//                     margin: const EdgeInsets.fromLTRB(20, 20, 10, 10),
//                     child: Text(
//                       '# Usage',
//                       style: Theme.of(context).textTheme.headline4?.merge(
//                         const TextStyle(
//                           color: Colors.black54,
//                           backgroundColor: Colors.transparent,
//                         ),
//                       ),
//                     ),
//                   ),
//                   Expanded(
//                     child: Container(
//                       alignment: Alignment.center,
//                       child: HighlightView(
//                         exampleCode,
//                         language: 'dart',
//                         theme: githubGistTheme,
//                         padding: const EdgeInsets.all(30),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Flexible(
//             flex: 1,
//             fit: FlexFit.tight,
//             child: showcases,
//           ),
//         ],
//       );
//     } else {
//       return showcases;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           'Beautiful Popup',
//           style: TextStyle(color: Colors.white),
//         ),
//         elevation: 2,
//         backgroundColor:
//         activeDemo?.primaryColor ?? Theme.of(context).primaryColor,
//         actions: <Widget>[
//           FlatButton(
//             child: Image.asset(
//               'assets/github.png',
//               width: 32,
//               height: 32,
//             ),
//             onPressed: () async {
//               await _launchURL(
//                 'https://github.com/jaweii/Flutter_beautiful_popup',
//               );
//             },
//           ),
//         ],
//       ),
//       body: body,
//     );
//   }
//
//   void changeColor(
//       BeautifulPopup demo,
//       void Function(Color? color)? callback,
//       ) {
//     Color? color = demo.primaryColor?.withOpacity(0.5);
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('選一個顏色!'),
//         content: SingleChildScrollView(
//           child: ColorPicker(
//             pickerColor: color == null ? const Color(0xFF000000) : color!,
//             onColorChanged: (c) => color = c,
//             showLabel: true,
//             pickerAreaHeightPercent: 0.8,
//           ),
//         ),
//         actions: <Widget>[
//           FlatButton(
//             child: const Text('知道了'),
//             onPressed: () async {
//               callback?.call(color);
//             },
//           ),
//         ],
//       ),
//     );
//   }
//
//   openDemo({
//     required BeautifulPopup demo,
//     dynamic title = '字串',
//     dynamic content = '美麗的彈出視窗是一個 Flutter 包，負責美化你的應用彈出窗口。',
//   }) {
//     assert(title is Widget || title is String);
//     setState(() {
//       activeDemo = demo;
//     });
//     demo.show(
//       title: title,
//       content: content,
//       actions: <Widget>[
//         demo.button(
//           label: '重新著色',
//           onPressed: () {
//             changeColor(demo, (color) async {
//               demo = await BeautifulPopup(
//                 context: context,
//                 template: demo.template,
//               ).recolor(color!);
//               Navigator.of(context).popUntil((route) {
//                 if (route.settings.name == '/') return true;
//                 return false;
//               });
//               openDemo(demo: demo);
//             });
//           },
//         ),
//         demo.button(
//           label: '展示更多',
//           outline: true,
//           onPressed: () {
//             Navigator.of(context).pop();
//             if (title is Widget) {
//               return openDemo(demo: demo);
//             }
//             getTitle() {
//               return Opacity(
//                 opacity: 0.95,
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: <Widget>[
//                     Text(
//                       '[元件]',
//                       style: TextStyle(
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20,
//                         color: demo.primaryColor,
//                         backgroundColor: Colors.white70,
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(top: 20),
//                       child: Icon(
//                         Icons.star,
//                         color: demo.primaryColor?.withOpacity(0.75),
//                         size: 10,
//                       ),
//                     )
//                   ],
//                 ),
//               );
//             }
//
//             getContent() {
//               return Container(
//                 decoration: BoxDecoration(
//                   color: Colors.black.withOpacity(0.1),
//                 ),
//                 child: Scrollbar(
//                   child: SingleChildScrollView(
//                     child: Column(
//                       children: <Widget>[
//                         CupertinoButton(
//                           child: const Text('移除所有按鈕'),
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                             demo = BeautifulPopup(
//                               context: context,
//                               template: demo.template,
//                             );
//                             demo.show(
//                               title: getTitle(),
//                               content: getContent(),
//                               actions: [],
//                             );
//                           },
//                         ),
//                         CupertinoButton(
//                           child: const Text('保持一個按鈕'),
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                             demo = BeautifulPopup(
//                               context: context,
//                               template: demo.template,
//                             );
//                             demo.show(
//                               title: getTitle(),
//                               content: getContent(),
//                               actions: [
//                                 demo.button(
//                                   label: '一個按鈕',
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                   },
//                                 ),
//                               ],
//                             );
//                           },
//                         ),
//                         CupertinoButton(
//                           child: const Text('移除關閉按鈕'),
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                             demo = BeautifulPopup(
//                               context: context,
//                               template: demo.template,
//                             );
//                             demo.show(
//                               title: getTitle(),
//                               content: getContent(),
//                               close: Container(),
//                               barrierDismissible: true,
//                               actions: [
//                                 demo.button(
//                                   label: '關閉',
//                                   onPressed: () {
//                                     Navigator.of(context).pop();
//                                   },
//                                 ),
//                               ],
//                             );
//                           },
//                         ),
//                         CupertinoButton(
//                           child: const Text('更改按鈕方向'),
//                           onPressed: () {
//                             Navigator.of(context).pop();
//                             demo = BeautifulPopup(
//                               context: context,
//                               template: demo.template,
//                             );
//                             demo.show(
//                               title: getTitle(),
//                               content: Flex(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 direction: Axis.vertical,
//                                 children: <Widget>[
//                                   const Text('1. blabla... \n2. blabla...'),
//                                   const Spacer(),
//                                   demo.button(
//                                     label: '同意',
//                                     onPressed: () {},
//                                   ),
//                                   Container(
//                                     alignment: Alignment.center,
//                                     child: FlatButton(
//                                       hoverColor: Colors.transparent,
//                                       highlightColor: Colors.transparent,
//                                       onPressed: Navigator.of(context).pop,
//                                       child: const Text('關閉'),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               barrierDismissible: true,
//                               actions: [],
//                             );
//                           },
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               );
//             }
//
//             openDemo(
//               demo: demo,
//               title: getTitle(),
//               content: getContent(),
//             );
//           },
//         )
//       ],
//     );
//   }
//
//   Future<void> _launchURL(String _url) async {
//     await canLaunch(_url) ? await launch(_url) : throw '無法啟動 $_url';
//   }
// }