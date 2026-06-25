import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/utils/spot_image_urls.dart';
import 'spot_image.dart';

class SpotImageGallery extends StatefulWidget {
  const SpotImageGallery({
    super.key,
    required this.spotId,
    required this.imageUrls,
    this.heroTag,
  });

  final String spotId;
  final List<String> imageUrls;
  final String? heroTag;

  @override
  State<SpotImageGallery> createState() => _SpotImageGalleryState();
}

class _SpotImageGalleryState extends State<SpotImageGallery> {
  late final PageController _controller;
  int _currentPage = 0;

  List<String> get _allImages {
    if (widget.imageUrls.isNotEmpty) return widget.imageUrls;
    return SpotImageUrls.gallery(widget.spotId, count: 4);
  }

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final images = _allImages;

    return Stack(
      fit: StackFit.expand,
      children: [
        PageView.builder(
          controller: _controller,
          onPageChanged: (i) => setState(() => _currentPage = i),
          itemCount: images.length,
          itemBuilder: (context, index) {
            final child = SpotImage(
              imageUrl: images[index],
              fit: BoxFit.cover,
              borderRadius: 0,
            );
            if (index == 0 && widget.heroTag != null) {
              return Hero(tag: widget.heroTag!, child: child);
            }
            return child;
          },
        ),
        if (images.length > 1)
          Positioned(
            bottom: 12,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                images.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: _currentPage == i ? 20 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(3),
                    color: _currentPage == i
                        ? AppColors.gold
                        : AppColors.white.withValues(alpha: 0.5),
                  ),
                ),
              ),
            ),
          ),
        if (images.length > 1)
          Positioned(
            bottom: 40,
            right: AppSpacing.md,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '${_currentPage + 1}/${images.length}',
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
