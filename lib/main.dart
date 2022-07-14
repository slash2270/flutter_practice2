import 'dart:io';

import 'package:ff_annotation_route_library/ff_annotation_route_library.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_practice2/bean/city_bean.dart';
import 'package:flutter_practice2/widget/route_widget.dart';
import 'package:flutter_practice2/util/constants.dart';
import 'package:flutter_practice2/view/main_page.dart';
import 'package:flutter_practice2/view/second_page.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:oktoast/oktoast.dart';

import 'extended_text/ffroute_setting.dart';

main() async{
   WidgetsFlutterBinding.ensureInitialized();
   await FlutterDownloader.initialize(debug: true, ignoreSsl: true);
   initializeDateFormatting().then((_) => runApp(const MyApp()));
   if (Platform.isAndroid) {
     SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
   }
   debugPrintGestureArenaDiagnostics = false;
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    _initAsync();
    /// 配置设计稿尺寸
    /// 如果设计稿尺寸默认配置一致，无需该设置。默认 width:360.0 / height:640.0 / density:3.0
    /// Configuration design draft size.
    /// If the default configuration of design draft size is the same, this setting is not required. default width:360.0 / height:640.0 / density:3.0
    setDesignWHD(360.0, 640.0, density: 3);
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

    CityBean? hisCity = SpUtil.getObj("loc_city", (v) => CityBean.fromJson(v as Map<String, dynamic>));
    LogUtil.e("City: ${hisCity == null ? "null" : hisCity.toString()}");

    /// save object list example.
    /// 存储实体对象list示例。
    List<CityBean> list = [];
    list.add(CityBean(name: "成都市"));
    list.add(CityBean(name: "北京市"));
    SpUtil.putObjectList("loc_city_list", list);

    List<CityBean>? dataList = SpUtil.getObjList("loc_city_list", (v) => CityBean.fromJson(v as Map<String, dynamic>));
    LogUtil.e("CityList: ${dataList == null ? "null" : dataList.toString()}");
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: ValueNotifier(ThemeMode.light),
        builder: (context, value, child) => OKToast(
            child: MaterialApp(
              title: 'Flutter Demo',
              home: const MainPage(),
              theme: ThemeData(
                primarySwatch: Colors.blue,
                primaryColor: Colors.blue,
                primaryColorDark: Colors.blue,
                brightness: Brightness.light,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              darkTheme: ThemeData(
                primarySwatch: Colors.blue,
                primaryColor: Colors.lightBlue[900],
                primaryColorDark: Colors.lightBlue[900],
                brightness: Brightness.dark,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              builder: (BuildContext c, Widget? w) {
                // ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true)..init(c);
                if (!kIsWeb) {
                  final MediaQueryData data = MediaQuery.of(c);
                  return MediaQuery(
                    data: data.copyWith(textScaleFactor: 1.0),
                    child: w!,
                  );
                }
                return w!;
              },
              themeMode: value,
              routes: {
                '/First': (context) => const MainPage(),
                '/Second': (context) => const SecondPage(),
              },
              //initialRoute: FFRoutes.fluttercandiesMainpage,
              onGenerateRoute: (RouteSettings settings) {
                late Widget page;
                if (settings.name == Constants.routeHome) {
                  page = const HomeScreen();
                  return MaterialPageRoute<dynamic>(
                    builder: (context) {
                      return page;
                    },
                    settings: settings,
                  );
                } else if (settings.name == Constants.routeSettings) {
                  page = const SettingsScreen();
                  return MaterialPageRoute<dynamic>(
                    builder: (context) {
                      return page;
                    },
                    settings: settings,
                  );
                } else if (settings.name!.startsWith(Constants.routePrefixDeviceSetup)) {
                  final subRoute = settings.name!.substring(Constants.routePrefixDeviceSetup.length);
                  page = SetupFlow(
                    setupPageRoute: subRoute,
                  );
                  return MaterialPageRoute<dynamic>(
                    builder: (context) {
                      return page;
                    },
                    settings: settings,
                  );
                } else {
                  return onGenerateRoute(
                    settings: settings,
                    getRouteSettings: getRouteSettings,
                  );
                  //throw Exception('Unknown route: ${settings.name}');
                }
              },
              debugShowCheckedModeBanner: false,
              ),
            )
    );
  }

}

List<String>? _imageTestUrls;
List<String> get imageTestUrls => _imageTestUrls ?? <String>['https://photo.tuchong.com/4870004/f/298584322.jpg'];