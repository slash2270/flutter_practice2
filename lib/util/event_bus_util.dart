import 'package:event_bus/event_bus.dart';
import 'package:geocoder/geocoder.dart';

class EventBusUtils {
  static EventBus? _instance;

  static EventBus getInstance() {
    _instance ??= EventBus();
    return _instance!;
  }
}

class EventBusMap {

  double lat, lng;
  List<Address> address;
  EventBusMap({required this.lat, required this.lng, required this.address});

}