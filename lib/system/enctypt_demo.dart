import 'package:flutter/material.dart';
import 'package:flutter_practice2/util/function_util.dart';

class EncryptDemo extends StatefulWidget {
  const EncryptDemo({Key? key}) : super(key: key);

  @override
  State<EncryptDemo> createState() => EncryptDemoState();
}

class EncryptDemoState extends State<EncryptDemo> with WidgetsBindingObserver {

  late FunctionUtil _functionUtil;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('$state');
  }

  @override
  void initState() {
    print('EncryptDemo initState');
    _functionUtil = FunctionUtil();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    print('EncryptDemo didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant EncryptDemo oldWidget) {
    // 元件發生變化
    print('EncryptDemo didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    print('EncryptDemo setState');
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    print('EncryptDemo deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    print('EncryptDemo dispose');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _functionUtil.initSizedBox(20.0),
          _functionUtil.initText2('Encrypt 加密', Colors.black, Colors.transparent, 24),
          _functionUtil.initSizedBox(20.0),
          _functionUtil.initText2('AES', Colors.black, Colors.transparent, 20),
          _functionUtil.initSizedBox(20.0)
       ]
    );
  }

  _setAES(){
    final plainText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit';
  }

}