import 'package:flutter/material.dart';
import 'package:flutter_practice2/bean/location_bean.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../widget/parallax_widget.dart';

class MapChangeNotifier extends ChangeNotifier{

  late Map<String, Marker> _markers = {};
  late LocationsBean googleOffice;
  double _lat = 0.0, _lng = 0.0;

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
      _markers[office.name] = marker;
    }
  }

}