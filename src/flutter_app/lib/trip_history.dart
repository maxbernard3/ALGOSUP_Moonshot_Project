import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import './shared/bottom_nav_bar.dart';
import 'package:path_provider/path_provider.dart';

// A simple data point representing a row from the CSV.
class DataPoint {
  final DateTime timestamp;
  final double mpg;
  DataPoint(this.timestamp, this.mpg);
}

class TripHistoryPage extends StatefulWidget {
  const TripHistoryPage({super.key});

  @override
  State<TripHistoryPage> createState() => _TripHistoryPageState();
}

class _TripHistoryPageState extends State<TripHistoryPage> {
  List<FileSystemEntity> _tripFiles = [];
  bool _showGraph = false;
  List<DataPoint> _tripData = [];
  String _currentTripFileName = '';

  @override
  void initState() {
    super.initState();
    _initFiles();
  }

  Future<void> _initFiles() async {
    final directory = await getApplicationDocumentsDirectory();

    final Directory dir = Directory('${directory.path}/driving_data');
    if (!await dir.exists()) {
      await dir.create();
    }
    // Get list of CSV files in the directory.
    _tripFiles =
        dir.listSync().where((entity) => entity.path.endsWith('.csv')).toList();
    // If there are fewer than 5 CSV files, generate new ones.
    if (_tripFiles.length < 5) {
      await _generateCSVFiles(dir);
      _tripFiles = dir
          .listSync()
          .where((entity) => entity.path.endsWith('.csv'))
          .toList();
    }
    // Sort files by name.
    _tripFiles.sort((a, b) => a.path.compareTo(b.path));
    setState(() {});
  }

  // Format a DateTime as YYYY-MM-DD.
  String _formatDate(DateTime dt) {
    String month = dt.month.toString().padLeft(2, '0');
    String day = dt.day.toString().padLeft(2, '0');
    return '${dt.year}-$month-$day';
  }

  // Generate 5 CSV files for 5 trips (one for each of the last 5 days).
  Future<void> _generateCSVFiles(Directory dir) async {
    final Random random = Random();
    for (int i = 0; i < 5; i++) {
      DateTime tripDate = DateTime.now().subtract(Duration(days: i));
      String fileName = 'driving_data_${_formatDate(tripDate)}.csv';
      File file = File('${dir.path}${Platform.pathSeparator}$fileName');
      // Build CSV content.
      StringBuffer sb = StringBuffer();
      sb.writeln('date_time,instant_mpg');
      // Generate 200 data points, starting at 8:00 AM.
      DateTime startTime =
          DateTime(tripDate.year, tripDate.month, tripDate.day, 8, 0, 0);
      for (int j = 0; j < 200; j++) {
        DateTime timestamp = startTime.add(Duration(minutes: j));
        String ts =
            '${timestamp.year}-${timestamp.month.toString().padLeft(2, '0')}-${timestamp.day.toString().padLeft(2, '0')} '
            '${timestamp.hour.toString().padLeft(2, '0')}:${timestamp.minute.toString().padLeft(2, '0')}:${timestamp.second.toString().padLeft(2, '0')}';
        double mpg = 10 + random.nextDouble() * 50; // MPG between 10 and 60.
        sb.writeln('$ts,$mpg');
      }
      await file.writeAsString(sb.toString());
    }
  }

  // Parse a CSV file and return a list of DataPoint objects.
  Future<List<DataPoint>> _loadTripData(File file) async {
    List<DataPoint> points = [];
    List<String> lines = await file.readAsLines();
    // Skip the header.
    for (int i = 1; i < lines.length; i++) {
      List<String> parts = lines[i].split(',');
      if (parts.length >= 2) {
        try {
          DateTime timestamp = DateTime.parse(parts[0]);
          double? mpg = double.tryParse(parts[1]);
          if (mpg != null) {
            points.add(DataPoint(timestamp, mpg));
          }
        } catch (e) {
          // Ignore any parsing errors.
        }
      }
    }
    return points;
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: 'Trip History',
      currentIndex: 2,
      body: _showGraph ? _buildGraphView() : _buildTripListView(),
    );
  }

  // Display a list of trips as elevated buttons.
  Widget _buildTripListView() {
    return ListView.builder(
      itemCount: _tripFiles.length,
      itemBuilder: (context, index) {
        String filePath = _tripFiles[index].path;
        String fileName = filePath.split(Platform.pathSeparator).last;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(16),
            ),
            onPressed: () async {
              File file = File(filePath);
              List<DataPoint> data = await _loadTripData(file);
              setState(() {
                _tripData = data;
                _currentTripFileName = fileName;
                _showGraph = true;
              });
            },
            child: Text(fileName),
          ),
        );
      },
    );
  }

  // Display the graph with axes for time and MPG.
  Widget _buildGraphView() {
    return GestureDetector(
      onTap: () {
        // Tapping the graph returns to the trip list.
        setState(() {
          _showGraph = false;
        });
      },
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _currentTripFileName,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(16.0),
              child: CustomPaint(
                painter: MPGGraphPainter(_tripData),
                child: Container(),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Tap the graph to return to the trip list'),
          )
        ],
      ),
    );
  }
}

