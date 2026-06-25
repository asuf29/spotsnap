// Run: dart run tool/generate_mock_api.dart
import 'dart:convert';
import 'dart:io';

void main() {
  final cities = [
    {'id': 'paris', 'name': 'Paris', 'country': 'France', 'tagline': 'Romantic rooftops & cafe aesthetics', 'spotCount': 8},
    {'id': 'seoul', 'name': 'Seoul', 'country': 'South Korea', 'tagline': 'Neon streets & clean girl cafes', 'spotCount': 6},
    {'id': 'istanbul', 'name': 'İstanbul', 'country': 'Türkiye', 'tagline': 'Bosphorus sunsets & old city vibes', 'spotCount': 6},
    {'id': 'tokyo', 'name': 'Tokyo', 'country': 'Japan', 'tagline': 'Streetwear nights & hidden alleys', 'spotCount': 6},
    {'id': 'santorini', 'name': 'Santorini', 'country': 'Greece', 'tagline': 'White-blue dream shots', 'spotCount': 5},
  ];

  final spots = [
    _spot('paris-eiffel', 'Eiffel Viewpoint', 'paris', 'sunset', 'Sunset 19:42', 'medium', ['viral', 'travelInfluencer'], 98),
    _spot('paris-marais', 'Le Marais Cafe', 'paris', 'cafe', 'Morning 09:00', 'low', ['cleanGirl'], 85),
    _spot('paris-rooftop', 'Galeries Rooftop', 'paris', 'rooftop', 'Golden 18:15', 'high', ['oldMoney'], 91),
    _spot('paris-seine', 'Seine River Walk', 'paris', 'popular', 'Blue hour 20:10', 'medium', ['pinterestGirl'], 88),
    _spot('paris-montmartre', 'Montmartre Steps', 'paris', 'hiddenGem', 'Morning 08:30', 'low', ['pinterestGirl'], 79),
    _spot('paris-louvre', 'Louvre Pyramid', 'paris', 'popular', 'Night 21:00', 'high', ['viral'], 95),
    _spot('paris-pont', 'Pont Alexandre III', 'paris', 'sunset', 'Sunset 19:20', 'medium', ['oldMoney'], 87),
    _spot('paris-passy', 'Passy Hidden Alley', 'paris', 'hiddenGem', 'Afternoon 15:00', 'low', ['cleanGirl'], 72),
    _spot('seoul-hanriver', 'Han River Park', 'seoul', 'sunset', 'Sunset 19:05', 'medium', ['travelInfluencer'], 90),
    _spot('seoul-gangnam', 'Gangnam Street Crossing', 'seoul', 'popular', 'Night 21:30', 'high', ['viral'], 93),
    _spot('seoul-cafe', 'Seongsu Aesthetic Cafe', 'seoul', 'cafe', 'Morning 10:00', 'low', ['cleanGirl'], 84),
    _spot('seoul-rooftop', 'Itaewon Rooftop Bar', 'seoul', 'rooftop', 'Golden 18:40', 'medium', ['pinterestGirl'], 82),
    _spot('seoul-bukchon', 'Bukchon Hanok Alley', 'seoul', 'hiddenGem', 'Morning 08:00', 'medium', ['oldMoney'], 86),
    _spot('seoul-ddp', 'DDP Futuristic Plaza', 'seoul', 'popular', 'Blue hour 20:00', 'high', ['viral'], 89),
    _spot('istanbul-galata', 'Galata Tower View', 'istanbul', 'popular', 'Sunset 19:35', 'high', ['viral', 'travelInfluencer'], 96),
    _spot('istanbul-bosphorus', 'Bosphorus Sunset Pier', 'istanbul', 'sunset', 'Sunset 19:28', 'medium', ['oldMoney'], 92),
    _spot('istanbul-balat', 'Balat Color Street', 'istanbul', 'hiddenGem', 'Morning 09:30', 'low', ['pinterestGirl'], 88),
    _spot('istanbul-cafe', 'Karaköy Third Wave Cafe', 'istanbul', 'cafe', 'Morning 10:00', 'low', ['cleanGirl'], 80),
    _spot('istanbul-rooftop', 'Sultanahmet Rooftop', 'istanbul', 'rooftop', 'Golden 18:50', 'medium', ['travelInfluencer'], 87),
    _spot('istanbul-princes', 'Princes Islands Dock', 'istanbul', 'beach', 'Afternoon 14:00', 'low', ['pinterestGirl'], 81),
    _spot('tokyo-shibuya', 'Shibuya Crossing', 'tokyo', 'popular', 'Night 20:00', 'high', ['viral'], 97),
    _spot('tokyo-shinjuku', 'Shinjuku Neon Alley', 'tokyo', 'popular', 'Night 22:00', 'high', ['travelInfluencer'], 94),
    _spot('tokyo-teamLab', 'TeamLab Borderless', 'tokyo', 'hiddenGem', 'Indoor 11:00', 'medium', ['pinterestGirl'], 90),
    _spot('tokyo-cafe', 'Omotesando Mirror Cafe', 'tokyo', 'cafe', 'Morning 09:00', 'low', ['cleanGirl'], 83),
    _spot('tokyo-roppongi', 'Roppongi Hills Rooftop', 'tokyo', 'rooftop', 'Sunset 18:55', 'medium', ['oldMoney'], 88),
    _spot('tokyo-odaiba', 'Odaiba Beach Boardwalk', 'tokyo', 'beach', 'Sunset 18:40', 'medium', ['travelInfluencer'], 85),
    _spot('santorini-oia', 'Oia Blue Dome', 'santorini', 'sunset', 'Sunset 19:50', 'high', ['viral', 'pinterestGirl'], 99),
    _spot('santorini-fira', 'Fira Cliff Walk', 'santorini', 'popular', 'Golden 18:30', 'medium', ['travelInfluencer'], 92),
    _spot('santorini-beach', 'Red Beach Cove', 'santorini', 'beach', 'Morning 08:00', 'low', ['cleanGirl'], 86),
    _spot('santorini-cafe', 'Imerovigli White Cafe', 'santorini', 'cafe', 'Morning 09:30', 'low', ['oldMoney'], 84),
    _spot('santorini-hidden', 'Pyrgos Hidden Steps', 'santorini', 'hiddenGem', 'Sunrise 06:15', 'low', ['pinterestGirl'], 78),
  ];

  final dir = Directory('assets/mock_api');
  if (!dir.existsSync()) dir.createSync(recursive: true);

  File('assets/mock_api/cities.json').writeAsStringSync(
    const JsonEncoder.withIndent('  ').convert({'cities': cities}),
  );
  File('assets/mock_api/spots.json').writeAsStringSync(
    const JsonEncoder.withIndent('  ').convert({'spots': spots}),
  );
  stdout.writeln('Generated assets/mock_api/cities.json & spots.json');
}

Map<String, dynamic> _spot(
  String id,
  String name,
  String cityId,
  String category,
  String bestTime,
  String crowd,
  List<String> vibes,
  num score,
) {
  final image = 'https://picsum.photos/seed/snapspot-$id/600/800';
  return {
    'id': id,
    'name': name,
    'cityId': cityId,
    'category': category,
    'bestTimeLabel': bestTime,
    'crowd': crowd,
    'vibes': vibes,
    'popularityScore': score,
    'imageUrls': [image],
  };
}
