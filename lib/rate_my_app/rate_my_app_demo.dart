import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/rate_my_app/rate_my_app_content.dart';
import 'package:rate_my_app/rate_my_app.dart';

/// 主要評價我的應用程序測試小部件的主體。
class RateMyAppDemo extends StatefulWidget {
  const RateMyAppDemo({Key? key}) : super(key: key);

  /// 創建一個新的 Rate my app 測試應用實例。


  @override
  State<StatefulWidget> createState() => _RateMyAppDemoState();
}

/// 主評分我的應用測試小部件的主體狀態。
class _RateMyAppDemoState extends State<RateMyAppDemo> {
  /// 小部件構建器。
  WidgetBuilder builder = buildProgressIndicator;

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: const Text('Rate my app Demo'),
      ),
      body: RateMyAppBuilder(
        builder: builder,
        onInitialized: (context, rateMyApp) {
          setState(() =>
          builder = (context) => RateMyAppContentWidget(rateMyApp: rateMyApp));
          for (var condition in rateMyApp.conditions) {
            if (condition is DebuggableCondition) {
              LogUtil.e(condition.valuesAsString); // 我們遍歷我們的條件列表並打印所有可調試的條件。.
            }
          }

          LogUtil.e('是否滿足所有條件 ? ${rateMyApp.shouldOpenDialog ? '是' : '否'}');

          if (rateMyApp.shouldOpenDialog) {
            rateMyApp.showRateDialog(context);
          }
        },
      ),
    ),
  );

  /// 構建進度指示器，允許等待 Rate my app 初始化。
  static Widget buildProgressIndicator(BuildContext context) => const Center(child: CircularProgressIndicator());
}