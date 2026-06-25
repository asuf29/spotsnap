enum SpotCategory {
  popular,
  hiddenGem,
  sunset,
  cafe,
  rooftop,
  beach,
}

enum CrowdLevel { low, medium, high }

enum VibeTag {
  viral,
  oldMoney,
  cleanGirl,
  pinterestGirl,
  travelInfluencer,
}

class Spot {
  const Spot({
    required this.id,
    required this.name,
    required this.cityId,
    required this.category,
    required this.imageUrls,
    this.bestTimeLabel,
    this.crowd = CrowdLevel.medium,
    this.vibes = const [],
    this.popularityScore = 0,
  });

  final String id;
  final String name;
  final String cityId;
  final SpotCategory category;
  final List<String> imageUrls;
  final String? bestTimeLabel;
  final CrowdLevel crowd;
  final List<VibeTag> vibes;
  final double popularityScore;
}
