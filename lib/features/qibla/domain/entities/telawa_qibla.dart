/// Telawa API Qibla data entity
class TelawaQibla {
  final double bearing;
  final double bearingDegreesFromNorth;
  final double distanceKm;
  final double fromLatitude;
  final double fromLongitude;
  final double kaabaLatitude;
  final double kaabaLongitude;

  const TelawaQibla({
    required this.bearing,
    required this.bearingDegreesFromNorth,
    required this.distanceKm,
    required this.fromLatitude,
    required this.fromLongitude,
    required this.kaabaLatitude,
    required this.kaabaLongitude,
  });
}
