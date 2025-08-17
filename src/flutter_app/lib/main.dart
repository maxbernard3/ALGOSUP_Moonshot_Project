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
import 'map.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
        '/map': (context) => MapPage(),
      },
    );
  }
}
