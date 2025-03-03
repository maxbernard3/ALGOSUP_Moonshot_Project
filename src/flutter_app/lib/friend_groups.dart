import 'dart:io';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import './shared/bottom_nav_bar.dart';
import 'package:path_provider/path_provider.dart';

class FriendGroupsPage extends StatefulWidget {
  const FriendGroupsPage({super.key});

  @override
  State<FriendGroupsPage> createState() => _FriendGroupsPageState();
}

class _FriendGroupsPageState extends State<FriendGroupsPage> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _scrollKey = GlobalKey();

// Helper to generate a random string of a given length.
  String getRandomString(int length, Random random) {
    const availableChars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    return List.generate(length,
        (_) => availableChars[random.nextInt(availableChars.length)]).join();
  }

// Get the path for storing the leaderboard file
  Future<String> getLeaderboardFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/leaderboard.json';
  }

// Loads (or creates) the leaderboard.json with random data.
  Future<List<dynamic>> loadLeaderboard() async {
    final filePath = await getLeaderboardFilePath();
    final file = File(filePath);

    if (await file.exists()) {
      final content = await file.readAsString();
      return jsonDecode(content);
    } else {
      final random = Random();
      int userIndex = random.nextInt(100);
      List<Map<String, dynamic>> data = List.generate(100, (index) {
        int nameLength = random.nextInt(6) + 5; // length between 5 and 10.
        return {
          "name": getRandomString(nameLength, random),
          "average_mpg": (random.nextDouble() * 50 + 10),
          "vehicle_category": random.nextInt(4),
          "user": index == userIndex,
        };
      });

      await file.writeAsString(jsonEncode(data));
      return data;
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Using FutureBuilder to load the leaderboard.
    return CustomScaffold(
      title: 'Friend Groups',
      currentIndex: 1,
      body: FutureBuilder<List<dynamic>>(
        future: loadLeaderboard(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error loading leaderboard'));
          }
          if (snapshot.hasData) {
            // Sort entries by average MPG in descending order.
            List<dynamic> leaderboard = snapshot.data!;
            leaderboard.sort((a, b) {
              double mpgA = a["average_mpg"] as double;
              double mpgB = b["average_mpg"] as double;
              return mpgB.compareTo(mpgA);
            });

            // Find the index of the entry with user:true.
            int userIndex =
                leaderboard.indexWhere((entry) => entry["user"] == true);

            // Assumed fixed heights.
            const double rowHeight = 56.0;
            const double headerHeight = 56.0;

            // Build table rows (omitting the "user" column).
            List<DataRow> rows = [];
            for (int i = 0; i < leaderboard.length; i++) {
              final entry = leaderboard[i];
              rows.add(
                DataRow(
                  // Highlight the user row in semi-transparent purple.
                  color: entry["user"] == true
                      ? WidgetStateProperty.resolveWith(
                          (states) => Colors.purple.withAlpha(80))
                      : null,
                  cells: [
                    DataCell(Text('${i + 1}')), // Rank.
                    DataCell(Text(entry["name"].toString())),
                    DataCell(Text(
                        (entry["average_mpg"] as double).toStringAsFixed(2))),
                    DataCell(Text(entry["vehicle_category"].toString())),
                  ],
                ),
              );
            }

            // Build the UI with the table and the sticky button below.
            return Column(
              children: [
                // The table expands to fill available vertical space.
                Expanded(
                  child: SingleChildScrollView(
                    key: _scrollKey,
                    controller: _scrollController,
                    child: Center(
                      child: DataTable(
                        columns: const [
                          DataColumn(label: Text('Rank')),
                          DataColumn(label: Text('Name')),
                          DataColumn(label: Text('Average MPG')),
                          DataColumn(label: Text('Vehicle Category')),
                        ],
                        rows: rows,
                      ),
                    ),
                  ),
                ),
                // Sticky button always visible below the table.
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(8),
                  color: Colors.white,
                  child: ElevatedButton(
                    onPressed: () {
                      // Calculate the viewport height from the scrollable widget.
                      final box = _scrollKey.currentContext?.findRenderObject()
                          as RenderBox?;
                      if (box != null) {
                        final viewportHeight = box.size.height;
                        // Calculate the target offset so that the user row is centered.
                        double targetOffset = headerHeight +
                            (userIndex * rowHeight) +
                            (rowHeight / 2) -
                            (viewportHeight / 2);
                        if (targetOffset < 0) targetOffset = 0;
                        _scrollController.jumpTo(targetOffset);
                      }
                    },
                    child: const Text('See My Rank'),
                  ),
                ),
              ],
            );
          }
          return Center(child: Text('No data found'));
        },
      ),
    );
  }
}
