import 'package:flutter/material.dart';

class CustomScaffold extends StatelessWidget {
  final Widget body;
  final String title;
  final int currentIndex;

  const CustomScaffold({
    super.key,
    required this.body,
    required this.title,
    this.currentIndex = 0,
  });

  void _onItemTapped(BuildContext context, int index) {
    // Get the current route name to avoid re-pushing the same route.
    final currentRoute = ModalRoute.of(context)?.settings.name;
    switch (index) {
      case 0:
        if (currentRoute != '/home') {
          Navigator.pushReplacementNamed(context, '/home');
        }
        break;
      case 1:
        if (currentRoute != '/friend_groups') {
          Navigator.pushReplacementNamed(context, '/friend_groups');
        }
        break;
      case 2:
        if (currentRoute != '/trip_history') {
          Navigator.pushReplacementNamed(context, '/trip_history');
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: body,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        selectedItemColor: Colors.purple.withAlpha(125),
        unselectedItemColor: Colors.grey,
        onTap: (index) => _onItemTapped(context, index),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Text('👥', style: TextStyle(fontSize: 20)),
            label: 'Friend Groups',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Trip History',
          ),
        ],
      ),
    );
  }
}
