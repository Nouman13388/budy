import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<Map<String, double>?> getLocation() async {
    try {
      // Request permission to access the device's location
      final bool permissionGranted = await _requestPermission();

      if (permissionGranted) {
        // If permission is granted, retrieve the current position
        final Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );

        return {
          'latitude': position.latitude,
          'longitude': position.longitude,
        };
      } else {
        // Permission denied, handle accordingly
        if (kDebugMode) {
          print('User denied permissions to access the device\'s location.');
        }
        return null;
      }
    } catch (e) {
      // Handle other errors
      if (kDebugMode) {
        print('Error getting location data: $e');
      }
      return null;
    }
  }

  static Future<bool> _requestPermission() async {
    final LocationPermission permission = await Geolocator.requestPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }
}
