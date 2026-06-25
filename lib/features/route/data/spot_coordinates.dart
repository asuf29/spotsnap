import 'package:latlong2/latlong.dart';

/// Approximate coordinates for seed spots (map display).
class SpotCoordinates {
  SpotCoordinates._();

  static const _coords = <String, LatLng>{
    'paris-eiffel': LatLng(48.8584, 2.2945),
    'paris-marais': LatLng(48.8606, 2.3622),
    'paris-rooftop': LatLng(48.8738, 2.2950),
    'paris-seine': LatLng(48.8600, 2.3266),
    'paris-montmartre': LatLng(48.8867, 2.3431),
    'paris-louvre': LatLng(48.8606, 2.3376),
    'paris-pont': LatLng(48.8638, 2.3135),
    'paris-passy': LatLng(48.8570, 2.2750),
    'seoul-hanriver': LatLng(37.5283, 126.9325),
    'seoul-gangnam': LatLng(37.4979, 127.0276),
    'seoul-cafe': LatLng(37.5445, 127.0557),
    'seoul-rooftop': LatLng(37.5344, 126.9944),
    'seoul-bukchon': LatLng(37.5826, 126.9831),
    'seoul-ddp': LatLng(37.5665, 127.0090),
    'istanbul-galata': LatLng(41.0257, 28.9744),
    'istanbul-bosphorus': LatLng(41.0391, 29.0094),
    'istanbul-balat': LatLng(41.0311, 28.9497),
    'istanbul-cafe': LatLng(41.0255, 28.9742),
    'istanbul-rooftop': LatLng(41.0086, 28.9802),
    'istanbul-princes': LatLng(40.8740, 29.0940),
    'tokyo-shibuya': LatLng(35.6595, 139.7004),
    'tokyo-shinjuku': LatLng(35.6938, 139.7034),
    'tokyo-teamLab': LatLng(35.6492, 139.7897),
    'tokyo-cafe': LatLng(35.6658, 139.7126),
    'tokyo-roppongi': LatLng(35.6605, 139.7292),
    'tokyo-odaiba': LatLng(35.6300, 139.7753),
    'santorini-oia': LatLng(36.4618, 25.3753),
    'santorini-fira': LatLng(36.4167, 25.4312),
    'santorini-beach': LatLng(36.3489, 25.3962),
    'santorini-cafe': LatLng(36.4296, 25.4262),
    'santorini-hidden': LatLng(36.3805, 25.4482),
  };

  static LatLng? forSpot(String spotId) => _coords[spotId];

  static List<LatLng> forRoute(List<String> spotIds) {
    return spotIds
        .map(forSpot)
        .whereType<LatLng>()
        .toList();
  }
}
