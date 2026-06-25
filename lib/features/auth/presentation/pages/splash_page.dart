import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_logo.dart';
import '../providers/auth_providers.dart';

class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 2000), _navigateNext);
  }

  void _navigateNext() {
    if (!mounted) return;
    final auth = ref.read(authSessionProvider);

    if (!auth.hasCompletedOnboarding) {
      context.go(AppRoutes.onboarding);
    } else if (!auth.isAuthenticated) {
      context.go(AppRoutes.login);
    } else {
      context.go(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Center(
        child: const AppLogo(size: 56, showTagline: true)
            .animate()
            .fadeIn(duration: 600.ms, curve: Curves.easeOut)
            .scale(
              begin: const Offset(0.9, 0.9),
              end: const Offset(1, 1),
              duration: 800.ms,
              curve: Curves.easeOutCubic,
            ),
      ),
    );
  }
}
