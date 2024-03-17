import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather/models/coordinates.dart';

void main() {
  test('Coordinates', () {
    const Coord coord = Coord(lat: 100, long: -100);
    expect(coord.lat, 100);
    expect(coord.long, -100);
  });
}
