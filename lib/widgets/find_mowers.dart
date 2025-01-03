// ignore_for_file: prefer_const_constructors

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hsmowers_app/screens/other_user_profile.dart';
import 'package:hsmowers_app/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FindMowers extends StatefulWidget {
  const FindMowers({super.key});

  @override
  State<FindMowers> createState() => _FindMowersState();
}

class _FindMowersState extends State<FindMowers> {
  String? enteredZipCode;
  List<Map<String, dynamic>> userData = [];
  Set<Polygon> _polygons = {};
  Set<Marker> _markers = {};
  late GoogleMapController _mapController;
  bool showNoResultsMessage = false;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(39.9725, -85.9525),
    zoom: 13,
  );

  @override
  void initState() {
    super.initState();
  }

  Future<void> getCords() async {
    setState(() {
      showNoResultsMessage = false;
      _markers.clear();
    });

    if (enteredZipCode == null || enteredZipCode!.isEmpty) {
      return;
    }

    final collectionRef = FirebaseFirestore.instance.collection('userInfo');
    final query = collectionRef.where('zipCode', isEqualTo: enteredZipCode);

    try {
      final querySnapshot = await query.get();
      final List<Map<String, dynamic>> fetchedData = [];

      for (var doc in querySnapshot.docs) {
        fetchedData.add({
          'id': doc.id,
          ...doc.data(),
        });
      }

      setState(() {
        userData = fetchedData;
        showNoResultsMessage = fetchedData.isEmpty;
      });

      if (fetchedData.isNotEmpty) {
        _loadServiceArea(fetchedData);

        final serviceArea =
            fetchedData[0]['serviceArea']['path'] as List<dynamic>;
        if (serviceArea.isNotEmpty) {
          final firstPoint = serviceArea[0];
          final lat = firstPoint['lat'] as double;
          final lng = firstPoint['lng'] as double;

          await _mapController.animateCamera(
            CameraUpdate.newCameraPosition(
              CameraPosition(
                target: LatLng(lat, lng),
                zoom: 13,
              ),
            ),
          );
        }
      } else {
        setState(() {
          _polygons.clear();
          _markers.clear();
        });
      }
    } catch (error) {
      print('Error fetching documents: $error');
      setState(() {
        showNoResultsMessage = true;
      });
    }
  }

  void _loadServiceArea(List<Map<String, dynamic>> fetchedData) {
    Set<Polygon> newPolygons = {};
    Set<Marker> newMarkers = {};

    for (var user in fetchedData) {
      try {
        double centerLat = 39.9725;
        double centerLng = -85.9525;
        List<LatLng> polygonPoints = [];

        if (user['serviceArea'] != null) {
          var serviceArea = user['serviceArea'];

          if (serviceArea is Map && serviceArea['path'] is List) {
            var pathData = serviceArea['path'] as List;

            if (pathData.isNotEmpty) {
              double totalLat = 0;
              double totalLng = 0;
              int validPoints = 0;

              for (var point in pathData) {
                if (point is Map &&
                    point['lat'] != null &&
                    point['lng'] != null) {
                  final lat = point['lat'] as double;
                  final lng = point['lng'] as double;
                  polygonPoints.add(LatLng(lat, lng));
                  totalLat += lat;
                  totalLng += lng;
                  validPoints++;
                }
              }

              if (validPoints > 0) {
                centerLat = totalLat / validPoints;
                centerLng = totalLng / validPoints;
              }
            }
          }
        }

        final String displayName = user['displayName'] ?? 'Unknown';
        final String username = user['userName'] ?? 'Unknown';
        final String grade = user['grade']?.toString() ?? 'N/A';
        final String photoURL = user['photoURL'] ?? 'No imahe';

        newMarkers.add(
          Marker(
            markerId: MarkerId(user['id']),
            position: LatLng(centerLat, centerLng),
            infoWindow: InfoWindow(
              title: displayName,
              snippet: '''
$username
Grade: $grade
''',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => OtherUsers(username: username)),
                );
              },
            ),
          ),
        );

        if (polygonPoints.length >= 3) {
          newPolygons.add(Polygon(
            polygonId: PolygonId(user['id']),
            points: polygonPoints,
            strokeColor: Colors.red,
            strokeWidth: 3,
            fillColor: Colors.red.withOpacity(0.2),
            consumeTapEvents: true,
            onTap: () {
              _mapController.showMarkerInfoWindow(MarkerId(user['id']));
            },
          ));
        }
      } catch (e) {
        print('Error processing user ${user['id']}: $e');
        continue;
      }
    }

    setState(() {
      _polygons = newPolygons;
      _markers = newMarkers;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    enteredZipCode = value;
                    showNoResultsMessage = false;
                  });
                },
                onSubmitted: (value) {
                  getCords();
                },
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                  hintText: 'Enter zip code or address',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () => getCords(),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: AppColors.textColorLight),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24),
                    borderSide: BorderSide(color: AppColors.primary),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: _kGooglePlex,
            polygons: _polygons,
            markers: _markers,
            onMapCreated: _onMapCreated,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          if (showNoResultsMessage)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              color: Colors.white,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'No mowers found in zip code $enteredZipCode',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Try searching in a different zip code',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
