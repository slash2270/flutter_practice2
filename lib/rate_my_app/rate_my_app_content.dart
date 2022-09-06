import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:rate_my_app/rate_my_app.dart';

/// 應用程序的主要內容小部件。
class RateMyAppContentWidget extends StatefulWidget {
  /// 評價我的應用程序實例。
  final RateMyApp rateMyApp;
  /// 創建一個新的內容小部件實例。
  const RateMyAppContentWidget({Key? key, required this.rateMyApp}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RateMyAppContentWidgetState();
}

/// 內容小部件狀態。
class _RateMyAppContentWidgetState extends State<RateMyAppContentWidget> {
  /// 包含所有可調試的條件。
  List<DebuggableCondition> debuggableConditions = [];

  /// 是否應該打開對話框。
  bool shouldOpenDialog = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => refresh());
  }

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 40),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (DebuggableCondition condition in debuggableConditions)
          textCenter(condition.valuesAsString),
          textCenter('是否滿足所有條件 ? ${shouldOpenDialog ? '是' : '否'}'),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: ElevatedButton(
            onPressed: () async {
              await widget.rateMyApp.showRateDialog(
                  context); // We launch the default Rate my app dialog.
              refresh();
            },
            child: const Text('啟動“評價我的應用”對話框'),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            await widget.rateMyApp.showStarRateDialog(context,
                actionsBuilder: (_, stars) => starRateDialogActionsBuilder(
                    context,
                    stars!)); // We launch the Rate my app dialog with stars.
            refresh();
          },
          child: const Text('啟動“評價我的應用”星形對話框'),
        ),
        ElevatedButton(
          onPressed: () async {
            await widget.rateMyApp
                .reset(); // We reset all Rate my app conditions values.
            refresh();
          },
          child: const Text('重來'),
        ),
      ],
    ),
  );

  /// 返回居中的文本。
  Text textCenter(String content) => Text(
    content,
    textAlign: TextAlign.center,
  );

  /// 允許刷新小部件狀態。
  void refresh() {
    setState(() {
      debuggableConditions = widget.rateMyApp.conditions.whereType<DebuggableCondition>().toList();
      shouldOpenDialog = widget.rateMyApp.shouldOpenDialog;
    });
  }

  List<Widget> starRateDialogActionsBuilder(
      BuildContext context, double stars) {
    final Widget cancelButton = RateMyAppNoButton(
      // We create a custom "Cancel" button using the RateMyAppNoButton class.
      widget.rateMyApp,
      text: MaterialLocalizations.of(context).cancelButtonLabel.toUpperCase(),
      callback: refresh,
    );
    if (stars == null || stars == 0) {
      // If there is no rating (or a 0 star rating), we only have to return our cancel button.
      return [cancelButton];
    }

    // Otherwise we can do some little more things...
    String message = '你放了 ${stars.round()} 顆星。 ';
    Color? color;
    switch (stars.round()) {
      case 1:
        message += '這個應用程序傷害了你嗎？';
        color = Colors.red;
        break;
      case 2:
        message += '那不是很酷的人。';
        color = Colors.orange;
        break;
      case 3:
        message += '嗯，這是平均水平。';
        color = Colors.yellow;
        break;
      case 4:
        message += '這很酷，就像這個應用一樣。';
        color = Colors.lime;
        break;
      case 5:
        message += '太好了！ <3';
        color = Colors.green;
        break;
    }

    return [
      TextButton(
        onPressed: () async {
          LogUtil.e(message);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
              backgroundColor: color,
            ),
          );

          // 這允許模擬點擊默認的“評分”按鈕，從而根據它更新條件（例如“不再打開”條件）：
          await widget.rateMyApp.callEvent(RateMyAppEventType.rateButtonPressed);
          Navigator.pop<RateMyAppDialogButton>(context, RateMyAppDialogButton.rate);
          refresh();
        },
        child:
        Text(MaterialLocalizations.of(context).okButtonLabel.toUpperCase()),
      ),
      cancelButton,
    ];
  }
}