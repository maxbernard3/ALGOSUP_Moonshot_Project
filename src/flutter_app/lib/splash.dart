import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _resetFlags().then((_) {
      // After resetting, you can immediately show your login/signup UI,
      // or wait for a splash timeout if you like.
    });
  }

  Future<void> _resetFlags() async {
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/data.json');

    // Always overwrite with the default map:
    final defaultData = {
      'paired': false,
      'start': false,
    };

    // Write it out (this works whether or not the file already exists).
    await file.writeAsString(jsonEncode(defaultData));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(size: 100.0),
              SizedBox(height: 50.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text('Login'),
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/signup');
                },
                child: Text('Signup'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
