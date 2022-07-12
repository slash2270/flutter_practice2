import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_practice2/util/function_util.dart';
import 'package:geocoder/model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_practice2/bean/location_bean.dart' as locations;

class MapWidget extends StatefulWidget {
  const MapWidget({Key? key, required this.eventLat, required this.eventLng, required this.eventAddress}) : super(key: key);

  final double eventLat, eventLng;
  final List<Address> eventAddress;

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late Map<String, Marker> _markers;
  late FunctionUtil _functionUtil;
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  var _position;
  double _lat = 0.0, _lng = 0.0;

  @override
  void initState() {
    super.initState();
    _markers = {};
    _functionUtil = FunctionUtil();
    _getLocation();
  }

  Future<void> _onMapCreated(GoogleMapController controller) async {
    setState(() {
      mapController = controller;
    });
    final googleOffices = await locations.getGoogleOffices();
    setState(() {
      _markers.clear();
      LogUtil.e('MapWidget lat: ${widget.eventLat} lng: ${widget.eventLng}');
      if(widget.eventLat > 0.0){
        for (var address in widget.eventAddress) {
          googleOffices.offices.add(locations.Office(address: address.addressLine, id: '', image: '', lat: widget.eventLat, lng: widget.eventLng, name: '查詢位置', phone: '', region: ''));
        }
      }
      for (final office in googleOffices.offices) {
        final marker = Marker(
          markerId: MarkerId(office.name),
          position: LatLng(office.lat, office.lng),
          infoWindow: InfoWindow(
            title: office.name,
            snippet: office.address,
          ),
        );
        _markers[office.name] = marker;
      }
    });
  }

  _getLocation() async{
    _position = await _getPosition();
    setState(() {
      _lat = _position.latitude;
      _lng = _position.longitude;
    });
  }

  Future<Position> _getPosition() async {
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
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
          onMapCreated: _onMapCreated,
          initialCameraPosition: CameraPosition(
            target: widget.eventLat > 0.0 && widget.eventLng > 0.0 ? LatLng(widget.eventLat, widget.eventLng) :  LatLng(_lat, _lng),
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
          //liteModeEnabled: true, // 輕量化
    );
  }
}