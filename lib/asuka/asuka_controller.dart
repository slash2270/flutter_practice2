// import 'package:asuka/asuka.dart';
// import 'package:flutter/material.dart';
//
// class AsukaController {
//   void onClickSnackBar() {
//     Asuka.showSnackBar(const SnackBar(content: Text('新的蛇行酒吧')));
//   }
//
//   void onClickDialog() {
//     Asuka.showDialog(
//       builder: (context) => AlertDialog(
//         title: const Text('彈跳窗'),
//         content: const Text('這是彈跳內容'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: const Text('取消'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.pop(context);
//             },
//             child: const Text('確認'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   void onClickBottomSheet() {
//     Asuka.showBottomSheet((context) {
//       return Material(
//         elevation: 7,
//         child: SizedBox(
//           height: MediaQuery.of(context).size.height / 2,
//           child: ListView(
//             children: [
//               const ListTile(
//                 title: Text('選項1'),
//               ),
//               const ListTile(
//                 title: Text('選項2'),
//               ),
//               ListTile(
//                 title: const Text('取消'),
//                 onTap: () => Navigator.pop(context),
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
//
//   void onClickModalBottomSheet() {
//     Asuka.showModalBottomSheet(
//       builder: (context) => Material(
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(16),
//           topRight: Radius.circular(16),
//         ),
//         elevation: 7,
//         child: SizedBox(
//           height: MediaQuery.of(context).size.height / 2,
//           child: ListView(
//             children: [
//               const ListTile(
//                 title: Text('選項1'),
//               ),
//               const ListTile(
//                 title: Text('選項2'),
//               ),
//               ListTile(
//                 title: const Text('取消'),
//                 onTap: () => Navigator.pop(context),
//               ),
//             ],
//           ),
//         ),
//       ),
//       backgroundColor: Colors.transparent,
//     );
//   }
// }