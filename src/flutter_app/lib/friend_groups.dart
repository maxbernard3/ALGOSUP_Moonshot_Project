import 'package:flutter/material.dart';

class FriendGroupsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Friend Groups'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Text(
          'Friend Groups Page (empty)',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
