import '../../../spot/domain/entities/spot.dart';
import '../../domain/entities/city.dart';
import '../../domain/repositories/discover_repository.dart';
import '../datasources/discover_seed_data.dart';

class DiscoverRepositoryImpl implements DiscoverRepository {
  const DiscoverRepositoryImpl({
    List<City>? cities,
    List<Spot>? spots,
  })  : _cities = cities ?? DiscoverSeedData.cities,
        _spots = spots ?? DiscoverSeedData.spots;

  final List<City> _cities;
  final List<Spot> _spots;

  @override
  List<City> getTrendingCities() => _cities;

  @override
  List<City> searchCities(String query) {
    final q = query.trim().toLowerCase();
    if (q.isEmpty) return getTrendingCities();
    return _cities
        .where(
          (c) =>
              c.name.toLowerCase().contains(q) ||
              c.country.toLowerCase().contains(q) ||
              c.id.contains(q),
        )
        .toList();
  }

  @override
  City? getCityById(String id) {
    try {
      return _cities.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  List<Spot> getSpots({required String cityId, SpotCategory? category}) {
    var list =
        _spots.where((s) => s.cityId == cityId).toList()
          ..sort((a, b) => b.popularityScore.compareTo(a.popularityScore));
    if (category != null) {
      list = list.where((s) => s.category == category).toList();
    }
    return list;
  }

  @override
  List<Spot> getFeaturedSpots({int limit = 6}) {
    final sorted = [..._spots]
      ..sort((a, b) => b.popularityScore.compareTo(a.popularityScore));
    return sorted.take(limit).toList();
  }

  @override
  Spot? getSpotById(String id) {
    try {
      return _spots.firstWhere((s) => s.id == id);
    } catch (_) {
      return null;
    }
  }
}
