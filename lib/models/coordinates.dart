import 'package:isar/isar.dart';

part 'coordinates.g.dart';

@embedded
class Coord {
  const Coord({this.lat, this.long});

  final double? lat;
  final double? long;

  static Coord fromJson(Map<String, dynamic> json) {
    return Coord(lat: json['lat'], long: json['lon']);
  }
}
