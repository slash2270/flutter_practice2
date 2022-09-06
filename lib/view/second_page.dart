import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/demo/draganddrop_demo.dart';
import 'package:flutter_practice2/util/function_util.dart';

import '../drawer/left_drawer.dart';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return SecondPageState();
  }
}

class SecondPageState extends State<SecondPage> {

  late FunctionUtil _functionUtil;

  @override
  void initState() {
    super.initState();
    _functionUtil = FunctionUtil();
    _init();
    //_initWithCtx();
  }

  void _init() {
    double screenWidth = ScreenUtil.getInstance().screenWidth;
    double screenHeight = ScreenUtil.getInstance().screenHeight;
    double screenDensity = ScreenUtil.getInstance().screenDensity;
    double statusBarHeight = ScreenUtil.getInstance().statusBarHeight;
    double bottomBarHeight = ScreenUtil.getInstance().bottomBarHeight;
    double appBarHeight = ScreenUtil.getInstance().appBarHeight;
    double adapterW100 = ScreenUtil.getInstance().getWidth(100);
    double adapterH100 = ScreenUtil.getInstance().getHeight(100);
    double adapterSp100 = ScreenUtil.getInstance().getSp(100);
    double adapterW100px = ScreenUtil.getInstance().getWidthPx(300);
    double adapterH100px = ScreenUtil.getInstance().getHeightPx(300);

    LogUtil.e("SecondPage _init screenWidth: $screenWidth, screenHeight: $screenHeight, screenDensity: $screenDensity, statusBarHeight: $statusBarHeight, bottomBarHeight: $bottomBarHeight, appBarHeight: $appBarHeight, adapterW100: $adapterW100, adapterH100: $adapterH100, adapterSp100: $adapterSp100, adapterW100px: $adapterW100px, adapterH100px: $adapterH100px");
  }

  void _initWithCtx() {
    double screenWidth = ScreenUtil.getScreenW(context);
    double screenHeight = ScreenUtil.getScreenH(context);
    double screenDensity = ScreenUtil.getScreenDensity(context);
    double statusBarHeight = ScreenUtil.getStatusBarH(context);
    double bottomBarHeight = ScreenUtil.getBottomBarH(context);
    double adapterW100 = ScreenUtil.getScaleW(context, 100);
    double adapterH100 = ScreenUtil.getScaleH(context, 100);
    double adapterSp100 = ScreenUtil.getScaleSp(context, 100);
    Orientation orientation = ScreenUtil.getOrientation(context);

    LogUtil.e("SecondPage _initWithCtx screenWidth: $screenWidth, screenHeight: $screenHeight, screenDensity: $screenDensity, statusBarHeight: $statusBarHeight, bottomBarHeight: $bottomBarHeight, adapterW100: $adapterW100, adapterH100: $adapterH100, adapterSp100: $adapterSp100");
  }

  @override
  Widget build(BuildContext context) {
    double statusBar = ScreenUtil.getInstance().statusBarHeight;
    double width = ScreenUtil.getInstance().screenWidth;
    double height = ScreenUtil.getInstance().screenHeight;
    LogUtil.e("SecondPage statusBar: $statusBar, width: $width, height: $height");
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: _functionUtil.initText("Second Page"),
          centerTitle: true,
          leading: Builder(builder: (BuildContext ctx) {
            return IconButton(
                color: Colors.white,
                icon: const Icon(Icons.density_medium),
                onPressed: () {
                  setState(() { });
                  Scaffold.of(ctx).openDrawer();
                });
          }),
        ),
        body: Stack(
          children: [
            const DragAndDropDemo(),//Click ? _ListView() : const MapWidget(),*/
            WillPopScope(
                onWillPop: () async {
                  return true;
                },
                child: Container())
          ],
        ),
        resizeToAvoidBottomInset: false,
        drawer: const LeftDrawer(),
      ),
    );
  }
}