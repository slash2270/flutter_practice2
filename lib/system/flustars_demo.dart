import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/util/function_util.dart';

import '../bean/city_bean.dart';

FunctionUtil _functionUtil = FunctionUtil();

class FlustarsDemo extends StatefulWidget {

  @override
  State<FlustarsDemo> createState() => FlustarsDemoState();
}

class FlustarsDemoState extends State<FlustarsDemo> with WidgetsBindingObserver {
  
  late String sprintF;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('$state');
  }

  @override
  void initState() {
    print('FlustarsDemo initState');
    _initAsync();
    /// 配置设计稿尺寸
    /// 如果设计稿尺寸默认配置一致，无需该设置。默认 width:360.0 / height:640.0 / density:3.0
    /// Configuration design draft size.
    /// If the default configuration of design draft size is the same, this setting is not required. default width:360.0 / height:640.0 / density:3.0
    //setDesignWHD(360.0, 640.0, density: 3);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    print('FlustarsDemo didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant FlustarsDemo oldWidget) {
    // 元件發生變化
    print('FlustarsDemo didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    print('FlustarsDemo setState');
    super.setState(fn);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    print('FlustarsDemo deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    // 銷毀
    print('FlustarsDemo dispose');
    super.dispose();
  }

  /// SpUtil example.
  void _initAsync() async {
    await SpUtil.getInstance();

    SpUtil.putString("username", "sky24");
    String? userName = SpUtil.getString("username", defValue: "");
    LogUtil.e("userName: $userName");

    /// save object example.
    /// 存储实体对象示例。
    CityBean city = CityBean(name: "成都市");
    SpUtil.putObject("loc_city", city);

    CityBean? hisCity = SpUtil.getObj(
        "loc_city", (v) => CityBean.fromJson(v as Map<String, dynamic>));
    LogUtil.e("City: ${hisCity == null ? "null" : hisCity.toString()}");

    /// save object list example.
    /// 存储实体对象list示例。
    List<CityBean> list = [];
    list.add(CityBean(name: "成都市"));
    list.add(CityBean(name: "北京市"));
    SpUtil.putObjectList("loc_city_list", list);

    List<CityBean>? dataList = SpUtil.getObjList(
        "loc_city_list", (v) => CityBean.fromJson(v as Map<String, dynamic>));
    LogUtil.e("CityList: ${dataList == null ? "null" : dataList.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          _functionUtil.initText2('Flustars 工具類', Colors.black, Colors.transparent, 24),
          _functionUtil.initSizedBox(20.0),
          FlustarsChild1(),
          FlustarsChild2(),
        ]
    );
  }
}

class FlustarsChild1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FlustarsChild1State();
  }
}

