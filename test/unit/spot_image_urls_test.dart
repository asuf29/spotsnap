import 'package:flutter_test/flutter_test.dart';
import 'package:snapspot/core/utils/spot_image_urls.dart';

void main() {
  group('SpotImageUrls', () {
    test('primary generates deterministic URL', () {
      final url1 = SpotImageUrls.primary('paris-eiffel');
      final url2 = SpotImageUrls.primary('paris-eiffel');
      expect(url1, url2);
      expect(url1, contains('snapspot-paris-eiffel'));
      expect(url1, contains('600/800'));
    });

    test('primary respects custom dimensions', () {
      final url = SpotImageUrls.primary('test', width: 300, height: 400);
      expect(url, contains('300/400'));
    });

    test('gallery generates correct count', () {
      final urls = SpotImageUrls.gallery('test', count: 5);
      expect(urls.length, 5);
    });

    test('gallery URLs are unique', () {
      final urls = SpotImageUrls.gallery('test', count: 4);
      expect(urls.toSet().length, 4);
    });

    test('gallery URLs contain spot ID', () {
      final urls = SpotImageUrls.gallery('istanbul-galata');
      for (final url in urls) {
        expect(url, contains('snapspot-istanbul-galata'));
      }
    });
  });
}
