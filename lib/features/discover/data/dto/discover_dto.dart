import '../../../spot/domain/entities/spot.dart';
import '../../domain/entities/city.dart';

class CityDto {
  CityDto({
    required this.id,
    required this.name,
    required this.country,
    required this.tagline,
    required this.spotCount,
  });

  factory CityDto.fromJson(Map<String, dynamic> json) => CityDto(
        id: json['id'] as String,
        name: json['name'] as String,
        country: json['country'] as String,
        tagline: json['tagline'] as String,
        spotCount: (json['spotCount'] as num?)?.toInt() ?? 0,
      );

  final String id;
  final String name;
  final String country;
  final String tagline;
  final int spotCount;

  City toEntity() => City(
        id: id,
        name: name,
        country: country,
        tagline: tagline,
        spotCount: spotCount,
      );
}

class SpotDto {
  SpotDto({
    required this.id,
    required this.name,
    required this.cityId,
    required this.category,
    required this.bestTimeLabel,
    required this.crowd,
    required this.vibes,
    required this.popularityScore,
    this.imageUrls = const [],
  });

  factory SpotDto.fromJson(Map<String, dynamic> json) => SpotDto(
        id: json['id'] as String,
        name: json['name'] as String,
        cityId: json['cityId'] as String,
        category: json['category'] as String,
        bestTimeLabel: json['bestTimeLabel'] as String?,
        crowd: json['crowd'] as String? ?? 'medium',
        vibes: (json['vibes'] as List<dynamic>? ?? []).cast<String>(),
        popularityScore: (json['popularityScore'] as num?)?.toDouble() ?? 0,
        imageUrls: (json['imageUrls'] as List<dynamic>? ?? []).cast<String>(),
      );

  final String id;
  final String name;
  final String cityId;
  final String category;
  final String? bestTimeLabel;
  final String crowd;
  final List<String> vibes;
  final double popularityScore;
  final List<String> imageUrls;

  Spot toEntity() => Spot(
        id: id,
        name: name,
        cityId: cityId,
        category: _parseCategory(category),
        imageUrls: imageUrls,
        bestTimeLabel: bestTimeLabel,
        crowd: _parseCrowd(crowd),
        vibes: vibes.map(_parseVibe).toList(),
        popularityScore: popularityScore,
      );

  static SpotCategory _parseCategory(String value) =>
      SpotCategory.values.firstWhere(
        (e) => e.name == value,
        orElse: () => SpotCategory.popular,
      );

  static CrowdLevel _parseCrowd(String value) => CrowdLevel.values.firstWhere(
        (e) => e.name == value,
        orElse: () => CrowdLevel.medium,
      );

  static VibeTag _parseVibe(String value) => VibeTag.values.firstWhere(
        (e) => e.name == value,
        orElse: () => VibeTag.viral,
      );
}
