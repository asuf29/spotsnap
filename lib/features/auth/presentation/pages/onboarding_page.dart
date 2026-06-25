import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/auth_providers.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final _controller = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<_OnboardingSlide> _slides(AppLocalizations l10n) => [
        _OnboardingSlide(
          title: l10n.onboarding1Title,
          subtitle: l10n.onboarding1Subtitle,
          gradient: [AppColors.pastelBlush, AppColors.beige],
          icon: Icons.location_on_outlined,
        ),
        _OnboardingSlide(
          title: l10n.onboarding2Title,
          subtitle: l10n.onboarding2Subtitle,
          gradient: [AppColors.pastelSage, AppColors.beige],
          icon: Icons.face_retouching_natural_outlined,
        ),
        _OnboardingSlide(
          title: l10n.onboarding3Title,
          subtitle: l10n.onboarding3Subtitle,
          gradient: [AppColors.pastelSky, AppColors.beige],
          icon: Icons.route_outlined,
        ),
      ];

  Future<void> _next() async {
    final slides = _slides(AppLocalizations.of(context)!);
    if (_currentPage < slides.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
      );
    } else {
      await ref.read(authSessionProvider.notifier).completeOnboarding();
      if (mounted) context.go(AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;
    final slides = _slides(l10n);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemCount: slides.length,
                itemBuilder: (context, index) {
                  final slide = slides[index];
                  final gradientColors = isDark
                      ? slide.gradient
                          .map((c) => Color.lerp(c, AppColors.darkCard, 0.7)!)
                          .toList()
                      : slide.gradient;
                  return Padding(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    child: Column(
                      children: [
                        Expanded(
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                AppConstants.cardRadius,
                              ),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: gradientColors,
                              ),
                            ),
                            child: ShaderMask(
                              blendMode: BlendMode.srcIn,
                              shaderCallback: (bounds) =>
                                  AppColors.brandGradient.createShader(bounds),
                              child: Icon(
                                slide.icon,
                                size: 80,
                                color: AppColors.white,
                              ),
                            ),
                          ).animate().fadeIn(duration: 400.ms),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        Text(
                          slide.title,
                          style: theme.textTheme.displayMedium,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: AppSpacing.sm - 4),
                        Text(
                          slide.subtitle,
                          style: theme.textTheme.bodyMedium,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                slides.length,
                (i) => AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == i ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: _currentPage == i
                        ? AppColors.gold
                        : (isDark ? AppColors.darkDivider : AppColors.beige),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _next,
                  child: Text(
                    _currentPage == slides.length - 1
                        ? l10n.getStarted
                        : l10n.continuePage,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () async {
                await ref.read(authSessionProvider.notifier).completeOnboarding();
                if (!context.mounted) return;
                context.go(AppRoutes.login);
              },
              child: Text(l10n.skip),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class _OnboardingSlide {
  const _OnboardingSlide({
    required this.title,
    required this.subtitle,
    required this.gradient,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final List<Color> gradient;
  final IconData icon;
}
