import 'package:location/location.dart';

class LocationService {
  Future<LocationData?> getCurrentLocation() async {
    Location location = Location();

    if (!await location.serviceEnabled()) {
      await location.requestService();
    }

    if (await location.hasPermission() == PermissionStatus.denied) {
      await location.requestPermission();
    }

    return await location.getLocation();
  }
}
