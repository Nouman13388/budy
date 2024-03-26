import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<Map<String, double>?> getLocation() async {
    try {
      final Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      return {
        'latitude': position.latitude,
        'longitude': position.longitude,
      };
    } catch (e) {
      if (kDebugMode) {
        print('Error getting location data: $e');
      }
      return null;
    }
  }
}
