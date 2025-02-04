import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Optional header; you can later style this as needed.
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Unused header placeholder (if you need extra space)
            Container(
              height: 50,
            ),
            // The buttons take up the remaining space
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // 1st Button: Pairing with a Bluetooth logo
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 37, 145, 233),
                        padding: EdgeInsets.symmetric(vertical: 20),
                      ),
                      icon:
                          Icon(Icons.bluetooth, color: Colors.white, size: 28),
                      label: Text(
                        'Pairing',
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/pairing_page');
                      },
                    ),
                  ),
                  // 2nd Button: Friend Groups with a friend emoji
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: Text('👥', style: TextStyle(fontSize: 24)),
                      label:
                          Text('Friend Groups', style: TextStyle(fontSize: 18)),
                      onPressed: () {
                        Navigator.pushNamed(context, '/friend_groups');
                      },
                    ),
                  ),
                  // 3rd Button: Routes with a road emoji
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: Text('🛣️', style: TextStyle(fontSize: 24)),
                      label: Text('Routes', style: TextStyle(fontSize: 18)),
                      onPressed: () {
                        Navigator.pushNamed(context, '/routes_page');
                      },
                    ),
                  ),
                  // 4th Button: Trip History with a sand clock emoji
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      icon: Text('⏳', style: TextStyle(fontSize: 24)),
                      label:
                          Text('Trip History', style: TextStyle(fontSize: 18)),
                      onPressed: () {
                        Navigator.pushNamed(context, '/trip_history');
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
