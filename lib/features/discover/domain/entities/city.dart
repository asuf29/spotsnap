class City {
  const City({
    required this.id,
    required this.name,
    required this.country,
    required this.tagline,
    this.spotCount = 0,
  });

  final String id;
  final String name;
  final String country;
  final String tagline;
  final int spotCount;
}
