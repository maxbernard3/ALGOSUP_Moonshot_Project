import 'package:flutter/material.dart';
import 'splash.dart'; // SplashScreen widget
import 'login.dart'; // LoginScreen widget
import 'signup.dart'; // SignupScreen widget
import 'home.dart'; // HomePage widget
import 'vehicle_info.dart'; // VehicleInfoScreen widget, if in separate file
import 'pairing_page.dart';
import 'friend_groups.dart';
import 'routes_page.dart';
import 'trip_history.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Navigation Demo',
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/vehicle_info': (context) => VehicleInfoScreen(),
        '/home': (context) => HomePage(),
        '/pairing_page': (context) => PairingPage(),
        '/friend_groups': (context) => FriendGroupsPage(),
        '/routes_page': (context) => RoutesPage(),
        '/trip_history': (context) => TripHistoryPage(),
      },
    );
  }
}
