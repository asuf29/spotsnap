import '../entities/route_plan.dart';

abstract class RouteRepository {
  RoutePlan? generateRoute({
    required List<String> spotIds,
    required bool prioritizeGoldenHour,
  });
}
