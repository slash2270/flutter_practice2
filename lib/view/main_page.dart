import 'dart:async';

import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/drawer/left_drawer.dart';
import 'package:flutter_practice2/map/search_bar_widget.dart';
import 'package:flutter_practice2/util/function_util.dart';
import 'package:animations/animations.dart';
import 'package:geocoder/model.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_practice2/bean/location_bean.dart' as locations;
import 'package:permission_handler/permission_handler.dart';

import '../util/event_bus_util.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return MainPageState();
  }
}

class MainPageState extends State<MainPage> with TickerProviderStateMixin {

  late FunctionUtil _functionUtil;
  late StreamSubscription _eventBusSubscript;
  late Map<String, Marker> _markers;
  late GoogleMapController _mapController;
  late List<Address> _address;
  late Position _position;
  late locations.LocationsBean googleOffice;
  final SharedAxisTransitionType? _transitionType = SharedAxisTransitionType.horizontal;
  bool _isSearch = false, _isClick = false;
  double _lat = 0.0, _lng = 0.0;

  @override
  void initState() {
    _functionUtil = FunctionUtil();
    _markers = {};
    _address = [];
    _checkPermission();
    _getEventBus();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // 依賴變化
    LogUtil.e('Main didChangeDependencies');
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant MainPage oldWidget) {
    // 元件發生變化
    LogUtil.e('Main didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void deactivate() {
    // 切換頁面, 先暫時移除後添加
    LogUtil.e('Main deactivate');
    super.deactivate();
  }

  @override
  void setState(VoidCallback fn) {
    // 更新畫面
    LogUtil.e('Main setState');
    super.setState(fn);
  }

  @override
  void dispose() {
    // 銷毀
    LogUtil.e('Main dispose');
    _eventBusSubscript.cancel();
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
          child: Scaffold(
            body: Stack(
              children: [
                Flex(
                  direction: Axis.vertical,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        color: Colors.blue,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _functionUtil.initPadding(0.0, 25.0, 0.0, 0.0,
                              Builder(builder: (BuildContext ctx) {
                                return IconButton(
                                    color: Colors.white,
                                    icon: const Icon(Icons.density_medium),
                                    onPressed: () {
                                      setState(() { });
                                      Scaffold.of(ctx).openDrawer();
                                    });
                              }),
                            ),
                            _functionUtil.initPadding(0.0, 25.0, 0.0, 0.0,
                              PageTransitionSwitcher(
                                duration: const Duration(milliseconds: 1000),
                                reverse: !_isSearch,
                                transitionBuilder: (
                                    Widget child,
                                    Animation<double> animation,
                                    Animation<double> secondaryAnimation,
                                    ) {
                                  return SharedAxisTransition(
                                    animation: animation,
                                    secondaryAnimation: secondaryAnimation,
                                    transitionType: _transitionType!,
                                    child: child,
                                  );
                                },
                                child: _isSearch ? SearchBarWidget(googleMapController: _mapController,) : _functionUtil.initText2('Flutter Demo', Colors.white, Colors.blue, 24),
                              ),
                            ),
                            _functionUtil.initPadding(0.0, 25.0, 0.0, 0.0,
                              Visibility(
                                visible: !_isClick,
                                  child: Builder(builder: (BuildContext ctx) {
                                    return IconButton(
                                      icon: _isSearch ? const Icon(Icons.title) : const Icon(Icons.search),
                                      color: Colors.white,
                                      onPressed: () {
                                        setState(() {
                                          _isSearch = !_isSearch;
                                        });
                                        //_functionUtil.routerDefine('/Second', TransitionType.inFromLeft);
                                        //_functionUtil.routerNavigate(context, '/Second', TransitionType.inFromTop);
                                      },
                                    );
                                  }
                              )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 9,
                        child: PageTransitionSwitcher(
                          duration: const Duration(milliseconds: 1000),
                          reverse: !_isClick,
                          transitionBuilder: (
                              Widget child,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation,
                              ) {
                            return SharedAxisTransition(
                              animation: animation,
                              secondaryAnimation: secondaryAnimation,
                              transitionType: _transitionType!,
                              child: child,
                            );
                          },
                          child: GoogleMap(
                            onMapCreated: _onMapCreated,
                            initialCameraPosition: CameraPosition(
                              target: LatLng(_lat, _lng),
                              zoom: 2.0,
                            ),
                            markers: _markers.values.toSet(),
                            myLocationEnabled: true, // 我的位置
                            myLocationButtonEnabled: true, // 我的位置按鈕
                            indoorViewEnabled: true, // 室內視圖
                            trafficEnabled: false, // 交通層
                            buildingsEnabled: true, // 3D建築
                            tiltGesturesEnabled: true, // 傾斜手勢
                            compassEnabled: true, // 指南針
                            mapToolbarEnabled: true, // 工具欄
                            zoomGesturesEnabled: true, // 倍率縮放手勢
                            //liteModeEnabled: true, // 輕量化
                          ),//_isClick ? _ListView() : const MapWidget(),*/
                        ),
                    )
                  ],
                ),
                WillPopScope(
                    onWillPop: () async{
                      return true;
                    },
                    child: Container()
                )
              ],
            ),
            resizeToAvoidBottomInset: false,
            drawer: const LeftDrawer(),
          )
    );
  }

