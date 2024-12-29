import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class AddressToCode extends StatefulWidget {
  @override
  _AddressToCodeState createState() => _AddressToCodeState();
}

class _AddressToCodeState extends State<AddressToCode> {
  String _output = 'Enter an address to look up its location';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Geocoding Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: ElevatedButton(
                child: Text('Look up hardcoded location'),
                onPressed: () async {
                  String hardcodedAddress =
                      '1600 Amphitheatre Parkway, Mountain View, CA';
                  try {
                    List<Location> locations =
                        await locationFromAddress(hardcodedAddress);
                    String output = 'No results found.';
                    if (locations.isNotEmpty) {
                      final loc = locations[0];
                      output =
                          'Latitude: ${loc.latitude}, Longitude: ${loc.longitude}';
                    }
                    setState(() {
                      _output = output;
                    });
                  } catch (e) {
                    setState(() {
                      _output = 'Error: $e';
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            Text(
              _output,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
