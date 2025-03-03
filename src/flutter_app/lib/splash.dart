import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
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
              // You can replace FlutterLogo with your app logo
              FlutterLogo(size: 100.0),
              SizedBox(height: 50.0),
              // Login button (Login screen implementation not shown here)
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/login');
                },
                child: Text('Login'),
              ),
              SizedBox(height: 20.0),
              // Signup button navigates to the Signup screen in signup.dart
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
