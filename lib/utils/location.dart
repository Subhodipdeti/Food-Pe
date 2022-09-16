import 'package:location/location.dart';

class DeviceLocation {
  Location location = Location();

  Future<LocationData> askLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return throw ("Service not enable.");
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return throw ("Permission Denied.");
      }
    }
    locationData = await location.getLocation();
    return locationData;
  }
}
