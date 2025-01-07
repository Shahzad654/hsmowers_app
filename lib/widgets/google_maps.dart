// ignore_for_file: prefer_final_fields, prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hsmowers_app/screens/auth.dart';
import 'package:hsmowers_app/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

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
  Set<Polyline> _polylines = <Polyline>{};
  List<LatLng> _polylinePoints = [];

  late double _latitude;
  late double _longitude;
  bool _isLatLongLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadLatLng();
  }

  Future<void> _loadLatLng() async {
    final prefs = await SharedPreferences.getInstance();
    String? latLongString = prefs.getString('UserInfo_Shared_Perference');

    if (latLongString != null) {
      Map<String, dynamic> latLong = jsonDecode(latLongString);
      setState(() {
        _latitude = latLong['latitude'];
        _longitude = latLong['longitude'];
        _isLatLongLoaded = true;
      });
      print('Loaded LatLng: $_latitude, $_longitude');
    } else {
      _latitude = 32.18117;
      _longitude = 74.18513;
      _isLatLongLoaded = true;
    }
  }

  void _onTap(LatLng point) {
    setState(() {
      _polylinePoints.add(point);

      _polylines.add(
        Polyline(
          polylineId: PolylineId('polyline_1'),
          points: _polylinePoints,
          color: Colors.red,
          width: 3,
        ),
      );
    });
  }

  void _finishDrawing() async {
    if (_polylinePoints.isNotEmpty) {
      List<Map<String, double>> polygonCoordinates =
          _polylinePoints.map((point) {
        return {
          'lat': point.latitude,
          'lng': point.longitude,
        };
      }).toList();

      try {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? uid = prefs.getString('uid');

        if (uid != null) {
          await FirebaseFirestore.instance
              .collection('userInfo')
              .doc(uid)
              .update({
            'serviceArea': {
              'path': polygonCoordinates,
            },
          });
          String polygonCoordinatesString = jsonEncode(polygonCoordinates);
          await prefs.setString('serviceArea', polygonCoordinatesString);

          print('Polygon saved to Firestore successfully.');
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => AuthScreen()));
        } else {
          print('Email not found in shared preferences.');
        }
      } catch (e) {
        print('Error saving polygon: $e');
      }
    }
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
      body: !_isLatLongLoaded
          ? Center(
              child: CircularProgressIndicator(
              color: AppColors.primary,
            ))
          : GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(_latitude, _longitude),
                zoom: 14,
              ),
              markers: {
                Marker(
                  markerId: MarkerId('user_location'),
                  position: LatLng(_latitude, _longitude),
                  infoWindow: InfoWindow(title: "Your Location"),
                ),
              },
              polylines: _polylines,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              onTap: _onTap,
            ),
    );
  }
}
