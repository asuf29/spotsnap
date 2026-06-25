/// Deterministic placeholder images per spot (Picsum).
class SpotImageUrls {
  SpotImageUrls._();

  static String primary(String spotId, {int width = 600, int height = 800}) {
    return 'https://picsum.photos/seed/snapspot-$spotId/$width/$height';
  }

  static List<String> gallery(String spotId, {int count = 3}) {
    return List.generate(
      count,
      (i) => 'https://picsum.photos/seed/snapspot-$spotId-$i/600/800',
    );
  }
}
