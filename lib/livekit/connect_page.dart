// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_practice2/livekit/exts.dart';
// import 'package:flutter_practice2/livekit/room_page.dart';
// import 'package:flutter_practice2/livekit/text_field.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:livekit_client/livekit_client.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../az_listview/common/index.dart';
//
// class ConnectPage extends StatefulWidget {
//   ConnectPage({Key? key, required this.token, required this.url}) : super(key: key);
//
//   String token, url;
//
//   @override
//   State<StatefulWidget> createState() => _ConnectPageState();
// }
//
// class _ConnectPageState extends State<ConnectPage> {
//
//   static const _storeKeyUri = 'uri';
//   static const _storeKeyToken = 'token';
//   static const _storeKeySimulcast = 'simulcast';
//   static const _storeKeyAdaptiveStream = 'adaptive-stream';
//   static const _storeKeyDynacast = 'dynacast';
//   static const _storeKeyFastConnect = 'fast-connect';
//
//   late SharedPreferences _sP;
//   final _uriCtrl = TextEditingController();
//   final _tokenCtrl = TextEditingController();
//   bool _simulcast = true;
//   bool _adaptiveStream = true;
//   bool _dynacast = true;
//   bool _busy = false;
//   bool _fastConnect = false;
//
//   @override
//   void initState() {
//     super.initState();
//     _readPrefs();
//   }
//
//   @override
//   void dispose() {
//     _uriCtrl.dispose();
//     _tokenCtrl.dispose();
//     _sP.clear();
//     super.dispose();
//   }
//
//   // Read saved URL and Token
//   Future<void> _readPrefs() async {
//     final prefs = await SharedPreferences.getInstance();
//     // _uriCtrl.text = const bool.hasEnvironment('URL')
//     //     ? const String.fromEnvironment('URL')
//     //     : prefs.getString(_storeKeyUri) ?? '';
//     // _tokenCtrl.text = const bool.hasEnvironment('TOKEN')
//     //     ? const String.fromEnvironment('TOKEN')
//     //     : prefs.getString(_storeKeyToken) ?? '';
//     setState(() {
//       _tokenCtrl.text = widget.token;
//       _uriCtrl.text = widget.url;
//       _simulcast = prefs.getBool(_storeKeySimulcast) ?? true;
//       _adaptiveStream = prefs.getBool(_storeKeyAdaptiveStream) ?? true;
//       _dynacast = prefs.getBool(_storeKeyDynacast) ?? true;
//       _fastConnect = prefs.getBool(_storeKeyFastConnect) ?? false;
//     });
//   }
//
//   // Save URL and Token
//   Future<void> _writePrefs() async {
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.setString(_storeKeyUri, _uriCtrl.text);
//     await prefs.setString(_storeKeyToken, _tokenCtrl.text);
//     await prefs.setBool(_storeKeySimulcast, _simulcast);
//     await prefs.setBool(_storeKeyAdaptiveStream, _adaptiveStream);
//     await prefs.setBool(_storeKeyDynacast, _dynacast);
//     await prefs.setBool(_storeKeyFastConnect, _fastConnect);
//   }
//
//   Future<void> _connect(BuildContext ctx) async {
//     try {
//       setState(() {
//         _busy = true;
//       });
//
//       // 為了方便，保存URL和Token
//       await _writePrefs();
//
//       // LogUtil.e('LiveKit Connecting with url: ${_uriCtrl.text}, ''token: ${_tokenCtrl.text}...');
//
//       // 創建新房間
//       final room = Room();
//
//       // 連接前創建監聽器
//       final listener = room.createListener();
//
//       // 嘗試連接房間
//       // 如果由於任何原因失敗，這將拋出異常。
//       await room.connect(
//         _uriCtrl.text,
//         _tokenCtrl.text,
//         roomOptions: RoomOptions(
//           adaptiveStream: _adaptiveStream,
//           dynacast: _dynacast,
//           defaultVideoPublishOptions: VideoPublishOptions(
//             simulcast: _simulcast,
//           ),
//           defaultScreenShareCaptureOptions:
//           const ScreenShareCaptureOptions(useiOSBroadcastExtension: true),
//         ),
//         fastConnectOptions: _fastConnect
//             ? FastConnectOptions(
//           microphone: const TrackOption(enabled: true),
//           camera: const TrackOption(enabled: true),
//         )
//             : null,
//       );
//       await Navigator.push<void>(
//         ctx,
//         MaterialPageRoute(builder: (_) => RoomPage(room, listener)),
//       );
//     } catch (error) {
//       LogUtil.e('LiveKit 不能連接 $error');
//       await ctx.showErrorDialog(error);
//     } finally {
//       setState(() {
//         _busy = false;
//       });
//     }
//   }
//
//   void _setSimulcast(bool? value) async {
//     if (value == null || _simulcast == value) return;
//     setState(() {
//       _simulcast = value;
//     });
//   }
//
//   void _setAdaptiveStream(bool? value) async {
//     if (value == null || _adaptiveStream == value) return;
//     setState(() {
//       _adaptiveStream = value;
//     });
//   }
//
//   void _setDynacast(bool? value) async {
//     if (value == null || _dynacast == value) return;
//     setState(() {
//       _dynacast = value;
//     });
//   }
//
//   void _setFastConnect(bool? value) async {
//     if (value == null || _fastConnect == value) return;
//     setState(() {
//       _fastConnect = value;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) => Scaffold(
//     body: Container(
//       color: Colors.yellow.shade900,
//       alignment: Alignment.center,
//       child: SingleChildScrollView(
//         child: Container(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 20,
//             vertical: 20,
//           ),
//           constraints: const BoxConstraints(maxWidth: 400),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 70),
//                 child: SvgPicture.asset(
//                   'assets/images/logo-dark.svg',
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 25),
//                 child: LKTextField(
//                   label: '伺服器網址',
//                   ctrl: _uriCtrl,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 25),
//                 child: LKTextField(
//                   label: '令牌',
//                   ctrl: _tokenCtrl,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 5),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text('聯播'),
//                     Switch(
//                       value: _simulcast,
//                       onChanged: (value) => _setSimulcast(value),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 5),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text('自適應流'),
//                     Switch(
//                       value: _adaptiveStream,
//                       onChanged: (value) => _setAdaptiveStream(value),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 5),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text('快速連接'),
//                     Switch(
//                       value: _fastConnect,
//                       onChanged: (value) => _setFastConnect(value),
//                     ),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 25),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     const Text('動態廣播'),
//                     Switch(
//                       value: _dynacast,
//                       onChanged: (value) => _setDynacast(value),
//                     ),
//                   ],
//                 ),
//               ),
//               ElevatedButton(
//                 onPressed: _busy ? null : () => _connect(context),
//                 child: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     if (_busy)
//                       const Padding(
//                         padding: EdgeInsets.only(right: 10),
//                         child: SizedBox(
//                           height: 15,
//                           width: 15,
//                           child: CircularProgressIndicator(
//                             color: Colors.white,
//                             strokeWidth: 2,
//                           ),
//                         ),
//                       ),
//                     const Text('連接'),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     ),
//   );
//
// }