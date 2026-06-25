import '../../../spot/domain/entities/spot.dart';
import '../entities/city.dart';

abstract class DiscoverRepository {
  List<City> getTrendingCities();

  List<City> searchCities(String query);

  City? getCityById(String id);

  List<Spot> getSpots({
    required String cityId,
    SpotCategory? category,
  });

  List<Spot> getFeaturedSpots({int limit = 6});

  Spot? getSpotById(String id);
}