/// 在MainPage使用依赖不context方法获取屏幕参数及适配，需要build方法内调用[MediaQuery.of(context)]。
/// 或者使用依赖context方法获取屏幕参数及适配。
/// In MainPage, the dependency-free context method is used to obtain screen parameters and adaptions, which requires a call to [MediaQuery. of (context)] within the build method.
/// Or use context-dependent methods to obtain screen parameters and adaptions.
class FlustarsChild1State extends State<FlustarsChild1> {
  void test2() async {
    LogUtil.e("xxxxxxxxxxx test7......");
    await DirectoryUtil.getInstance();
    String? tempPath = DirectoryUtil.getTempPath(category: 'Pictures', fileName: 'demo', format: 'png');
    LogUtil.e("tempPath: $tempPath");

    String? appDocPath = DirectoryUtil.getAppDocPath(category: 'Pictures', fileName: 'demo', format: 'png');
    LogUtil.e("appDocPath: $appDocPath");

    String? appSupportPath = DirectoryUtil.getAppSupportPath(category: 'Pictures', fileName: 'demo', format: 'png');
    LogUtil.e("appSupportPath: $appSupportPath");

    String? storagePath = DirectoryUtil.getStoragePath(category: 'Pictures', fileName: 'demo', format: 'png');
    LogUtil.e("storagePath: $storagePath");
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    /// 如果使用依赖不context方法获取屏幕参数及适配，需要调用此方法。
    /// If you use a dependent context-free method to obtain screen parameters and adaptions, you need to call this method.
    MediaQuery.of(context);

    double statusBar = ScreenUtil.getInstance().statusBarHeight;
    double width = ScreenUtil.getInstance().screenWidth;
    double height = ScreenUtil.getInstance().screenHeight;
    double density = ScreenUtil.getInstance().screenDensity;
    double sp = ScreenUtil.getInstance().getAdapterSize(24);
    double spc = ScreenUtil.getInstance().getAdapterSize(24);
    double adapterW = ScreenUtil.getInstance().getAdapterSize(360);

    LogUtil.e("FlustarsChild1 statusBar: $statusBar, width: $width, height: $height, density: $density, sp: $sp, spc: $spc, adapterW: $adapterW");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 360.0,
          height: 50,
          color: Colors.grey,
          child: const Center(
            child: Text("未視配寬",
              style: TextStyle(fontSize: 24.0),
            ),
          ),
        ),
        Container(
          width: ScreenUtil.getInstance().getAdapterSize(360.0),
          height: 50,
          color: Colors.grey,
          child: const Center(
            child: Text("已適配寬",
              style: TextStyle(fontSize: 24.0),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(
              width: 180,
              height: 100,
              color: Colors.grey.shade300,
              child: const Center(
                child: Text("未視配Text",
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
            ),
            Container(
              width: ScreenUtil.getInstance().getAdapterSize(180.0),
              height: ScreenUtil.getInstance().getAdapterSize(100.0),
              color: Colors.grey.shade300,
              child: const Center(
                child: Text("已適配Text",
                  style: TextStyle(fontSize: 24.0),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}

class FlustarsChild2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FlustarsChild2State();
  }
}

class FlustarsChild2State extends State<FlustarsChild2> {
  @override
  void initState() {
    super.initState();
    _init();
//  _initWithCtx();
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

    LogUtil.e("FlustarsChild2 _init screenWidth: $screenWidth, screenHeight: $screenHeight, screenDensity: $screenDensity, statusBarHeight: $statusBarHeight, bottomBarHeight: $bottomBarHeight, appBarHeight: $appBarHeight, adapterW100: $adapterW100, adapterH100: $adapterH100, adapterSp100: $adapterSp100, adapterW100px: $adapterW100px, adapterH100px: $adapterH100px");
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

    LogUtil.e("FlustarsChild2 _initWithCtx screenWidth: $screenWidth, screenHeight: $screenHeight, screenDensity: $screenDensity, statusBarHeight: $statusBarHeight, bottomBarHeight: $bottomBarHeight, adapterW100: $adapterW100, adapterH100: $adapterH100, adapterSp100: $adapterSp100");
  }

  @override
  Widget build(BuildContext context) {
    double statusBar = ScreenUtil.getInstance().statusBarHeight;
    double width = ScreenUtil.getInstance().screenWidth;
    double height = ScreenUtil.getInstance().screenHeight;
    LogUtil.e("FlustarsChild2 statusBar: $statusBar, width: $width, height: $height");
    return Padding(
        padding: _functionUtil.initEdgeInsetsTop(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              color: Colors.grey,
              child: const Center(
                child: Text("你好你好你好",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 19.0),
                ),
              ),
            ),
            Container(
              width: ScreenUtil.getInstance().getAdapterSize(100.0),
              height: ScreenUtil.getInstance().getAdapterSize(100.0),
              color: Colors.grey,
              child: Center(
                child: Text("AbcAbcAbc",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: ScreenUtil.getInstance().getAdapterSize(19.0)),
                ),
              ),
            ),
            Container(
              width: ScreenUtil.getAdapterSizeCtx(context, 100.0),
              height: ScreenUtil.getAdapterSizeCtx(context, 100.0),
              color: Colors.grey,
              child: Center(
                child: Text("123123123",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: ScreenUtil.getAdapterSizeCtx(context, 19.0)),
                ),
              ),
            ),
          ],
        ),
    );
  }
}