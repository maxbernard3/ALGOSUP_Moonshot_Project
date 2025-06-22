// PAIRING PAGE: pairing_page.dart
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class PairingPage extends StatefulWidget {
  const PairingPage({super.key});

  @override
  State<PairingPage> createState() => _PairingPageState();
}

class _PairingPageState extends State<PairingPage> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 3), _completePairing);
  }

  Future<void> _completePairing() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/data.json');

    Map<String, dynamic> data = {};
    if (await file.exists()) {
      final contents = await file.readAsString();
      data = jsonDecode(contents) as Map<String, dynamic>;
    }

    // Mark as paired and reset start flag
    data['paired'] = true;
    data['start'] = false;
    await file.writeAsString(jsonEncode(data));

    if (mounted) Navigator.pop(context);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pairing'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            _timer?.cancel();
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const CircularProgressIndicator(),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                _timer?.cancel();
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
          ],
        ),
      ),
    );
  }
}