  _checkPermission() async {
    Permission permission = Permission.location; // 添加要访问的权限是什么
    PermissionStatus status = await permission.status; // 获取当前权限的状态
    // 判断当前状态处于什么类型
    if( status.isDenied ){
      permission.request();
      // 第一次申请被拒绝 再次重试
    } else if( status.isPermanentlyDenied ){ // 永久拒絕
      await Geolocator.openAppSettings();
      await Geolocator.openLocationSettings();
      // 第二次申请被拒绝 去设置中心
    } else if( status.isLimited ){ // 有限
      await Geolocator.openAppSettings();
      await Geolocator.openLocationSettings();
    } else if( status.isRestricted ){ // 受限制
      await Geolocator.openAppSettings();
      await Geolocator.openLocationSettings();
    } else if(status.isGranted || await permission.request().isGranted){
      _statusGranted();
    }
  }

  _statusGranted() async{
    //LocationAccuracyStatus accuracy = await Geolocator.getLocationAccuracy(); 精確位置
    _position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    //Position? position = await Geolocator.getLastKnownPosition(); 最後位置
    setState(() {
      _lat = _position.latitude;
      _lng = _position.longitude;
    });
    //LogUtil.e('MainPage getLocation lat:$_lat lng:$_lng');
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    googleOffice = await locations.getGoogleOffices();
    setState(() {
      _mapController = controller;
      _markers.clear();
    });
    _setMarkers();
  }

  _setMarkers(){
    for (final office in googleOffice.offices) {
      final marker = Marker(
        markerId: MarkerId(office.name),
        position: LatLng(office.lat, office.lng),
        infoWindow: InfoWindow(
          title: office.name,
          snippet: office.address,
        ),
      );
      setState(() {
        _markers[office.name] = marker;
      });
    }
  }

  void _getEventBus(){
    _eventBusSubscript = EventBusUtils.getInstance().on<EventBusMap>().listen((event) {
      setState(() {
        _lat = event.lat;
        _lng = event.lng;
      });
      _address.addAll(event.address);
      //LogUtil.e('MainPage getEventBus lat:$_lat lng:$_lng address:${_address.length}');
      if (_address.isNotEmpty) {
        for (var address in _address) {
          //LogUtil.e('MainPage MapCreate lat: $_lat lng: $_lng address${address.addressLine}/${address.countryName}');
          googleOffice.offices.add(locations.Office(
              address: address.addressLine,
              id: '',
              image: 'https://lh3.googleusercontent.com/gG1zKXcSmRyYWHwUn2Z0MITpdqwb52RAEp3uthG2J5Xl-4_Wz7_WmoM6T_TBg6Ut3L1eF-8XENO10sxVIFdQHilj8iRG29wROpSoug',
              lat: _lat,
              lng: _lng,
              name: '查詢位置',
              phone: '',
              region: ''));
        }
      }
      _setMarkers();
    });
  }

  /*_getPosition() async {

    bool serviceEnabled;
    LocationPermission permission;

    // 測試是否啟用了位置服務。
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // 位置服務未啟用不要繼續
      // 訪問位置並請求用戶
      // 應用程序啟用位置服務。
      return Future.error('位置服務被禁用。');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // 權限被拒絕，下次可以試試
        // 再次請求權限（這也是
        // Android 的 shouldShowRequestPermissionRationale
        // 返回真。 根據安卓指南
        // 你的應用現在應該顯示一個解釋性的 UI。
        return Future.error('位置權限被拒絕');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // 權限永遠被拒絕，適當處理。
      return Future.error('位置權限被永久拒絕，我們無法請求權限。');
    }

    // 當我們到達這裡時，權限被授予，我們可以
    // 繼續訪問設備的位置。
    return await Geolocator.getCurrentPosition();
  }*/

}