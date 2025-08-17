import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import './shared/bottom_nav_bar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart' as p;
import 'dart:convert' show json;

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

  // --- Viewport state (X only) ---
  // Fractional start (0..1) of the visible window over the full time extent.
  double _windowStartFrac = 0.0;
  // Fractional span (0..1) of the visible window; 1/zoom. 1.0 = fully zoomed out.
  double _windowSpanFrac = 1.0;

  // Gesture anchors
  double _gestureStartWindowStartFrac = 0.0;
  double _gestureStartWindowSpanFrac = 1.0;

  // For layout queries during gestures
  final GlobalKey _paintAreaKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _initFiles();
  }

  Future<void> _seedCsvs({bool overwrite = true}) async {
    final docs = await getApplicationDocumentsDirectory();
    final dir = Directory('${docs.path}/driving_data');
    if (!await dir.exists()) await dir.create(recursive: true);

    // Load the list of assets and filter to assets/driving_data/*.csv
    final manifestJson = await rootBundle.loadString('AssetManifest.json');
    final Map<String, dynamic> manifest = json.decode(manifestJson);
    final assetCsvs = manifest.keys.where(
      (k) => k.startsWith('assets/driving_data/') && k.endsWith('.csv'),
    );

    for (final assetPath in assetCsvs) {
      final data = await rootBundle.load(assetPath);
      final out = File(p.join(dir.path, p.basename(assetPath)));

      if (!overwrite && await out.exists()) {
        continue;
      }
      await out.writeAsBytes(
        data.buffer.asUint8List(),
        flush: true,
        mode: FileMode.write,
      );
    }
  }

  Future<void> _initFiles() async {
    await _seedCsvs(overwrite: true); // <-- always overwrite

    final directory = await getApplicationDocumentsDirectory();
    final dir = Directory('${directory.path}/driving_data');
    if (!await dir.exists()) {
      await dir.create(recursive: true);
    }

    _tripFiles = dir
        .listSync()
        .where((e) => e.path.toLowerCase().endsWith('.csv'))
        .toList()
      ..sort((a, b) => a.path.compareTo(b.path));

    setState(() {});
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
        } catch (_) {}
      }
    }
    return points;
  }

  void _resetViewport() {
    _windowStartFrac = 0.0;
    _windowSpanFrac = 1.0;
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
            style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
            onPressed: () async {
              File file = File(filePath);
              List<DataPoint> data = await _loadTripData(file);
              setState(() {
                _tripData = data;
                _currentTripFileName = fileName;
                _showGraph = true;
                _resetViewport();
              });
            },
            child: Text(fileName),
          ),
        );
      },
    );
  }

  // Display the graph with axes for time and MPG, with X-only zoom/pan.
  Widget _buildGraphView() {
    // Margins used by the painter (must match painter constants)
    const marginLeft = 40.0, marginRight = 10.0;

    List<String> advices = [
      "Accelerate gently and smoothly instead of flooring the gas.",
      "Anticipate traffic flow to reduce unnecessary braking.",
      "Shift up early when driving a manual, avoid high RPMs.",
      "Keep tires properly inflated to reduce rolling resistance.",
      "Avoid prolonged idling—turn off the engine if stopped for long.",
      "Keep your vehicle well maintained (oil, filters, spark plugs).",
    ];

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  _currentTripFileName,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              IconButton(
                tooltip: 'Reset zoom',
                onPressed: () => setState(_resetViewport),
                icon: const Icon(Icons.refresh),
              ),
              IconButton(
                tooltip: 'Back to trips',
                onPressed: () {
                  setState(() => _showGraph = false);
                },
                icon: const Icon(Icons.list),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final chartWidth =
                    constraints.maxWidth - marginLeft - marginRight;

                return GestureDetector(
                  onScaleStart: (details) {
                    _gestureStartWindowStartFrac = _windowStartFrac;
                    _gestureStartWindowSpanFrac = _windowSpanFrac;
                  },
                  onScaleUpdate: (details) {
                    if (_tripData.isEmpty) return;

                    // Limit zoom levels.
                    const double minSpan = 1 / 100.0; // max 100x zoom in
                    const double maxSpan = 1.0; // fully zoomed out

                    // Compute f = focal position in [0,1] across plotting area.
                    final renderBox = _paintAreaKey.currentContext
                        ?.findRenderObject() as RenderBox?;
                    final local = renderBox?.globalToLocal(details.focalPoint);
                    final double f = () {
                      if (local == null) return 0.5;
                      final x = (local.dx - marginLeft) / chartWidth;
                      return x.clamp(0.0, 1.0);
                    }();

                    // 1) Zoom relative to gesture start (pinch scale)
                    double newSpan =
                        (_gestureStartWindowSpanFrac / details.scale)
                            .clamp(minSpan, maxSpan);

                    // Keep focal time fixed during zoom:
                    final double targetFrac = _gestureStartWindowStartFrac +
                        f * _gestureStartWindowSpanFrac;
                    double newStart = targetFrac - f * newSpan;

                    // 2) Pan for ANY pointer count (one- or two-finger translation)
                    if (details.focalPointDelta.dx != 0) {
                      final double dxPixels = details.focalPointDelta.dx;
                      // Pan speed scales with current zoom (span).
                      final double dxFrac = -(dxPixels / chartWidth) * newSpan;
                      newStart += dxFrac;
                    }

                    // Clamp to [0, 1 - newSpan]
                    newStart = newStart.clamp(0.0, 1.0 - newSpan);

                    setState(() {
                      _windowSpanFrac = newSpan;
                      _windowStartFrac = newStart;
                    });
                  },
                  child: RepaintBoundary(
                    key: _paintAreaKey,
                    child: CustomPaint(
                      painter: MPGGraphPainter(
                        _tripData,
                        windowStartFrac: _windowStartFrac,
                        windowSpanFrac: _windowSpanFrac,
                      ),
                      child: Container(), // expands to constraints
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/map');
                },
                child: Text('See map'),
              ),
              const SizedBox(height: 8),
              Text(
                advices[Random().nextInt(advices.length)],
                style: const TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// A CustomPainter that draws an MPG-over-time graph with visible axes.
// Y range is fixed to the full dataset; X window is controlled by windowStartFrac/windowSpanFrac.
class MPGGraphPainter extends CustomPainter {
  final List<DataPoint> data;
  final double windowStartFrac; // 0..1
  final double windowSpanFrac; // 0..1

  MPGGraphPainter(
    this.data, {
    required this.windowStartFrac,
    required this.windowSpanFrac,
  });

  // Margins must match those in _buildGraphView for correct gesture math.
  static const double marginLeft = 40.0;
  static const double marginRight = 10.0;
  static const double marginTop = 10.0;
  static const double marginBottom = 30.0;

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final chartWidth = size.width - marginLeft - marginRight;
    final chartHeight = size.height - marginTop - marginBottom;

    final axisPaint = Paint()
      ..color = Colors.black
      ..strokeWidth = 1.0;

    // Draw axes.
    canvas.drawLine(
      Offset(marginLeft, size.height - marginBottom),
      Offset(size.width - marginRight, size.height - marginBottom),
      axisPaint,
    );
    canvas.drawLine(
      Offset(marginLeft, marginTop),
      Offset(marginLeft, size.height - marginBottom),
      axisPaint,
    );

    // ---- Y scale: fixed to full dataset ----
    double minMPG = data.map((d) => d.mpg).reduce(min);
    double maxMPG = data.map((d) => d.mpg).reduce(max);
    double mpgRange = max(1e-9, maxMPG - minMPG); // avoid div-by-zero

    // Y ticks & labels.
    const int yTicks = 5;
    final textStyle = const TextStyle(color: Colors.black, fontSize: 10);
    for (int i = 0; i <= yTicks; i++) {
      double tickValue = minMPG + (mpgRange / yTicks) * i;
      double yPos = marginTop +
          chartHeight -
          ((tickValue - minMPG) / mpgRange * chartHeight);
      canvas.drawLine(
        Offset(marginLeft - 5, yPos),
        Offset(marginLeft, yPos),
        axisPaint,
      );
      final tp = TextPainter(
        text: TextSpan(text: tickValue.toStringAsFixed(1), style: textStyle),
        textAlign: TextAlign.right,
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(marginLeft - 8 - tp.width, yPos - tp.height / 2));
    }

    // ---- X window in time ----
    final DateTime minT = data.first.timestamp.isBefore(data.last.timestamp)
        ? data.first.timestamp
        : data.map((d) => d.timestamp).reduce((a, b) => a.isBefore(b) ? a : b);
    final DateTime maxT = data.first.timestamp.isAfter(data.last.timestamp)
        ? data.first.timestamp
        : data.map((d) => d.timestamp).reduce((a, b) => a.isAfter(b) ? a : b);
    final totalMs =
        max(1, maxT.millisecondsSinceEpoch - minT.millisecondsSinceEpoch);

    final double startFrac = windowStartFrac.clamp(0.0, 1.0);
    final double spanFrac = windowSpanFrac.clamp(0.0, 1.0);
    final int viewStartMs =
        minT.millisecondsSinceEpoch + (totalMs * startFrac).round();
    final int viewEndMs = minT.millisecondsSinceEpoch +
        (totalMs * (startFrac + spanFrac)).round();
    final int viewRangeMs = max(1, viewEndMs - viewStartMs);

    // X ticks based on time window.
    const int xTicks = 5;
    for (int i = 0; i <= xTicks; i++) {
      final double frac = i / xTicks;
      final double xPos = marginLeft + frac * chartWidth;
      canvas.drawLine(
        Offset(xPos, size.height - marginBottom),
        Offset(xPos, size.height - marginBottom + 5),
        axisPaint,
      );
      final tickMs = viewStartMs + (viewRangeMs * frac).round();
      final t = DateTime.fromMillisecondsSinceEpoch(tickMs);
      final label =
          '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';
      final tp = TextPainter(
        text: TextSpan(text: label, style: textStyle),
        textAlign: TextAlign.center,
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(
          canvas, Offset(xPos - tp.width / 2, size.height - marginBottom + 5));
    }

    // Build path over visible window only.
    final path = Path();

    // Ensure data sorted by time for correct rendering.
    final sorted = [...data]
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

    bool moved = false;
    for (final d in sorted) {
      final ms = d.timestamp.millisecondsSinceEpoch;
      if (ms < viewStartMs || ms > viewEndMs) continue;

      final double xFrac = (ms - viewStartMs) / viewRangeMs;
      final double x = marginLeft + xFrac * chartWidth;
      final double y =
          marginTop + chartHeight - ((d.mpg - minMPG) / mpgRange * chartHeight);
      if (!moved) {
        path.moveTo(x, y);
        moved = true;
      } else {
        path.lineTo(x, y);
      }
    }

    if (moved) {
      final graphPaint = Paint()
        ..color = Colors.blue
        ..strokeWidth = 2.0
        ..style = PaintingStyle.stroke;
      canvas.drawPath(path, graphPaint);
    }
  }

  @override
  bool shouldRepaint(covariant MPGGraphPainter old) {
    return old.data != data ||
        old.windowStartFrac != windowStartFrac ||
        old.windowSpanFrac != windowSpanFrac;
  }
}
