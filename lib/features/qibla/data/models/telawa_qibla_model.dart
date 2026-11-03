import '../../domain/entities/telawa_qibla.dart';

/// Telawa API Qibla model with JSON parsing
class TelawaQiblaModel extends TelawaQibla {
  const TelawaQiblaModel({
    required super.bearing,
    required super.bearingDegreesFromNorth,
    required super.distanceKm,
    required super.fromLatitude,
    required super.fromLongitude,
    required super.kaabaLatitude,
    required super.kaabaLongitude,
  });

  factory TelawaQiblaModel.fromJson(Map<String, dynamic> json) {
    final from = json['from'] as Map<String, dynamic>;
    final kaaba = json['kaaba'] as Map<String, dynamic>;
    final qibla = json['qibla'] as Map<String, dynamic>;

    return TelawaQiblaModel(
      bearing: (qibla['bearing'] as num).toDouble(),
      bearingDegreesFromNorth: (qibla['bearingDegreesFromNorth'] as num).toDouble(),
      distanceKm: (qibla['distanceKm'] as num).toDouble(),
      fromLatitude: (from['latitude'] as num).toDouble(),
      fromLongitude: (from['longitude'] as num).toDouble(),
      kaabaLatitude: (kaaba['latitude'] as num).toDouble(),
      kaabaLongitude: (kaaba['longitude'] as num).toDouble(),
    );
  }
}
