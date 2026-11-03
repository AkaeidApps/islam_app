import 'package:flutter_compass/flutter_compass.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/location_service.dart';
import '../../../core/utils/qibla_calculator.dart';
import 'telawa_qibla_providers.dart';

class QiblaState {
  final double qiblaBearing;
  final double? deviceHeading;
  final double? lat;
  final double? lng;
  final double? distanceKm; // Distance to Kaaba in km
  const QiblaState({
    required this.qiblaBearing,
    this.deviceHeading,
    this.lat,
    this.lng,
    this.distanceKm,
  });

  QiblaState copyWith({double? deviceHeading, double? distanceKm}) => QiblaState(
    qiblaBearing: qiblaBearing,
    deviceHeading: deviceHeading ?? this.deviceHeading,
    lat: lat,
    lng: lng,
    distanceKm: distanceKm ?? this.distanceKm,
  );
}

final qiblaProvider = StreamProvider.autoDispose<QiblaState>((ref) async* {
  final pos = await LocationService.getCurrentPosition();

  // Use Telawa API for Qibla bearing and distance
  double bearing;
  double? distanceKm;
  try {
    final telawaQibla = await ref.read(telawaQiblaProvider((pos.latitude, pos.longitude)).future);
    bearing = telawaQibla.bearingDegreesFromNorth;
    distanceKm = telawaQibla.distanceKm;
  } catch (e) {
    // Fallback to local calculation if Telawa API fails
    bearing = QiblaCalculator.bearingTo(pos.latitude, pos.longitude);
  }

  var state = QiblaState(
    qiblaBearing: bearing,
    lat: pos.latitude,
    lng: pos.longitude,
    distanceKm: distanceKm,
  );

  await for (final event in FlutterCompass.events ?? const Stream.empty()) {
    state = state.copyWith(deviceHeading: event.heading);
    yield state;
  }
});