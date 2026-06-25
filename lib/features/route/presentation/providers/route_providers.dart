import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/route_repository_impl.dart';
import '../../domain/entities/route_plan.dart';
import '../../domain/repositories/route_repository.dart';

final routeRepositoryProvider = Provider<RouteRepository>(
  (ref) => const RouteRepositoryImpl(),
);

final selectedRouteSpotIdsProvider = StateProvider<Set<String>>((ref) => {});

final prioritizeGoldenHourProvider = StateProvider<bool>((ref) => true);

final generatedRouteProvider = StateProvider<RoutePlan?>((ref) => null);

void generateRoute(WidgetRef ref) {
  final ids = ref.read(selectedRouteSpotIdsProvider).toList();
  final prioritize = ref.read(prioritizeGoldenHourProvider);
  final plan = ref.read(routeRepositoryProvider).generateRoute(
        spotIds: ids,
        prioritizeGoldenHour: prioritize,
      );
  ref.read(generatedRouteProvider.notifier).state = plan;
}

void toggleRouteSpot(WidgetRef ref, String spotId) {
  final current = Set<String>.from(ref.read(selectedRouteSpotIdsProvider));
  if (current.contains(spotId)) {
    current.remove(spotId);
  } else {
    current.add(spotId);
  }
  ref.read(selectedRouteSpotIdsProvider.notifier).state = current;
}
