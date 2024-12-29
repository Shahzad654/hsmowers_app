// ignore_for_file: sort_child_properties_last, avoid_print

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapDraw extends StatefulWidget {
  const MapDraw({super.key});

  @override
  State<MapDraw> createState() => _MapDrawState();
}

class _MapDrawState extends State<MapDraw> {
  GoogleMapController? mapController;
  final Set<Polygon> _polygons = {};
  final List<LatLng> _polygonPoints = [];
  bool _isMapCreated = false;

  static const LatLng _center = LatLng(37.7749, -122.4194);

  @override
  void initState() {
    super.initState();
  }

  void _onMapCreated(GoogleMapController controller) {
    print("Map created successfully!");
    setState(() {
      mapController = controller;
      _isMapCreated = true;
    });
  }

  void _clearDrawing() {
    print("Clearing drawing...");
    setState(() {
      _polygons.clear();
      _polygonPoints.clear();
    });
  }

  void _onTap(LatLng point) {
    print("Tapped at: $point");

    if (mapController == null || !_isMapCreated) {
      print("Map not created yet or controller is null!");
      return;
    }

    setState(() {
      _polygonPoints.add(point);

      if (_polygonPoints.length > 2) {
        _polygons.add(
          Polygon(
            polygonId: PolygonId('polygon_${_polygons.length}'),
            points: List.from(_polygonPoints),
            strokeColor: Colors.green,
            fillColor: Colors.green.withOpacity(0.3),
            strokeWidth: 5,
          ),
        );
        _polygonPoints.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Polygon Drawing Tool'),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear),
            onPressed: _clearDrawing,
            tooltip: 'Clear All',
          ),
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: const CameraPosition(
              target: _center,
              zoom: 12,
            ),
            polygons: _polygons,
            onTap: _onTap,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: 8),
          if (_polygonPoints.isNotEmpty)
            FloatingActionButton(
              onPressed: _clearDrawing,
              child: const Icon(Icons.check),
              backgroundColor: Colors.green,
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    mapController?.dispose();
    super.dispose();
  }
}
