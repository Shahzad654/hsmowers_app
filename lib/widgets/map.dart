// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

enum DrawingMode { none, marker, polyline, polygon, circle }

class MapDraw extends StatefulWidget {
  const MapDraw({super.key});

  @override
  State<MapDraw> createState() => _MapDrawState();
}

class _MapDrawState extends State<MapDraw> {
  GoogleMapController? mapController;
  Set<Marker> _markers = {};
  Set<Polyline> _polylines = {};
  Set<Polygon> _polygons = {};
  Set<Circle> _circles = {};
  List<LatLng> _polylinePoints = [];
  List<LatLng> _polygonPoints = [];
  DrawingMode _currentMode = DrawingMode.none;
  bool _isMapCreated = false;

  static const LatLng _center = LatLng(37.7749, -122.4194); 

  @override
  void initState() {
    super.initState();
    _resetDrawingState();
  }

 
  void _resetDrawingState() {
    _markers = {};
    _polylines = {};
    _polygons = {};
    _circles = {};
    _polylinePoints = [];
    _polygonPoints = [];
    _currentMode = DrawingMode.none;
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
      _resetDrawingState();
    });
  }


  void _onTap(LatLng point) {
    print("Tapped at: $point");

   
    if (mapController == null || !_isMapCreated) {
      print("Map not created yet or controller is null!");
      return;
    }

    setState(() {
      switch (_currentMode) {
        case DrawingMode.marker:
          _addMarker(point);
          break;
        case DrawingMode.polyline:
          _drawPolyline(point);
          break;
        case DrawingMode.polygon:
          _drawPolygon(point);
          break;
        case DrawingMode.circle:
          _addCircle(point);
          break;
        case DrawingMode.none:
          break;
      }
    });
  }

  
  void _addMarker(LatLng point) {
    print("Adding marker at: $point");
    _markers.add(
      Marker(
        markerId: MarkerId('marker_${point.latitude}_${point.longitude}'),
        position: point,
        infoWindow: InfoWindow(
          title: 'Marker',
          snippet: '${point.latitude}, ${point.longitude}',
        ),
      ),
    );
  }

 
  void _drawPolyline(LatLng point) {
    print("Adding point to polyline: $point");
    _polylinePoints.add(point);
    if (_polylinePoints.length > 1) {
      _polylines.add(
        Polyline(
          polylineId: PolylineId('polyline_${_polylines.length}'),
          points: List.from(_polylinePoints),
          color: Colors.blue,
          width: 5,
        ),
      );
    }
  }

 
  void _drawPolygon(LatLng point) {
    print("Adding point to polygon: $point");
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
    }
  }

  
  void _addCircle(LatLng center) {
    print("Adding circle at: $center");
    _circles.add(
      Circle(
        circleId: CircleId('circle_${_circles.length}'),
        center: center,
        radius: 1000, // radius in meters
        strokeColor: Colors.red,
        fillColor: Colors.red.withOpacity(0.3),
        strokeWidth: 3,
      ),
    );
  }

 
  void _finishDrawing() {
    print("Finishing drawing...");
    setState(() {
      _polylinePoints.clear();
      _polygonPoints.clear();
      _currentMode = DrawingMode.none;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map Drawing Tools'),
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
            markers: _markers,
            polylines: _polylines,
            polygons: _polygons,
            circles: _circles,
            onTap: _onTap,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          if (_currentMode != DrawingMode.none)
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Drawing Mode: ${_currentMode.toString().split('.').last}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () => setState(() => _currentMode = DrawingMode.marker),
            child: const Icon(Icons.push_pin),
            heroTag: 'marker',
            backgroundColor:
                _currentMode == DrawingMode.marker ? Colors.blue : null,
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: () =>
                setState(() => _currentMode = DrawingMode.polyline),
            child: const Icon(Icons.timeline),
            heroTag: 'polyline',
            backgroundColor:
                _currentMode == DrawingMode.polyline ? Colors.blue : null,
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: () => setState(() => _currentMode = DrawingMode.polygon),
            child: const Icon(Icons.pentagon),
            heroTag: 'polygon',
            backgroundColor:
                _currentMode == DrawingMode.polygon ? Colors.blue : null,
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            onPressed: () => setState(() => _currentMode = DrawingMode.circle),
            child: const Icon(Icons.circle_outlined),
            heroTag: 'circle',
            backgroundColor:
                _currentMode == DrawingMode.circle ? Colors.blue : null,
          ),
          const SizedBox(height: 8),
          if (_currentMode != DrawingMode.none)
            FloatingActionButton(
              onPressed: _finishDrawing,
              child: const Icon(Icons.check),
              heroTag: 'finish',
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
