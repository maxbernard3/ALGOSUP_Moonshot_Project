// HOME PAGE: home_page.dart
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import './shared/bottom_nav_bar.dart';
import 'package:path_provider/path_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<Map<String, dynamic>> loadData() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/data.json');

    if (await file.exists()) {
      final content = await file.readAsString();
      return jsonDecode(content);
    } else {
      // Initialize both paired and start flags
      final defaultData = {
        'paired': false,
        'start': false,
      };
      await file.writeAsString(jsonEncode(defaultData));
      return defaultData;
    }
  }

  Future<void> _toggleStart(bool currentStart) async {
    //wait half a second
    await Future.delayed(const Duration(milliseconds: 400));

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/data.json');
    Map<String, dynamic> data = {};

    if (await file.exists()) {
      final contents = await file.readAsString();
      data = jsonDecode(contents) as Map<String, dynamic>;
    }

    data['start'] = !currentStart;
    await file.writeAsString(jsonEncode(data));

    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Home',
      currentIndex: 0,
      body: FutureBuilder<Map<String, dynamic>>(
        future: loadData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          }
          if (!snapshot.hasData) {
            return const Center(child: Text('No data found'));
          }

          final data = snapshot.data!;
          final paired = data['paired'] as bool? ?? false;

          if (!paired) {
            return Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.bluetooth),
                label: const Text('Pair Device'),
                onPressed: () {
                  Navigator.pushNamed(context, '/pairing_page')
                      .then((_) => setState(() {}));
                },
              ),
            );
          }

          final started = data['start'] as bool? ?? false;
          return Center(
            child: ElevatedButton.icon(
              icon: Icon(started ? Icons.stop : Icons.play_arrow),
              label: Text(started ? 'Stop' : 'Start'),
              onPressed: () => _toggleStart(started),
            ),
          );
        },
      ),
    );
  }
}
