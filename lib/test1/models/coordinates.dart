class Coord {
  const Coord({required this.lat, required this.long});

  final double lat;
  final double long;

  static Coord fromJson(Map<String, dynamic> json) {
    return Coord(lat: json['lat'], long: json['lon']);
  }
}
