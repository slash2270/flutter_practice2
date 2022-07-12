import 'package:flutter/material.dart';
import 'package:flutter_practice2/util/function_util.dart';
import 'package:sprintf/sprintf.dart';

class SprintFDemo extends StatefulWidget {
  const SprintFDemo({Key? key}) : super(key: key);

  @override
  State<SprintFDemo> createState() => SprintFDemoState();
}

class SprintFDemoState extends State<SprintFDemo> with WidgetsBindingObserver {

  late FunctionUtil _functionUtil;
  late String sprintF;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('$state');
  }

  @override
  void initState() {
    print('SprintFDemo initState');
    _functionUtil = FunctionUtil();
    _setSprintF();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    print('SprintFDemo didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant SprintFDemo oldWidget) {
    // 元件發生變化
    print('SprintFDemo didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    print('SprintFDemo setState');
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    print('SprintFDemo deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    print('SprintFDemo dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _functionUtil.initText2('SprintF 加密', Colors.black, Colors.transparent, 24),
          _functionUtil.initSizedBox(20.0),
          _functionUtil.initText2(sprintF, Colors.black, Colors.transparent, 18),
        ]
    );
  }

  _setSprintF(){
    setState(() {
      sprintF = '${sprintf("%04i", [-42])}\t${sprintf("%s %s", ["Hello", "World"])}\t${sprintf("%#04x", [10])}';
    });
  }

}