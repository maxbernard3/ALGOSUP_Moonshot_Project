import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_app/shared/bottom_nav_bar.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;

class DataPoint {
  final DateTime timestamp;
  final double mpg;
  DataPoint(this.timestamp, this.mpg);
}

class MapPage extends StatefulWidget {
  const MapPage({super.key});
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // Hard-set addresses here:
  static const String fromAddress = '47.26920088299366, 1.4406439952906247';
  static const String toAddress = '47.27123222413898, 1.45429544577609';

  final _map = MapController();
  bool _loading = true;
  String? _error;

  LatLng? _from;
  LatLng? _to;
  List<DataPoint> _samples = [];
  List<Polyline> _coloredSegments = [];

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    try {
      // 1) Load CSV trip data (timestamp,mpg) — timestamps ignored
      final csv =
          await rootBundle.loadString('assets/driving_data/2025-08-09-0.csv');
      _samples = _parseCsv(csv);
      if (_samples.length < 2) {
        throw Exception('Need at least 2 CSV rows.');
      }

      // 2) Geocode both addresses
      _from = await _geocode(fromAddress);
      _to = await _geocode(toAddress);

      // 3) Route polyline (many points)
      final route = await _fetchRoute(_from!, _to!); // List<LatLng>

      // 4) Resample route to exactly N points (N = _samples.length)
      final resampled = _resamplePolyline(route, _samples.length);

      // 5) Build colored segments using mpg
      _coloredSegments = _buildMpgColoredSegments(
        track: resampled,
        samples: _samples,
        strokeWidth: 6,
      );

      setState(() => _loading = false);

      // Fit map to the route
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted && resampled.isNotEmpty) {
          final bounds = LatLngBounds.fromPoints(resampled);
          _map.fitCamera(CameraFit.bounds(
            bounds: bounds,
            padding: const EdgeInsets.all(24),
          ));
        }
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _loading = false;
      });
    }
  }

  // ------------ CSV ------------
  List<DataPoint> _parseCsv(String content) {
    final lines = const LineSplitter().convert(content);
    final out = <DataPoint>[];
    for (int i = 1; i < lines.length; i++) {
      final parts = lines[i].split(',');
      if (parts.length >= 2) {
        final ts = DateTime.tryParse(parts[0].trim()) ??
            DateTime.fromMillisecondsSinceEpoch(0);
        final mpg = double.tryParse(parts[1].trim());
        if (mpg != null) out.add(DataPoint(ts, mpg));
      }
    }
    return out;
  }

  // ------------ Geocode + Route (Nominatim + OSRM demo) ------------
  Future<LatLng> _geocode(String query) async {
    final uri = Uri.https('nominatim.openstreetmap.org', '/search', {
      'q': query,
      'format': 'json',
      'limit': '1',
    });
    final res = await http.get(uri, headers: {
      'User-Agent': 'minimal-flutter-map/1.0 (example@app.dev)',
    });
    if (res.statusCode != 200)
      throw Exception('Geocoding failed: ${res.statusCode}');
    final data = jsonDecode(res.body) as List;
    if (data.isEmpty) throw Exception('No geocoding results for "$query"');
    final lat = double.parse(data[0]['lat']);
    final lon = double.parse(data[0]['lon']);
    return LatLng(lat, lon);
  }

  Future<List<LatLng>> _fetchRoute(LatLng from, LatLng to) async {
    final path =
        '/route/v1/driving/${from.longitude},${from.latitude};${to.longitude},${to.latitude}';
    final uri = Uri.https('router.project-osrm.org', path, {
      'overview': 'full',
      'geometries': 'geojson',
    });
    final res = await http.get(uri, headers: {
      'User-Agent': 'minimal-flutter-map/1.0 (example@app.dev)',
    });
    if (res.statusCode != 200)
      throw Exception('Routing failed: ${res.statusCode}');
    final data = jsonDecode(res.body);
    final routes = data['routes'] as List?;
    if (routes == null || routes.isEmpty) throw Exception('No route found');
    final coords = routes[0]['geometry']['coordinates'] as List;
    return coords
        .map<LatLng>(
            (c) => LatLng((c[1] as num).toDouble(), (c[0] as num).toDouble()))
        .toList(growable: false);
  }

  // ------------ Resample the polyline to exactly N points (equal arc length) ------------
  List<LatLng> _resamplePolyline(List<LatLng> polyline, int nPoints) {
    if (polyline.length < 2 || nPoints < 2)
      return polyline.take(math.max(polyline.length, nPoints)).toList();

    // cumulative distances
    final dist = Distance();
    final cum = <double>[0.0];
    for (int i = 1; i < polyline.length; i++) {
      final d = dist(polyline[i - 1], polyline[i]);
      cum.add(cum.last + d);
    }
    final total = cum.last;

    List<LatLng> out = [];
    for (int k = 0; k < nPoints; k++) {
      final target = (total * k) / (nPoints - 1);
      // find segment where cum[i] <= target <= cum[i+1]
      int i = _lowerBound(cum, target);
      if (i >= cum.length - 1) {
        out.add(polyline.last);
      } else {
        final t = (target - cum[i]) /
            (cum[i + 1] - cum[i] == 0 ? 1 : (cum[i + 1] - cum[i]));
        out.add(_lerpLatLng(polyline[i], polyline[i + 1], t));
      }
    }
    return out;
  }

  int _lowerBound(List<double> arr, double x) {
    int lo = 0, hi = arr.length - 1;
    while (lo < hi) {
      int mid = (lo + hi) >> 1;
      if (arr[mid] < x) {
        lo = mid + 1;
      } else {
        hi = mid;
      }
    }
    return (lo > 0 && arr[lo] > x) ? lo - 1 : lo;
  }

  LatLng _lerpLatLng(LatLng a, LatLng b, double t) {
    return LatLng(a.latitude + (b.latitude - a.latitude) * t,
        a.longitude + (b.longitude - a.longitude) * t);
  }

  // ------------ Color segments by MPG ------------
  List<Polyline> _buildMpgColoredSegments({
    required List<LatLng> track,
    required List<DataPoint> samples,
    double strokeWidth = 5,
  }) {
    final segCount = math.min(track.length, samples.length) - 1;
    if (segCount <= 0) return const [];

    // min/max mpg
    double minMpg = samples.first.mpg, maxMpg = samples.first.mpg;
    for (final s in samples) {
      if (s.mpg < minMpg) minMpg = s.mpg;
      if (s.mpg > maxMpg) maxMpg = s.mpg;
    }
    final range = (maxMpg - minMpg).abs();
    const eps = 1e-9;

    Color lerp3(Color a, Color b, Color c, double t) {
      if (t < 0.5) {
        // Interpolate between a and b in [0, 0.5]
        return Color.lerp(a, b, t * 2)!;
      } else {
        // Interpolate between b and c in [0.5, 1]
        return Color.lerp(b, c, (t - 0.5) * 2)!;
      }
    }

    Color colorFor(double mpg) {
      final t = range < eps ? 0.5 : ((mpg - minMpg) / range).clamp(0.0, 1.0);
      return lerp3(Colors.green, Colors.yellow, Colors.red, t);
    }

    final segments = <Polyline>[];
    for (int i = 0; i < segCount; i++) {
      final mpgAvg = (samples[i].mpg + samples[i + 1].mpg) / 2.0;
      segments.add(Polyline(
        points: [track[i], track[i + 1]],
        strokeWidth: strokeWidth,
        color: colorFor(mpgAvg),
      ));
    }
    return segments;
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_error != null) return Center(child: Text('Error: $_error'));
    return CustomScaffold(
      title: 'Map',
      currentIndex: 2,
      body: FlutterMap(
        mapController: _map,
        options: const MapOptions(
          initialCenter: LatLng(48.8566, 2.3522), // Paris fallback
          initialZoom: 12,
        ),
        children: [
          TileLayer(
            urlTemplate:
                'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png',
            subdomains: const ['a', 'b', 'c', 'd'],
            userAgentPackageName: 'com.example.app',
          ),
          PolylineLayer(polylines: _coloredSegments),
          if (_from != null)
            MarkerLayer(markers: [
              Marker(
                  point: _from!,
                  width: 40,
                  height: 40,
                  child: const Icon(Icons.location_on)),
              if (_to != null)
                Marker(
                    point: _to!,
                    width: 40,
                    height: 40,
                    child: const Icon(Icons.flag)),
            ]),
        ],
      ),
    );
  }
}
