class MapsService {
  String buildStaticMapPreview(double lat, double lng) {
    return "https://maps.google.com/?q=$lat,$lng";
  }
}
