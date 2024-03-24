import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<String?> getLocationName() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      if (placemarks.isNotEmpty) {
        return placemarks[0].name ?? 'Unknown Location';
      } else {
        return 'Unknown Location';
      }
    } catch (e) {
      print('Error getting location: $e');
      return null;
    }
  }
}
