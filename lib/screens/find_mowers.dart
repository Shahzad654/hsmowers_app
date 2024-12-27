// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FindMowers extends StatefulWidget {
  const FindMowers({super.key});

  @override
  State<FindMowers> createState() => _FindMowersState();
}

class _FindMowersState extends State<FindMowers> {
  @override
  Widget build(BuildContext context) {
    return 
    SafeArea(
      child: Scaffold(
        body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(37.7749, -122.4194), // San Francisco coordinates
          zoom: 12,
        ),
        )
      ),
    );
  }
}