import '../../../../core/utils/spot_image_urls.dart';
import 'spot.dart';

extension SpotImageX on Spot {
  String? get primaryImageUrl =>
      imageUrls.isNotEmpty ? imageUrls.first : SpotImageUrls.primary(id);
}
