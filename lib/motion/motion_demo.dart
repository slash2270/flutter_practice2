import 'package:motion/motion.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:flutter_practice2/main.dart' as m;

import 'motion_card.dart';

const cardBorderRadius = BorderRadius.all(Radius.circular(25));

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// 初始化插件以確定陀螺儀的可用性。
  await Motion.instance.initialize();

  /// 全局設置 Motion 的更新間隔為每秒 60 幀。
  Motion.instance.setUpdateInterval(60.fps);

  m.main();
}

class MotionDemo extends StatelessWidget {
  const MotionDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const MaterialApp(
    title: 'Motion Demo',
    debugShowCheckedModeBanner: false,
    home: MotionDemoPage(),
  );
}

class MotionDemoPage extends StatefulWidget {
  const MotionDemoPage({Key? key}) : super(key: key);

  @override
  State<MotionDemoPage> createState() => _MotionDemoPageState();
}

class _MotionDemoPageState extends State<MotionDemoPage> {
  @override
  Widget build(BuildContext context) {
    if (Motion.instance.requiresPermission &&
        !Motion.instance.isPermissionGranted) {
      showPermissionRequestDialog(
        context,
        onDone: () {
          setState(() {});
        },
      );
    }

    return Scaffold(
        body: Stack(children: [
          Center(
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Text(
                      '陀螺儀範例',
                      style: Theme.of(context).textTheme.headline4?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: const Color.fromARGB(255, 0, 0, 0)),
                    )),
                const MotionCard(width: 280, height: 170, borderRadius: cardBorderRadius),
                Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 30),
                    child: Text(
                      '無運動',
                      style: Theme.of(context).textTheme.bodyText1,
                    )),
                Motion.elevated(
                  elevation: 70,
                  borderRadius: cardBorderRadius,
                  child: const MotionCard(
                      width: 280, height: 170, borderRadius: cardBorderRadius),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Text(
                      '無運動',
                      style: Theme.of(context).textTheme.bodyText1,
                    )),
              ]))
        ]));
  }

  Future<void> showPermissionRequestDialog(BuildContext context, {required Function() onDone}) async {
    return showDialog<void>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('需要權限'),
          content: const Text('在 iOS 13+ 上，您需要授予對陀螺儀的訪問權限。將請求權限才能繼續。'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context, '取消'),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Motion.instance.requestPermission();
              },
              child: const Text('確認'),
            ),
          ],
        ));
  }
}