// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
//
// import 'package:url_launcher/url_launcher.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'live_demo.dart';
//
// class Privacy extends StatefulWidget {
//   const Privacy({Key? key}) : super(key: key);
//
//   @override
//   State createState() => _PrivacyState();
// }
//
// class _PrivacyState extends State<Privacy> {
//   bool _privacyAgree = false;
//   bool _btnEnabled = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return _privacyAgree ? const Home() : PrivacyDisplay(_btnEnabled, _onReadPrivacy, _onAgreePrivacy);
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     asyncInit();
//   }
//
//   void asyncInit() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       _privacyAgree = prefs.getBool('login')?? false;
//     });
//   }
//
//   void _onReadPrivacy() {
//     setState(() {
//       _btnEnabled = !_btnEnabled;
//     });
//   }
//
//   void _onAgreePrivacy()  async {
//     setState(() {
//       _privacyAgree = true;
//     });
//
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setBool("login", _privacyAgree);
//   }
// }
//
// class PrivacyDisplay extends StatelessWidget {
//   final bool _btnEnabled;
//   final VoidCallback _onAgreePrivacy;
//   final VoidCallback _onReadPrivacy;
//   const PrivacyDisplay(this._btnEnabled, this._onReadPrivacy, this._onAgreePrivacy, {Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('SRS: Privacy')),
//       body: Container(
//         padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 MaterialButton(
//                   onPressed: _btnEnabled ? _onAgreePrivacy : null,
//                   color: const Color(0xffFFDB2E),
//                   textColor: const Color(0xff202326),
//                   disabledColor: const Color(0xffdddddd),
//                   height: 44.0,
//                   minWidth: 240.0,
//                   elevation: 0.0,
//                   child: const Text(
//                     "開始使用",
//                     style: TextStyle(
//                         fontSize: 15.0, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ],
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Checkbox(value: _btnEnabled, onChanged: (bool) {
//                   _onReadPrivacy();
//                 }),
//                 Text.rich(
//                   TextSpan(
//                     children: [
//                       TextSpan(
//                         text: '我已閱讀並同意',
//                         recognizer: TapGestureRecognizer()
//                           ..onTap = () {
//                             _onReadPrivacy();
//                           },
//                       ),
//                       TextSpan(
//                         text: '《隱私政策》',
//                         style: const TextStyle(color: Color(0xFF00CED2)),
//                         recognizer: TapGestureRecognizer()
//                           ..onTap = () {
//                             launch('https://ossrs.net/privacy_cn');
//                           },
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }