import '../../../discover/data/datasources/discover_seed_data.dart';
import '../../../spot/domain/entities/spot.dart';
import '../../domain/entities/route_plan.dart';
import '../../domain/repositories/route_repository.dart';

class RouteRepositoryImpl implements RouteRepository {
  const RouteRepositoryImpl();

  @override
  RoutePlan? generateRoute({
    required List<String> spotIds,
    required bool prioritizeGoldenHour,
  }) {
    if (spotIds.isEmpty) return null;

    final spots = <Spot>[];
    for (final id in spotIds) {
      for (final s in DiscoverSeedData.spots) {
        if (s.id == id) {
          spots.add(s);
          break;
        }
      }
    }

    if (spots.isEmpty) return null;

    final sorted = [...spots];
    if (prioritizeGoldenHour) {
      sorted.sort((a, b) {
        int score(Spot s) {
          if (s.category == SpotCategory.sunset) return 0;
          if (s.bestTimeLabel?.toLowerCase().contains('sunrise') ?? false) {
            return 1;
          }
          if (s.bestTimeLabel?.toLowerCase().contains('morning') ?? false) {
            return 2;
          }
          return 3;
        }
        return score(a).compareTo(score(b));
      });
    } else {
      sorted.sort((a, b) => b.popularityScore.compareTo(a.popularityScore));
    }

    final times = ['06:15', '09:30', '12:00', '15:45', '18:30', '19:42', '21:00'];
    final modes = [TravelMode.walk, TravelMode.metro, TravelMode.walk, TravelMode.rideshare];

    final stops = <RouteStop>[];
    var totalWalk = Duration.zero;

    for (var i = 0; i < sorted.length; i++) {
      final walkDur = Duration(minutes: 8 + (i * 7) % 20);
      if (i < sorted.length - 1) totalWalk += walkDur;

      stops.add(
        RouteStop(
          spot: sorted[i],
          arrivalLabel: times[i % times.length],
          order: i + 1,
          modeToNext: i < sorted.length - 1 ? modes[i % modes.length] : TravelMode.walk,
          durationToNext: i < sorted.length - 1 ? walkDur : Duration.zero,
        ),
      );
    }

    return RoutePlan(
      id: 'route-${DateTime.now().millisecondsSinceEpoch}',
      stops: stops,
      totalWalkTime: totalWalk,
      planDateLabel: 'Today · Optimized shoot day',
    );
  }
}
