import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as google_maps_flutter; // Import Google Maps package with an alias
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';

const String kGoogleApiKey = "YOUR_GOOGLE_PLACES_API_KEY";

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<google_maps_flutter.GoogleMapController> _mapController = Completer<google_maps_flutter.GoogleMapController>();

  Location _locationController = Location();
  static const google_maps_flutter.LatLng _pGooglePlex = google_maps_flutter.LatLng(37.422, -122.6484);
  google_maps_flutter.LatLng? _currentL;
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
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: (google_maps_flutter.GoogleMapController controller) {
              _mapController.complete(controller);
            },
            initialCameraPosition: const google_maps_flutter.CameraPosition(
              target: _pGooglePlex,
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
                style: const TextStyle(color: Colors.white), // Set text color to white
                decoration: InputDecoration(
                  hintText: "Search for a place",
                  hintStyle: const TextStyle(color: Colors.black), // Set hint color to white
                  prefixIcon: const Icon(Icons.search, color: Colors.black), // Set icon color to white
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white), // Set border color to white
                  ),
                  filled: true,
                  fillColor: Colors.white, // Make background color transparent
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
    google_maps_flutter.CameraPosition _newPosition = google_maps_flutter.CameraPosition(target: pos, zoom: 14);
    await controller.animateCamera(google_maps_flutter.CameraUpdate.newCameraPosition(_newPosition));
  }

  Future<void> _getLocationUpdates() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;
    _serviceEnabled = await _locationController.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await _locationController.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionGranted = await _locationController.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await _locationController.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _locationController.onLocationChanged.listen((LocationData currentLocation) {
      if (currentLocation.latitude != null && currentLocation.longitude != null) {
        setState(() {
          _currentL = google_maps_flutter.LatLng(currentLocation.latitude!, currentLocation.longitude!);
        });
        _cameraToLocation(_currentL!);
      }
    });
  }

  Future<void> _searchPlace(String placeName) async {
    String url =
        "https://maps.googleapis.com/maps/api/place/textsearch/json?query=$placeName&key=$kGoogleApiKey";
    http.Response response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data["status"] == "OK") {
        final results = data["results"];
        setState(() {
          _currentL = google_maps_flutter.LatLng(results[0]["geometry"]["location"]["lat"],
              results[0]["geometry"]["location"]["lng"]);
          _markers.clear(); // Clear existing markers
          for (var result in results) {
            final location = result["geometry"]["location"];
            google_maps_flutter.LatLng placeLocation =
                google_maps_flutter.LatLng(location["lat"], location["lng"]);
            _markers.add(
              google_maps_flutter.Marker(
                markerId: google_maps_flutter.MarkerId(result["place_id"]),
                position: placeLocation,
                infoWindow: google_maps_flutter.InfoWindow(
                  title: result["name"],
                ),
              ),
            );
          }
        });
        _cameraToLocation(_currentL!);
      }
    }
  }
}
