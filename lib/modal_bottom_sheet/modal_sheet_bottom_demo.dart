import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'modal_bottom_sheet_web_frame.dart';
import 'modals/circular_modal.dart';
import 'modals/floating_modal.dart';
import 'modals/modal_complex_all.dart';
import 'modals/modal_fit.dart';
import 'modals/modal_inside_modal.dart';
import 'modals/modal_will_scope.dart';
import 'modals/modal_with_navigator.dart';
import 'modals/modal_with_nested_scroll.dart';
import 'modals/modal_with_scroll.dart';
import 'modals/modal_with_page_view.dart';
import 'examples/cupertino_share.dart';

// class ModalBottomSheetDemo extends StatelessWidget {
//   const ModalBottomSheetDemo({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(platform: TargetPlatform.iOS),
//       darkTheme: ThemeData.dark().copyWith(platform: TargetPlatform.iOS),
//       title: 'BottomSheet Modals',
//       builder: (context, Widget? child) => ModalBottomSheetWebFrame(
//         child: CupertinoTheme(
//           data: CupertinoThemeData(
//             brightness: Theme.of(context).brightness,
//             scaffoldBackgroundColor: CupertinoColors.systemBackground,
//           ),
//           child: child!,
//         ),
//       ),
//       onGenerateRoute: (RouteSettings settings) {
//         switch (settings.name) {
//           case '/':
//             return MaterialWithModalsPageRoute(
//                 builder: (_) => const ModalBottomSheetDemo(),
//                 settings: settings);
//         }
//         return MaterialPageRoute(
//           builder: (context) => Scaffold(
//             body: CupertinoScaffold(
//               body: Builder(
//                 builder: (context) => CupertinoPageScaffold(
//                   navigationBar: CupertinoNavigationBar(
//                     transitionBetweenRoutes: false,
//                     middle: const Text('Normal Navigation Presentation'),
//                     trailing: GestureDetector(
//                       child: const Icon(Icons.arrow_upward),
//                       onTap: () =>
//                           CupertinoScaffold.showCupertinoModalBottomSheet(
//                         expand: true,
//                         context: context,
//                         backgroundColor: Colors.transparent,
//                         builder: (context) => Stack(
//                           children: <Widget>[
//                             const ModalWithScroll(),
//                             Positioned(
//                               height: 40,
//                               left: 40,
//                               right: 40,
//                               bottom: 20,
//                               child: MaterialButton(
//                                 onPressed: () => Navigator.of(context).popUntil(
//                                     (route) => route.settings.name == '/'),
//                                 child: const Text('Pop back home'),
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                   child: Center(
//                     child: Container(),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           settings: settings,
//         );
//       },
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }

class ModalBottomSheetDemo extends StatefulWidget {
  const ModalBottomSheetDemo({Key? key}) : super(key: key);

  @override
  _ModalBottomSheetDemoState createState() => _ModalBottomSheetDemoState();
}

class _ModalBottomSheetDemoState extends State<ModalBottomSheetDemo> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        body: CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            transitionBetweenRoutes: false,
            middle: const Text('iOS13 Modal Presentation'),
            trailing: GestureDetector(
              child: const Icon(Icons.arrow_forward),
              onTap: () => Navigator.of(context).pushNamed('ss'),
            ),
          ),
          child: SizedBox.expand(
            child: SingleChildScrollView(
              primary: true,
              child: SafeArea(
                bottom: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                        title: const Text('Cupertino Photo Share Example'),
                        onTap: () => Navigator.of(context).push(
                            MaterialWithModalsPageRoute(
                                builder: (context) => CupertinoSharePage()))),
                    section('STYLES'),
                    ListTile(
                      title: const Text('Material fit'),
                      onTap: () => showMaterialModalBottomSheet(
                        expand: false,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const ModalFit(),
                      ),
                    ),
                    ListTile(
                      title: const Text('Bar Modal'),
                      onTap: () => showBarModalBottomSheet(
                        expand: true,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const ModalInsideModal(),
                      ),
                    ),
                    ListTile(
                      title: const Text('Avatar Modal'),
                      onTap: () => showAvatarModalBottomSheet(
                        expand: true,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const ModalInsideModal(),
                      ),
                    ),
                    ListTile(
                      title: const Text('Float Modal'),
                      onTap: () => showFloatingModalBottomSheet(
                        context: context,
                        builder: (context) => const ModalFit(),
                      ),
                    ),
                    ListTile(
                      title: const Text('Cupertino Modal fit'),
                      onTap: () => showCupertinoModalBottomSheet(
                        expand: false,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const ModalFit(),
                      ),
                    ),
                    section('COMPLEX CASES'),
                    ListTile(
                        title: const Text('Cupertino Small Modal forced to expand'),
                        onTap: () => showCupertinoModalBottomSheet(
                              expand: true,
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context) => const ModalFit(),
                            )),
                    ListTile(
                      title: const Text('Reverse list'),
                      onTap: () => showBarModalBottomSheet(
                        expand: true,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const ModalInsideModal(reverse: true),
                      ),
                    ),
                    ListTile(
                      title: const Text('Cupertino Modal inside modal'),
                      onTap: () => showCupertinoModalBottomSheet(
                        expand: true,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const ModalInsideModal(),
                      ),
                    ),
                    ListTile(
                        title: const Text('Cupertino Modal with inside navigation'),
                        onTap: () => showCupertinoModalBottomSheet(
                              expand: true,
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context) => const ModalWithNavigator(),
                            )),
                    ListTile(
                      title:
                          const Text('Cupertino Navigator + Scroll + WillPopScope'),
                      onTap: () => showCupertinoModalBottomSheet(
                        expand: true,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const ComplexModal(),
                      ),
                    ),
                    ListTile(
                      title: const Text('Modal with WillPopScope'),
                      onTap: () => showCupertinoModalBottomSheet(
                        expand: true,
                        context: context,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const ModalWillScope(),
                      ),
                    ),
                    ListTile(
                      title: const Text('Modal with Nested Scroll'),
                      onTap: () => showCupertinoModalBottomSheet(
                        expand: true,
                        context: context,
                        builder: (context) => const NestedScrollModal(),
                      ),
                    ),
                    ListTile(
                      title: const Text('Modal with PageView'),
                      onTap: () => showBarModalBottomSheet(
                        expand: true,
                        context: context,
                        builder: (context) => const ModalWithPageView(),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget section(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.caption,
      ),
    );
  }
}
