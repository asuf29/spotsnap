import '../../../../core/network/api_client.dart';
import '../../../spot/domain/entities/spot.dart';
import '../../domain/entities/city.dart';
import '../dto/discover_dto.dart';

class DiscoverRemoteDataSource {
  const DiscoverRemoteDataSource(this._client);

  final ApiClient _client;

  Future<List<City>> fetchCities() async {
    final json = await _client.getJson('cities');
    final list = json['cities'] as List<dynamic>? ?? [];
    return list
        .map((e) => CityDto.fromJson(e as Map<String, dynamic>).toEntity())
        .toList();
  }

  Future<List<Spot>> fetchSpots() async {
    final json = await _client.getJson('spots');
    final list = json['spots'] as List<dynamic>? ?? [];
    return list
        .map((e) => SpotDto.fromJson(e as Map<String, dynamic>).toEntity())
        .toList();
  }
}
