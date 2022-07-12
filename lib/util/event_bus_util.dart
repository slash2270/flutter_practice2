import 'package:event_bus/event_bus.dart';
import 'package:geocoder/geocoder.dart';

class EventBusUtils {
  static EventBus? _instance;

  static EventBus getInstance() {
    _instance ??= EventBus();
    return _instance!;
  }
}

class EventBusBroadCast {
  double lat, lng;
  List<Address> address;
  EventBusBroadCast(this.lat, this.lng, this.address);

}