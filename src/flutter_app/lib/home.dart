import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import './shared/bottom_nav_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  // Reads the file "data.json". If it doesn't exist, creates it with default data.
  Future<Map<String, dynamic>> loadData() async {
    final file = File('data.json'); // Using a relative path
    if (await file.exists()) {
      final content = await file.readAsString();
      return jsonDecode(content);
    } else {
      // Default data: not paired.
      final defaultData = {"paired": false};
      await file.writeAsString(jsonEncode(defaultData));
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