// A CustomPainter that draws an MPG-over-time graph with visible axes.
class MPGGraphPainter extends CustomPainter {
  final List<DataPoint> data;
  MPGGraphPainter(this.data);

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    // Margins for the axes.
    const double marginLeft = 40.0;
    const double marginRight = 10.0;
    const double marginTop = 10.0;
    const double marginBottom = 30.0;

    final chartWidth = size.width - marginLeft - marginRight;
    final chartHeight = size.height - marginTop - marginBottom;

    final axisPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.0;

    // Draw x-axis.
    canvas.drawLine(
      Offset(marginLeft, size.height - marginBottom),
      Offset(size.width - marginRight, size.height - marginBottom),
      axisPaint,
    );
    // Draw y-axis.
    canvas.drawLine(
      Offset(marginLeft, marginTop),
      Offset(marginLeft, size.height - marginBottom),
      axisPaint,
    );

    // Determine min and max MPG.
    double minMPG = data.map((d) => d.mpg).reduce(min);
    double maxMPG = data.map((d) => d.mpg).reduce(max);
    double mpgRange = maxMPG - minMPG;
    if (mpgRange == 0) mpgRange = 1;

    // Draw y-axis ticks and labels.
    int yTicks = 5;
    final textStyle = const TextStyle(color: Colors.black, fontSize: 10);
    for (int i = 0; i <= yTicks; i++) {
      double tickValue = minMPG + (mpgRange / yTicks) * i;
      double yPos = marginTop +
          chartHeight -
          ((tickValue - minMPG) / mpgRange * chartHeight);
      // Draw tick.
      canvas.drawLine(
        Offset(marginLeft - 5, yPos),
        Offset(marginLeft, yPos),
        axisPaint,
      );
      // Draw label.
      TextPainter tp = TextPainter(
        text: TextSpan(text: tickValue.toStringAsFixed(1), style: textStyle),
        textAlign: TextAlign.right,
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(canvas, Offset(marginLeft - 8 - tp.width, yPos - tp.height / 2));
    }

    // Draw x-axis ticks and labels.
    int xTicks = 5;
    for (int i = 0; i <= xTicks; i++) {
      double fraction = i / xTicks;
      double xPos = marginLeft + fraction * chartWidth;
      // Draw tick.
      canvas.drawLine(
        Offset(xPos, size.height - marginBottom),
        Offset(xPos, size.height - marginBottom + 5),
        axisPaint,
      );
      // Determine corresponding data index.
      int dataIndex = (fraction * (data.length - 1)).round();
      DateTime time = data[dataIndex].timestamp;
      String timeLabel =
          '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
      TextPainter tp = TextPainter(
        text: TextSpan(text: timeLabel, style: textStyle),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(
          canvas, Offset(xPos - tp.width / 2, size.height - marginBottom + 5));
    }

    // Build the path for the MPG graph.
    final path = Path();
    for (int i = 0; i < data.length; i++) {
      double x = marginLeft + (i / (data.length - 1)) * chartWidth;
      double y = marginTop +
          chartHeight -
          ((data[i].mpg - minMPG) / mpgRange * chartHeight);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    final graphPaint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    canvas.drawPath(path, graphPaint);
  }

  @override
  bool shouldRepaint(covariant MPGGraphPainter oldDelegate) {
    return oldDelegate.data != data;
  }
}
