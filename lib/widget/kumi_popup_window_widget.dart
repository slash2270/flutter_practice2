import 'package:flutter/material.dart';
import 'package:kumi_popup_window/kumi_popup_window.dart';

class KumiPopupWindowWidget extends StatefulWidget {
  const KumiPopupWindowWidget({Key? key, this.title}) : super(key: key);

  // 這個小部件是您的應用程序的主頁。 它是有狀態的，意思是
  // 它有一個 State 對象（定義如下），其中包含影響的字段
  // 它看起來如何。

  // 這個類是狀態的配置。 它保存值（在這個
  // 由父級（在本例中為 App 小部件）提供的標題）和
  // 由 State 的 build 方法使用。 Widget 子類中的字段是
  // 始終標記為“最終”。

  final String? title;

  @override
  _KumiPopupWindowWidgetState createState() => _KumiPopupWindowWidgetState();
}

class _KumiPopupWindowWidgetState extends State<KumiPopupWindowWidget> {
  GlobalKey btnKey = GlobalKey();
  KumiPopupWindow? popupWindow;

  ValueNotifier<bool> isSelect = ValueNotifier(false);
  var aaa = "false";

  @override
  Widget build(BuildContext context) {
    // 每次調用 setState 時都會重新運行此方法，例如 done通過上面的 _incrementCounter 方法。
    // Flutter 框架已經過優化，可以重新運行構建方法快，這樣你就可以重建任何需要更新的東西而不是必須單獨更改小部件的實例。
    return Scaffold(
      appBar: AppBar(
        // 這裡我們從創建的 MyHomePage 對像中獲取值App.build 方法，並使用它來設置我們的 appbar 標題。
        title: Text(widget.title ?? ""),
      ),
      body: Center(
        // 中心是一個佈局小部件。 它需要一個孩子並將其定位在父節點的中間。
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ValueListenableBuilder(
                valueListenable: isSelect,
                builder: (context, bool select, child) {
                  return Text(isSelect.value == false ? "彈出子函數 onclick 為 false" : "彈出子函數 onclick 為 true");
                }),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
                key: btnKey,
                height: 50,
                color: Colors.redAccent,
                onPressed: () {
                  /*showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      builder: (BuildContext context) {
                        return StatefulBuilder(
                          builder: (context1, StateSetter setBottomSheetState) {
                            return SingleChildScrollView(
                              child: Container(
                                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        setBottomSheetState(() {
                                        aaa = "true";
                                      });
                                      },
                                      child: Text("asdasdasd"),
                                    ),
                                    TextField(
                                      controller: TextEditingController(text: aaa),
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [WhitelistingTextInputFormatter.digitsOnly], //只允许输入数字
                                      textInputAction: TextInputAction.done,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      });*/
                  showPopupWindow(
                    context,
                    //childSize:Size(240, 800),
                    gravity: KumiPopupGravity.centerBottom,
                    //curve: Curves.elasticOut,
                    bgColor: Colors.grey.withOpacity(0.5),
                    clickOutDismiss: true,
                    clickBackDismiss: true,
                    customAnimation: false,
                    customPop: false,
                    customPage: false,
                    // targetRenderBox: (btnKey.currentContext.findRenderObject() as RenderBox),
                    //needSafeDisplay: true,
                    underStatusBar: false,
                    underAppBar: false,
                    //offsetX: -180,
                    //offsetY: 50,
                    duration: const Duration(milliseconds: 300),
                    onShowStart: (pop) {
                      print("showStart");
                    },
                    onShowFinish: (pop) {
                      print("showFinish");
                    },
                    onDismissStart: (pop) {
                      print("dismissStart");
                    },
                    onDismissFinish: (pop) {
                      print("dismissFinish");
                    },
                    onClickOut: (pop) {
                      print("onClickOut");
                    },
                    onClickBack: (pop) {
                      print("onClickBack");
                    },
                    childFun: (pop) {
                      return StatefulBuilder(
                          key: GlobalKey(),
                          builder: (popContext, popState) {
                            return GestureDetector(
                              onTap: () {
                                //isSelect.value = !isSelect.value;
                                popState(() {
                                  aaa = "sasdasd";
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                height: 800,
                                width: 300,
                                color: Colors.redAccent,
                                alignment: Alignment.center,
                                child: Text(aaa),
                              ),
                            );
                          });
                    },
                  );
                },
                child: const Text("cupertino")),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}