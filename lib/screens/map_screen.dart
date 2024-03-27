import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps_flutter;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

const String kGoogleApiKey = "AIzaSyB0v6p7f6FeafE4jauFyw9GKsSnq1AW_xk";

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<google_maps_flutter.GoogleMapController> _mapController = Completer<google_maps_flutter.GoogleMapController>();

  Location _locationController = Location();
  google_maps_flutter.LatLng? _currentLocation;
  final TextEditingController _searchController = TextEditingController();
  Set<google_maps_flutter.Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _getLocationUpdates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map Screen'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Pop the screen when the button is pressed
          },
        ),
        ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (google_maps_flutter.GoogleMapController controller) {
              _mapController.complete(controller);
            },
            initialCameraPosition: google_maps_flutter.CameraPosition(
              target: _currentLocation ?? google_maps_flutter.LatLng(0, 0),
              zoom: 14,
            ),
            markers: _markers,
          ),
          Positioned(
            top: 16.0,
            left: 16.0,
            right: 16.0,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
              child: TextFormField(
                controller: _searchController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  hintText: "Search for a place",
                  hintStyle: const TextStyle(color: Colors.black),
                  prefixIcon: const Icon(Icons.search, color: Colors.black),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                onFieldSubmitted: (value) async {
                  await _searchPlace(value);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _cameraToLocation(google_maps_flutter.LatLng pos) async {
    final google_maps_flutter.GoogleMapController controller = await _mapController.future;
    final google_maps_flutter.CameraPosition _newPosition = google_maps_flutter.CameraPosition(target: pos, zoom: 14);
    await controller.animateCamera(google_maps_flutter.CameraUpdate.newCameraPosition(_newPosition));
  }

Future<void> _getLocationUpdates() async {
  bool _serviceEnabled;
  LocationPermission _permissionGranted;

  _serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await Geolocator.openLocationSettings();
    if (!_serviceEnabled) {
      return;
    }
  }

  _permissionGranted = await Geolocator.checkPermission();
  if (_permissionGranted == LocationPermission.denied) {
    _permissionGranted = await Geolocator.requestPermission();
    if (_permissionGranted != LocationPermission.whileInUse && _permissionGranted != LocationPermission.always) {
      return;
    }
  }

  Position position = await Geolocator.getCurrentPosition();
  setState(() {
    _currentLocation = google_maps_flutter.LatLng(position.latitude, position.longitude);
  });
  _updateMarkers();
  _cameraToLocation(_currentLocation!);

  Geolocator.getPositionStream().listen((Position newPosition) {
    setState(() {
      _currentLocation = google_maps_flutter.LatLng(newPosition.latitude, newPosition.longitude);
    });
    _updateMarkers();
  });
}

  Future<void> _searchPlace(String placeName) async {
    String url = "https://maps.googleapis.com/maps/api/place/textsearch/json?query=$placeName&key=$kGoogleApiKey";
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data["status"] == "OK") {
        final results = data["results"];
        if (results.isNotEmpty) {
          setState(() {
            _currentLocation = google_maps_flutter.LatLng(
              results[0]["geometry"]["location"]["lat"],
              results[0]["geometry"]["location"]["lng"],
            );
            _updateMarkers(); // Update markers when a new place is searched
            _cameraToLocation(_currentLocation!);
          });
        }
      }
    }
  }

  void _updateMarkers() {
    _markers.clear(); // Clear existing markers
    if (_currentLocation != null) {
      _markers.add(
        google_maps_flutter.Marker(
          markerId: google_maps_flutter.MarkerId("searched_location"),
          position: _currentLocation!,
          infoWindow: google_maps_flutter.InfoWindow(
            title: "Searched Location",
          ),
        ),
      );
    }
  }
}
