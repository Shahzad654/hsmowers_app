import 'package:geocoding/geocoding.dart';

Future<Map<String, double>> convertZipToLatLong(String zipCode) async {
  try {
    String query = '$zipCode, USA';
    List<Location> locations = await locationFromAddress(query);

    if (locations.isNotEmpty) {
      final loc = locations[0];
      return {
        'latitude': loc.latitude,
        'longitude': loc.longitude,
      };
    } else {
      throw Exception('No results found for ZIP code.');
    }
  } catch (e) {
    throw Exception('Geocoding error: $e');
  }
}
