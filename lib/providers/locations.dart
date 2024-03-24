import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather/models/location.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

final locationsProvider =
    StateNotifierProvider<LocationsProvider, List<Location>>(
  (_) => LocationsProvider(),
);

class LocationsProvider extends StateNotifier<List<Location>> {
  LocationsProvider() : super([]) {
    _init();
  }

  Isar? _isar;

  Future<void> _init() async {
    final dir = await getApplicationSupportDirectory();
    final isar = await Isar.open([LocationSchema], directory: dir.path);
    _isar = isar;
    state = await isar.locations.where().findAll();
  }

  Future<void> addLocation(Location location) async {
    final isar = _isar;
    if (isar == null) return;

    await isar.writeTxn(() async {
      await isar.locations.put(location);
    });
    state = [...state, location];
  }

  Future<bool> removeLocation(Location location) async {
    final isar = _isar;
    if (isar == null) return false;

    final success = await isar.locations.delete(location.id);
    if (success) {
      final tempState = [...state];
      final index = tempState.indexWhere((e) => e.id == location.id);
      if (index == -1) return success;
      tempState.removeAt(index);
      state = tempState;
    }

    return true;
  }
}
