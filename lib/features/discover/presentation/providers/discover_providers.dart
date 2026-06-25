import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../spot/domain/entities/spot.dart';
import '../../domain/entities/city.dart';
import '../../domain/repositories/discover_repository.dart';

enum DiscoverViewMode { reels, grid }

final discoverRepositoryProvider = Provider<DiscoverRepository>(
  (ref) => throw UnimplementedError('Override via AppBootstrap.load()'),
);

final discoverSearchQueryProvider = StateProvider<String>((ref) => '');

final selectedCityIdProvider = StateProvider<String?>((ref) => null);

final selectedCategoryProvider = StateProvider<SpotCategory?>((ref) => null);

final discoverViewModeProvider = StateProvider<DiscoverViewMode>(
  (ref) => DiscoverViewMode.reels,
);

final citySearchResultsProvider = Provider<List<City>>((ref) {
  final query = ref.watch(discoverSearchQueryProvider);
  return ref.watch(discoverRepositoryProvider).searchCities(query);
});

final selectedCityProvider = Provider<City?>((ref) {
  final cityId = ref.watch(selectedCityIdProvider);
  if (cityId == null) return null;
  return ref.watch(discoverRepositoryProvider).getCityById(cityId);
});

final discoverSpotsProvider = Provider<List<Spot>>((ref) {
  final cityId = ref.watch(selectedCityIdProvider);
  final category = ref.watch(selectedCategoryProvider);
  if (cityId == null) return [];
  return ref.watch(discoverRepositoryProvider).getSpots(
        cityId: cityId,
        category: category,
      );
});

final featuredSpotsProvider = Provider<List<Spot>>((ref) {
  return ref.watch(discoverRepositoryProvider).getFeaturedSpots();
});

final spotByIdProvider = Provider.family<Spot?, String>((ref, id) {
  return ref.watch(discoverRepositoryProvider).getSpotById(id);
});

void selectCity(WidgetRef ref, String cityId) {
  ref.read(selectedCityIdProvider.notifier).state = cityId;
  ref.read(selectedCategoryProvider.notifier).state = null;
  ref.read(discoverSearchQueryProvider.notifier).state = '';
}

void clearSelectedCity(WidgetRef ref) {
  ref.read(selectedCityIdProvider.notifier).state = null;
  ref.read(selectedCategoryProvider.notifier).state = null;
}
