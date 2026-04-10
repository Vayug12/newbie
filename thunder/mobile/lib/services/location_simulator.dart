import "dart:async";
import "package:google_maps_flutter/google_maps_flutter.dart";

class LocationSimulator {
  static Stream<LatLng> getProviderLocationStream({
    required LatLng start,
    required LatLng end,
    int steps = 20,
    Duration interval = const Duration(seconds: 2),
  }) async* {
    double latStep = (end.latitude - start.latitude) / steps;
    double lngStep = (end.longitude - start.longitude) / steps;

    for (int i = 0; i <= steps; i++) {
      await Future.delayed(interval);
      yield LatLng(
        start.latitude + (latStep * i),
        start.longitude + (lngStep * i),
      );
    }
  }
}
