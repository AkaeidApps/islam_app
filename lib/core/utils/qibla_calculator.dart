import 'dart:math' as math;

class QiblaCalculator {
  static const _kaabaLat = 21.4225;
  static const _kaabaLng = 39.8262;

  /// মক্কার দিকে bearing (degree, 0-360)
  static double bearingTo(double lat, double lng) {
    final lat1 = _deg2rad(lat);
    final lng1 = _deg2rad(lng);
    final lat2 = _deg2rad(_kaabaLat);
    final lng2 = _deg2rad(_kaabaLng);

    final dLng = lng2 - lng1;
    final y = math.sin(dLng) * math.cos(lat2);
    final x = math.cos(lat1) * math.sin(lat2) -
        math.sin(lat1) * math.cos(lat2) * math.cos(dLng);
    final brng = math.atan2(y, x);
    return (_rad2deg(brng) + 360) % 360;
  }

  static double _deg2rad(double d) => d * math.pi / 180.0;
  static double _rad2deg(double r) => r * 180.0 / math.pi;
}