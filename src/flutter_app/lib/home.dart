import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import './shared/bottom_nav_bar.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<Map<String, dynamic>> loadData() async {
    // 1. Get the application's documents directory, which is a safe place to store files.
    final directory = await getApplicationDocumentsDirectory();

    // 2. Construct the full file path by appending 'data.json' to the directory path.
    final file = File('${directory.path}/data.json');

    // 3. Check if the file already exists in that directory.
    if (await file.exists()) {
      // 3a. If it exists, read the entire file content as a string.
      final content = await file.readAsString();
      // 3b. Decode the JSON string into a Dart Map and return it.
      return jsonDecode(content);
    } else {
      // 4. If the file doesn't exist, define a default data Map.
      final defaultData = {"paired": false};
      // 5. Convert the default Map to a JSON string and write it to the file.
      await file.writeAsString(jsonEncode(defaultData));
      // 6. Return the default data Map.
      return defaultData;
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Home',
      currentIndex: 0,
      body: FutureBuilder<Map<String, dynamic>>(
        future: loadData(),
        builder: (context, snapshot) {
          // Show a loader while reading the file.
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          // Handle error state.
          if (snapshot.hasError) {
            return Center(child: Text('Error loading data'));
          }
          // Once data is available, check the "paired" flag.
          if (snapshot.hasData) {
            bool paired = snapshot.data?['paired'] ?? false;
            if (!paired) {
              // If not paired, show the pairing button.
              return Center(
                child: ElevatedButton.icon(
                  icon: Icon(Icons.bluetooth),
                  label: Text('Pair Device'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/pairing_page');
                  },
                ),
              );
            }
            // If already paired, show the default home content.
            return Center(
              child: Text(
                'Home Page Content',
                style: TextStyle(fontSize: 24),
              ),
            );
          }
          // Fallback UI.
          return Center(child: Text('No data found'));
        },
      ),
    );
  }
}
