import '../../../../core/network/api_client.dart';
import '../domain/repositories/discover_repository.dart';
import 'datasources/discover_remote_datasource.dart';
import 'datasources/discover_seed_data.dart';
import 'repositories/discover_repository_impl.dart';

class DiscoverBootstrap {
  DiscoverBootstrap._();

  static Future<DiscoverRepository> create({ApiClient? client}) async {
    final api = client ?? ApiClient();
    try {
      final remote = DiscoverRemoteDataSource(api);
      final cities = await remote.fetchCities();
      final spots = await remote.fetchSpots();
      if (cities.isEmpty || spots.isEmpty) {
        return const DiscoverRepositoryImpl();
      }
      return DiscoverRepositoryImpl(cities: cities, spots: spots);
    } catch (_) {
      return const DiscoverRepositoryImpl();
    }
  }

  static DiscoverRepository seedFallback() => DiscoverRepositoryImpl(
        cities: DiscoverSeedData.cities,
        spots: DiscoverSeedData.spots,
      );
}
