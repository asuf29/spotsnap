import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../shared/widgets/empty_state.dart';
import '../../../spot/domain/entities/spot.dart';
import 'discover_reel_page.dart';

class DiscoverReelsView extends StatefulWidget {
  const DiscoverReelsView({super.key, required this.spots});

  final List<Spot> spots;

  @override
  State<DiscoverReelsView> createState() => _DiscoverReelsViewState();
}

class _DiscoverReelsViewState extends State<DiscoverReelsView> {
  late final PageController _controller;

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
    if (widget.spots.isEmpty) {
      return const EmptyState(
        icon: Icons.videocam_off_outlined,
        title: 'No spots yet',
        subtitle: 'Select a city to explore reels.',
      );
    }

    return PageView.builder(
      controller: _controller,
      scrollDirection: Axis.vertical,
      itemCount: widget.spots.length,
      onPageChanged: (_) => HapticFeedback.lightImpact(),
      itemBuilder: (context, index) {
        return DiscoverReelPage(spot: widget.spots[index]);
      },
    );
  }
}
