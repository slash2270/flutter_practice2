import 'dart:collection';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:common_utils/common_utils.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_practice2/util/constants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:open_app_settings/open_app_settings.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:table_calendar/table_calendar.dart';

import '../widget/kumi_popup_window_widget.dart';

class FunctionUtil{

  ///這個 model 只管理一個變數。
  late Text text = const Text("");
  late Icon icon = const Icon(null);
  late IconButton iconButton = IconButton(onPressed: (){}, icon: Container());
  late BoxConstraints boxConstraints = const BoxConstraints( maxWidth: 0, maxHeight: 0, minWidth: 0, minHeight: 0);
  late EdgeInsets edgeInsets = const EdgeInsets.only(left: 0.0, top: 0.0, right: 0.0, bottom: 0.0);
  late SizedBox sizedBox;
  late Padding padding;
  late String platForm;
  late FluroRouter router = FluroRouter();
  //late double displayHeight = MediaQueryData().size.height, displayWidth = MediaQueryData().size.width;

  /// 簡而言之，使用 [BuildContext.settings.arguments] 或 [BuildContext.arguments] 提取參數
  var routeHandler = Handler(
    handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
      final listArguments = context?.settings?.arguments as List<String>;
      listArguments.addAll(Constants.listArguments);
    },
  );

  ///操作變數
  Widget initIcon(IconData? iconData) {
    return icon = Icon(iconData);
  }

  Widget initIcon1(IconData? iconData, double? size) {
    return icon = Icon(iconData, size: size);
  }

  Widget initIcon2(IconData? iconData, Color? color) {
    return icon = Icon(iconData, color: color);
  }

  Widget initIcon3(IconData? iconData, double? size, Color? color) {
    return icon = Icon(iconData, size: size, color: color);
  }

  Widget initIconButton(Function()? function, Widget iconData) {
    return iconButton = IconButton(onPressed: function, icon: iconData);
  }

  Widget initIconButton1(Function()? function, Widget iconData, double? size) {
    return iconButton = IconButton(onPressed: function, icon: iconData, iconSize: size);
  }

  Widget initIconButton2(Function()? function, Widget iconData, double? size, Color? color) {
    return iconButton = IconButton(onPressed: function, icon: iconData, iconSize: size, color: color);
  }

  Widget initText(String? textStr) {
    return text = Text(textStr ?? "");
  }

  Widget initText1(String? textStr, Color? color, Color? backGroundColor) {
    return text = Text(textStr ?? "", style: TextStyle(color: color, backgroundColor: backGroundColor));
  }

  Widget initText2(String? textStr, Color? textColor, Color? backGroundColor, double? fontSize) {
    return text = Text(textStr ?? "", textAlign: TextAlign.center, style: TextStyle(color: textColor, backgroundColor: backGroundColor, fontSize: fontSize));
  }

  Widget initText3(String? textStr, Color? textColor, Color? backGroundColor, double? fontSize, TextDecoration decoration) {
    return text = Text(textStr ?? "", style: TextStyle(color: textColor, backgroundColor: backGroundColor, fontSize: fontSize, decoration: decoration));
  }

  Widget initText4(String? textStr, Color? textColor, Color? backGroundColor, double? fontSize, FontWeight fontWeight) {
    return text = Text(textStr ?? "", style: TextStyle(color: textColor, backgroundColor: backGroundColor, fontSize: fontSize, fontWeight: fontWeight));
  }

  BoxConstraints initBoxConstraint(double? maxWidth, double? maxHeight, double? minWidth, double? minHeight){
    return boxConstraints = BoxConstraints(maxWidth: maxWidth ?? 0.0, maxHeight: maxHeight?? 0.0, minWidth: minWidth ?? 0.0, minHeight: minHeight ?? 0.0);
  }

  EdgeInsets initEdgeInsets(double? left, double? top, double? right, double? bottom){
    return edgeInsets = EdgeInsets.only(left: left ?? 0.0, top: top ?? 0.0, right: right ?? 0.0, bottom: bottom ?? 0.0);
  }

  EdgeInsets initEdgeInsetsTop(double? top){
    return edgeInsets = EdgeInsets.only(top: top ?? 0.0);
  }

  EdgeInsets initEdgeInsetsAll(double? all){
    return edgeInsets = EdgeInsets.all(all ?? 0.0);
  }

  SizedBox initSizedBox(double? height){
    return sizedBox = SizedBox(height: height);
  }

  Padding initPadding(double? left, double? top, double? right, double? bottom, Widget child){
    return padding = Padding(padding: initEdgeInsets(left, top, right, bottom), child: child,);
  }

  ElevatedButton initElevatedButton(BuildContext context, String buttonName, Widget targetClass){
    return ElevatedButton(
      child: initText2(buttonName, Colors.white, Colors.transparent, 20),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context) {
            return targetClass;
          }),
        );
      }
    );
  }

  CupertinoButton initCuperTinoButton(BuildContext context, String buttonName, Widget targetClass){
    return CupertinoButton(
        color: Colors.lightBlue,
        child: initText2(buttonName, Colors.white, Colors.transparent, 20),
        onPressed: () {
          Navigator.of(context).push(
            CupertinoPageRoute(builder: (BuildContext context) {
              return targetClass;
            }),
          );
        });
  }

  Widget textPainter(String string) {
    // 我们想提前知道 Text 组件的大小
    Text text = initText(string) as Text;
    // 使用 TextPainter 来测量
    TextPainter painter = TextPainter(textDirection: TextDirection.ltr);
    // 将 Text 组件文本和样式透传给TextPainter
    painter.text = TextSpan(text:text.data, style:text.style);
    // 开始布局测量，调用 layout 后就能获取文本大小了
    painter.layout();
    // 自定义组件 AfterLayout 可以在布局结束后获取子组件的大小，我们用它来验证一下
    // TextPainter 测量的宽高是否正确
    return initText2('$string \nPainter 尺寸 ${painter.size}', Colors.green, Colors.transparent, 18);
  }

  void goOriginal() { // 底層創建方式

    //1.创建绘制记录器和Canvas
    PictureRecorder recorder = PictureRecorder();
    Canvas canvas = Canvas(recorder);
    //2.在指定位置区域绘制。
    var rect = const Rect.fromLTWH(30, 200, 300,300 );
    drawChessboard(canvas,rect); //画棋盘
    drawPieces(canvas,rect);//画棋子
    //3.创建layer，将绘制的产物保存在layer中
    var pictureLayer = PictureLayer(rect);
    //recorder.endRecording()获取绘制产物。
    pictureLayer.picture = recorder.endRecording();
    var rootLayer = OffsetLayer();
    rootLayer.append(pictureLayer);
    //4.上屏，将绘制的内容显示在屏幕上。
    final SceneBuilder builder = SceneBuilder();
    final Scene scene = rootLayer.buildScene(builder);
    window.render(scene);

  }

  void drawChessboard(Canvas canvas, Rect rect) {

    //棋盘背景
    var paint = Paint()
      ..isAntiAlias = true
      ..style = PaintingStyle.fill //填充
      ..color = const Color(0xFFDCC48C);
    canvas.drawRect(rect, paint);
    //画棋盘网格
    paint
      ..style = PaintingStyle.stroke //线
      ..color = Colors.black38
      ..strokeWidth = 1.0;
    //画横线
    for (int i = 0; i <= 15; ++i) {
      double dy = rect.top + rect.height / 15 * i;
      canvas.drawLine(Offset(rect.left, dy), Offset(rect.right, dy), paint);
    }
    for (int i = 0; i <= 15; ++i) {
      double dx = rect.left + rect.width / 15 * i;
      canvas.drawLine(Offset(dx, rect.top), Offset(dx, rect.bottom), paint);
    }

  }

  //画棋子
  void drawPieces(Canvas canvas, Rect rect) {

    double eWidth = rect.width / 15;
    double eHeight = rect.height / 15;
    //画一个黑子
    var paint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.black;
    //画一个黑子
    canvas.drawCircle(
      Offset(rect.center.dx - eWidth / 2, rect.center.dy - eHeight / 2),
      min(eWidth / 2, eHeight / 2) - 2,
      paint,
    );
    //画一个白子
    paint.color = Colors.white;
    canvas.drawCircle(
      Offset(rect.center.dx + eWidth / 2, rect.center.dy - eHeight / 2),
      min(eWidth / 2, eHeight / 2) - 2,
      paint,
    );

  }

  //顯示 SnackBar 訊息與自定義按鈕
  void snackBar(BuildContext context, String message, String label) {
    final snackBar = SnackBar(
      onVisible: () {
        if (kDebugMode) {
          //print("顯示");
        }
      },
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(50))),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.black,
      content: initText(message),
      action: SnackBarAction(
        label: label,
        onPressed: () {},
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  String getPlatForm(){

    platForm = 'Platform ';

    if(Platform.isFuchsia){
      platForm += "Fuchsia";
    }else if(Platform.isWindows){
      platForm += "Windows";
    }else if(Platform.isLinux){
      platForm += "Linux";
    }else if(Platform.isMacOS){
      platForm += "MacOS";
    }else if(Platform.isIOS){
      platForm += "IOS";
    }else if(Platform.isAndroid){
      platForm += "Android";
    }

    return platForm;
  }

  Widget fortyThreePopScope(BuildContext context){
    return WillPopScope(
      onWillPop: () async {
        await Navigator.pushReplacementNamed(context, '/FortyThree');
        return true;
      },
      child: Container(),
    );
  }

  void setLoadingDialog(BuildContext context, bool isDismiss) async{
    AlertDialog dialog = AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          CircularProgressIndicator(),
          Padding(
            padding: EdgeInsets.only(top: 26.0),
            child: Text("正在加載，請稍候..."),
          )
        ],
      ),
    );
    await showDialog(
      context: context,
      barrierDismissible: isDismiss, //点击遮罩不关闭对话框
      builder: (context) {
        return UnconstrainedBox(
          constrainedAxis: Axis.vertical,
          child: SizedBox(
              width: 280,
              child: dialog
          ),
        );
      },
    );
  }

  void showToast(String msg) async {
    await Fluttertoast.showToast(
        msg: msg,
        fontSize: 16,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        gravity: ToastGravity.CENTER,
        toastLength: Toast.LENGTH_SHORT);
  }

  Future<bool> photosPermission() async {
    if (Platform.isIOS) {
      var status = await Permission.photos.status;
      if (status.isDenied) {
        await [
          Permission.photos,
        ].request();
      }
      return status.isGranted;
    } else {
      var status = await Permission.storage.status;
      if (status.isDenied) {
        await [
          Permission.storage,
        ].request();
      }
      return status.isGranted;
    }
  }

  checkPhotoPermission(Future<dynamic> fun) {
    photosPermission().then((value) => {
      if (value)
        {
          // 执行操作
          fun
        }
      else
        {
          // 去授权 存储权限
          OpenAppSettings.openAppSettings()
        }
    });
  }

  routerDefine(String routeName, TransitionType type) {
    // 也可以定义要使用的路由转换
    router.define(routeName, handler: routeHandler, transitionType: type);
  }

  routerNavigate(BuildContext context, String routeName, TransitionType type) {
    router.navigateTo(context, routeName, transition: type);
  }

  /// 如果您不想使用路徑參數，則使用自定義 RouteSettings 推送路由
  routeCustom(BuildContext context, String routeName, Object? value) {
    FluroRouter.appRouter.navigateTo(
      context,
      routeName,
      routeSettings: RouteSettings(
        arguments: value,
      ),
    );
  }

  setPositioned(Widget widget){
    return (BuildContext context, Animation<RelativeRect> animation, Animation secondaryAnimation) {
      return PositionedTransition(
        rect: animation,
        child: widget,
      );
    };
  }

  setRelativePositioned(Widget widget){
    const size = Size(360, 640);
    return (BuildContext context, Animation<Rect?> animation, Animation secondaryAnimation) {
      return RelativePositionedTransition(
        rect: animation,
        size: size,
        child: widget,
      );
    };
  }

  setDecoratedBox(Widget widget){
    return (BuildContext context, Animation<Decoration> animation, Animation secondaryAnimation) {
      return DecoratedBoxTransition(
        decoration: animation,
        child: widget,
      );
    };
  }

  setAlign(Widget widget){
    return (BuildContext context, Animation<AlignmentGeometry> animation, Animation secondaryAnimation) {
      return AlignTransition(
        alignment: animation,
        child: widget,
      );
    };
  }

  setDefaultTextStyle(Widget widget){
    return (BuildContext context, Animation<TextStyle> animation, Animation secondaryAnimation) {
      return DefaultTextStyleTransition(
        style: animation,
        child: widget,
      );
    };
  }

  setSlide(Widget widget){
    return (BuildContext context, Animation<Offset> animation, Animation secondaryAnimation) {
      return SlideTransition(
        position: animation,
        child: widget,
      );
    };
  }

  setSliverFade(Widget widget){
    return (BuildContext context, Animation<double> animation, Animation secondaryAnimation) {
      return SliverFadeTransition(
        opacity: animation,
        sliver: widget,
      );
    };
  }

  setRotate(Widget widget){
    return (BuildContext context, Animation<double> animation, Animation secondaryAnimation) {
      return RotationTransition(
        turns: animation,
        child: widget,
      );
    };
  }

  setSize(Widget widget){
    return (BuildContext context, Animation<double> animation, Animation secondaryAnimation) {
      return SizeTransition(
        sizeFactor: animation,
        child: widget,
      );
    };
  }

  setScale(Widget widget){
    return (BuildContext context, Animation<double> animation, Animation secondaryAnimation) {
      return ScaleTransition(
        scale: animation,
        child: widget,
      );
    };
  }

  setFade(Widget widget){
    return (BuildContext context, Animation<double> animation, Animation secondaryAnimation) {
      return FadeTransition(
        opacity: animation,
        child: widget,
      );
    };
  }

  checkPermission(Permission permission) async {
    PermissionStatus status = await permission.status; // 获取当前权限的状态
    // 判断当前状态处于什么类型
    if( status.isDenied ){
      permission.request();
      // 第一次申请被拒绝 再次重试
    } else if( status.isPermanentlyDenied ){ // 永久拒絕
      await Geolocator.openAppSettings();
      // 第二次申请被拒绝 去设置中心
    } else if( status.isLimited ){ // 有限
      await Geolocator.openAppSettings();
    } else if( status.isRestricted ){ // 受限制
      await Geolocator.openAppSettings();
    }
  }

  void navigateTo(BuildContext context, WidgetBuilder builder) {
    Navigator.of(context).push(MaterialPageRoute(builder: builder));
  }

}

