import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_practice2/util/constants.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';

import '../util/event_bus_util.dart';
import '../util/function_util.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget({Key? key, required this.googleMapController}) : super(key: key);

  final GoogleMapController googleMapController;

  @override
  State<StatefulWidget> createState() {
    return SearchBarWidgetState();
  }
}

class SearchBarWidgetState extends State<SearchBarWidget> with TickerProviderStateMixin {

  late FunctionUtil _functionUtil;
  bool _isClick = false;
  //late TextEditingController _textEditingController;
  //late String _inputText = '';

  @override
  void initState() {
    super.initState();
    _functionUtil = FunctionUtil();
    /*_textEditingController = TextEditingController();
    _textEditingController.addListener(() {
      _inputText = _textEditingController.text;
    });
    _setAnimationController();
    _initAnimation();
    _startAnimation();*/
  }

  @override
  void dispose() {
    // 銷毀
    //_textEditingController.dispose();
    super.dispose();
  }

  /*_setAnimationController(){
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 3000));
  }

  _initAnimation(){
    _movement = EdgeInsetsTween(
      begin: _functionUtil.initEdgeInsets(0.0, 50.0, 0.0, 0.0),
      end: _functionUtil.initEdgeInsets(0.0, 100.0, 0.0, 0.0),
    ).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: const Interval(0.1, 0.5, curve: Curves.fastOutSlowIn))
    )
      ..addListener(() {
        setState(() { });
      });
  }

  Future _startAnimation() async{
    try{
      await _animationController.repeat();
    }on TickerCanceled{
      print('Main Animation Failed');
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
            height: 40,
            width: _isClick ? 270 : 260,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10.0))
            ),
            child: GestureDetector(
              onTap: _handlePressButton,
              child: Row(
                children: [
                  /*Visibility(
                  visible: _textEditingController.text.isNotEmpty,
                  child: GestureDetector(
                    child: const Icon(
                      Icons.cancel,
                      color: Colors.grey,
                    ),
                    onTap: () {
                      setState(() {
                        _textEditingController.clear();
                        _onChanged('');
                      });
                    },
                  ),
                ),*/
                  Expanded(
                    child: _functionUtil.initText2('請輸入地址：...', Colors.grey, Colors.transparent, 18.0),
                    /*TextField(
                    controller: _textEditingController,
                    cursorColor: Colors.lightBlueAccent,
                    autofocus: true,
                    style: const TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w300,
                    ),
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 5, bottom: 10),
                      border: InputBorder.none,
                      hoverColor: Colors.black,
                      hintText: '搜索',
                      hintTextDirection: TextDirection.ltr,
                      hintStyle: TextStyle(color: Colors.grey),
                    ),
                    onChanged: _onChanged,
                  ),*/
                  ),
                  const Icon(Icons.search, color: Colors.grey,),
                ],
              ),
            ),
        ),
        /*GestureDetector(
          onTap: (){
            setState(() {
              _textEditingController.clear();
              _inputText = '';
            });
          },
          child: _functionUtil.initText2(_inputText, Colors.black, Colors.transparent, 16),
        )*/
      ],
    );
  }

  /*void _onChanged(String text) async{
    setState(() {
      if(text.isNotEmpty || _textEditingController.text.isNotEmpty){
        _inputText = '取消';
      }else{
        _textEditingController.clear();
        _inputText = '';
      }
    });
  }*/

  Future<void> _handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction? prediction = await PlacesAutocomplete.show(
      context: context, // required
      apiKey: Constants.aApiKey, // required
      onError: onError,
      mode: Mode.overlay, // required
      region: 'CH', // ccTLD（“頂級域”）兩字符值
      language: "zh_TW",
      offset: 0, // required
      types: [], //required
      startText: '',
      strictbounds: false,
      decoration: InputDecoration(
        hintText: '搜尋',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      components: [Component(Component.country, "tw")],
    );

    displayPrediction(prediction, context);
  }

  Future<void> displayPrediction(Prediction? prediction, BuildContext context) async {

    if (prediction != null) {
      // get detail (lat/lng)
      GoogleMapsPlaces _places = GoogleMapsPlaces(
        apiKey: Constants.aApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );
      final placeId = prediction.placeId ?? "0";
      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(placeId);
      final address = await Geocoder.local.findAddressesFromQuery(prediction.description);
      final lat = detail.result.geometry!.location.lat;
      final lng = detail.result.geometry!.location.lng;

      widget.googleMapController.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, lng), zoom: 17)));

      //LogUtil.e('SearchBar lat:$lat lng:$lng address:${address.length}');

      EventBusUtils.getInstance().fire(EventBusBroadCast(lat, lng, address));

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("${prediction.description} - $lat/$lng")),
      );
    }
  }

  void onError(PlacesAutocompleteResponse response) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(response.errorMessage!)),
    );
  }

}