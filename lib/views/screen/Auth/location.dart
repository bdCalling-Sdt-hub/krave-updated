import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart'; // Import geocoding package

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  Position? _currentPosition;
  final Set<Marker> _markers = {};
  LatLng? _selectedLocation;
  final TextEditingController _locationController = TextEditingController();

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(-6.2088, 106.8456), // Default location (Jakarta)
    zoom: 14.0,
  );

  // Constants for text and error messages
  static const String defaultLocationError = 'Location services are disabled.';
  static const String deniedPermissionError = 'Location permissions are denied.';
  static const String deniedForeverPermissionError = 'Location permissions are permanently denied.';
  static const String pleaseSelectLocation = 'Please select a location on the map';
  static const String failedToRetrieveAddress = 'Failed to retrieve address';

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error(defaultLocationError);
    }

    // Check location permission status.
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error(deniedPermissionError);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(deniedForeverPermissionError);
    }

    // Get current position with high accuracy.
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _currentPosition = position;

      // Add marker at current location.
      _markers.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: const InfoWindow(title: 'You are here'),
        ),
      );
    });

    _goToCurrentLocation();
  }

  Future<void> _goToCurrentLocation() async {
    final GoogleMapController controller = await _controller.future;
    if (_currentPosition != null) {
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        zoom: 14.0,
      );
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    }
  }

  // Method to get address from coordinates
  Future<String?> _getAddressFromLatLng(LatLng latLng) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0];
      return '${place.locality}, ${place.country}'; // Customize as per your requirement
    }
    return null;
  }

  // Method to handle location selection
  void _onMapTapped(LatLng location) async {
    String? address = await _getAddressFromLatLng(location);

    setState(() {
      _selectedLocation = location;
      _markers.add(
        Marker(
          markerId: const MarkerId('selectedLocation'),
          position: location,
          infoWindow: const InfoWindow(title: 'Selected Location'),
        ),
      );
      if (address != null) {
        _locationController.text = address; // Update the text field with the address
      }
    });
  }

  @override
  void dispose() {
    _locationController.dispose(); // Dispose the controller when the widget is disposed
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),

            onPressed: () async {
              if (_selectedLocation != null) {
                String? address = await _getAddressFromLatLng(_selectedLocation!);
                Map data = {
                  "address" : "$address",
                  "latitude" : "${_selectedLocation!.latitude}",
                  "longitude" : "${_selectedLocation!.longitude}",
                };


                if (data.isNotEmpty) {
                  Navigator.pop(context, data); // Return the address to the previous screen
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text(failedToRetrieveAddress)),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text(pleaseSelectLocation)),
                );
              }
            },

          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _initialPosition,
            myLocationEnabled: true,
            markers: _markers,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            onTap: _onMapTapped, // Set the onTap handler
          ),
          Positioned(
            bottom: 80,
            left: 20,
            right: 20,
            child: TextField(
              controller: _locationController, // Bind the controller to the text field
              readOnly: true, // Make it read-only since the user should not type in it
              decoration: const InputDecoration(
                hintText: 'Selected Location Area',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
              onPressed: () {
                _getCurrentLocation();
              },
              child: const Text('Get Current Location'),
            ),
          ),
        ],
      ),
    );
  }
}