class EventTitle {
  final String title;

  const EventTitle(this.title);

  @override
  String toString() => title;
}

/// 示例事件。
///
/// 如果您決定使用地圖，強烈建議使用 [LinkedHashMap]。
final kEvents = LinkedHashMap<DateTime, List<EventTitle>>(
  equals: isSameDay,
  hashCode: getHashCode,
)..addAll(_kEventSource);

final _kEventSource = { for (var item in List.generate(50, (index) => index)) DateTime.utc(kFirstDay.year, kFirstDay.month, item * 5) :
List.generate(
    item % 4 + 1, (index) => EventTitle('Title $item | ${index + 1}')) }
  ..addAll({
    kToday: [
      const EventTitle('Today\'s Title 1'),
      const EventTitle('Today\'s Title 2'),
    ],
  });

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}

/// 返回從 [first] 到 [last] 的 [DateTime] 對象列表，包括在內。
List<DateTime> daysInRange(DateTime first, DateTime last) {
  final dayCount = last.difference(first).inDays + 1;
  return List.generate(
    dayCount,
        (index) => DateTime.utc(first.year, first.month, first.day + index),
  );
}

final kToday = DateTime.now();
final kFirstDay = DateTime(kToday.year, kToday.month - 3, kToday.day);
final kLastDay = DateTime(kToday.year, kToday.month + 3, kToday.day);


Future<List<int>?> compressAndTryCatch(String path) async {
  List<int>? result;
  try {
    result = await FlutterImageCompress.compressWithFile(
      path,
      format: CompressFormat.heic,
    );
  } on UnsupportedError catch (e) {
    LogUtil.e(e.message);
    result = await FlutterImageCompress.compressWithFile(
      path,
      format: CompressFormat.jpeg,
    );
  } on Error catch (e) {
    LogUtil.e(e.toString());
    LogUtil.e(e.stackTrace);
  } on Exception catch (e) {
    LogUtil.e(e.toString());
  }
  return result;
}

