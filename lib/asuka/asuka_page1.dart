// import 'package:asuka/snackbars/asuka_snack_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_practice2/asuka/asuka_page2.dart';
//
// import 'asuka_controller.dart';
//
// class AsukaPage1 extends StatefulWidget {
//   const AsukaPage1 ({Key? key}) : super(key: key);
//
//   @override
//   State<AsukaPage1 > createState() => _AsukaPage1State();
// }
//
// class _AsukaPage1State extends State<AsukaPage1> {
//   final homeController = AsukaController();
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       builder: AsukaBuilder,
//       home: Scaffold(
//         backgroundColor: Colors.grey[200],
//         appBar: AppBar(
//           centerTitle: true,
//           title: const Text('Asuka Page1'),
//         ),
//         body: ListView(
//           padding: const EdgeInsets.all(20),
//           children: [
//             ElevatedButton(
//               child: const Text('Go Page2'),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => const AsukaPage2(),
//                   ),
//                 );
//               },
//             ),
//             const SizedBox(height: 10),
//             const Divider(),
//             const SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: homeController.onClickSnackBar,
//               child: const Text('蛇視窗'),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: homeController.onClickDialog,
//               child: const Text('對話視窗'),
//             ),
//             const SizedBox(height: 10),
//             ElevatedButton(
//               onPressed: homeController.onClickBottomSheet,
//               child: const Text('模態底版'),
//             ),
//             ElevatedButton(
//               child: const Text('蛇警告'),
//               onPressed: () {
//                 AsukaSnackbar.warning('警告').show();
//               },
//             ),
//             ElevatedButton(
//               child: const Text('蛇同意'),
//               onPressed: () {
//                 AsukaSnackbar.success('同意').show();
//               },
//             ),
//             ElevatedButton(
//               child: const Text('蛇警報框'),
//               onPressed: () {
//                 AsukaSnackbar.alert('警報').show();
//               },
//             ),
//             ElevatedButton(
//               child: const Text('蛇信息'),
//               onPressed: () {
//                 AsukaSnackbar.info('信息').show();
//               },
//             ),
//             ElevatedButton(
//               child: const Text('蛇訊息'),
//               onPressed: () {
//                 AsukaSnackbar.message('訊息').show();
//               },
//             ),
//             Row(
//               children: [
//                 Hero(
//                   tag: 'HeroTag',
//                   child: Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(100),
//                       color: Colors.red,
//                     ),
//                     width: 50,
//                     height: 50,
//                   ),
//                 ),
//               ],
//             ),
//             const TextField(),
//             ElevatedButton(
//               child: const Text('顯示模態底頁'),
//               onPressed: () {
//                 homeController.onClickModalBottomSheet();
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }