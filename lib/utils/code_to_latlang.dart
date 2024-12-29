import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class CodeToLatLang extends StatefulWidget {
  @override
  _CodeToLatLangState createState() => _CodeToLatLangState();
}

class _CodeToLatLangState extends State<CodeToLatLang> {
  final TextEditingController _zipCodeController = TextEditingController();
  String _output = 'Enter a ZIP code to look up its location';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ZIP Code Geocoding Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _zipCodeController,
              decoration: InputDecoration(
                labelText: 'ZIP Code',
                hintText: 'Enter ZIP Code',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              child: Text('Look up ZIP code'),
              onPressed: () async {
                String zipCode = _zipCodeController.text.trim();
                if (zipCode.isEmpty) {
                  setState(() {
                    _output = 'Please enter a ZIP code.';
                  });
                  return;
                }

                try {
                  // Add country context for better accuracy
                  String query = '$zipCode, USA';
                  List<Location> locations = await locationFromAddress(query);
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
