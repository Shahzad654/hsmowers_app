// ignore_for_file: prefer_const_constructors, prefer_final_fields

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  @override
  void initState() {
    super.initState();
    _marker.addAll((_list));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        markers: Set<Marker>.of(_marker),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
