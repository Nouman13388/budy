import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key}) : super(key: key);

  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  GoogleMapController? _controller;
  LocationData? _currentLocation;
  bool _isLoading = true;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      final location = Location();
      final hasPermission = await location.hasPermission();
      if (hasPermission == PermissionStatus.granted) {
        _currentLocation = await location.getLocation();
        _updateMarkers();
      } else {
        print('Location permission not granted.');
      }
    } catch (e) {
      print('Error getting current location: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _updateMarkers() {
    if (_currentLocation != null && _controller != null) {
      setState(() {
        _markers.clear();
        _markers.add(
          Marker(
            markerId: const MarkerId('user_location'),
            position: LatLng(
              _currentLocation!.latitude!,
              _currentLocation!.longitude!,
            ),
            infoWindow: const InfoWindow(title: 'Your Location'),
          ),
        );
        _controller!.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                _currentLocation!.latitude!,
                _currentLocation!.longitude!,
              ),
              zoom: 15,
            ),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Map'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(0, 0),
                zoom: 15,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller = controller;
                _updateMarkers(); // Call _updateMarkers when map is created
              },
              markers: _markers,
              myLocationEnabled: true, // Show user's location on the map

              myLocationButtonEnabled:
                  true, // Show button to center map on user's location
            ),
    );
  }
}
