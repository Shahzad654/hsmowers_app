// ignore_for_file: prefer_final_fields, prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hsmowers_app/theme.dart';

class GoogleMaps extends StatefulWidget {
  const GoogleMaps({super.key});

  @override
  State<GoogleMaps> createState() => _GoogleMapsState();
}

class _GoogleMapsState extends State<GoogleMaps> {
  static final CameraPosition _kGooglePlex =
      CameraPosition(target: LatLng(32.18117, 74.18513), zoom: 14);
  Completer<GoogleMapController> _controller = Completer();

  List<Marker> _marker = [];
  List<Marker> _list = const [
    Marker(
        markerId: MarkerId('1'),
        position: LatLng(32.18117, 74.18513),
        infoWindow: InfoWindow(title: "Location")),
    Marker(
        markerId: MarkerId('2'),
        position: LatLng(32.18115, 74.18500),
        infoWindow: InfoWindow(title: "Location"))
  ];

  Set<Polygon> _polygons = Set<Polygon>();

  List<LatLng> _polygonPoints = [];

  @override
  void initState() {
    super.initState();
    _marker.addAll((_list));
  }

  void _onTap(LatLng point) {
    setState(() {
      _polygonPoints.add(point);

      _polygons.add(
        Polygon(
          polygonId: PolygonId('polygon_1'),
          points: _polygonPoints,
          strokeColor: Colors.red,
          strokeWidth: 2,
          fillColor: Colors.red.withOpacity(0.3),
        ),
      );
    });
  }

  void _finishDrawing() {
    setState(() {
      if (_polygonPoints.isNotEmpty) {
        print('Final Polygon Coordinates:');
        for (var point in _polygonPoints) {
          print("Lat: ${point.latitude}, Lng: ${point.longitude}");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Select your area",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: AppColors.primary,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.check,
              color: Colors.white,
            ),
            onPressed: _finishDrawing,
          ),
        ],
      ),
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        markers: Set<Marker>.of(_marker),
        polygons: _polygons,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        onTap: _onTap,
      ),
    );
  }
}
