import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/onboarding_page.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/create/presentation/pages/create_page.dart';
import '../../features/outfit/presentation/pages/outfit_planner_page.dart';
import '../../features/photo_assistant/presentation/pages/photo_assistant_page.dart';
import '../../features/pose/presentation/pages/pose_assistant_page.dart';
import '../../features/discover/presentation/pages/discover_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/plan/presentation/pages/plan_page.dart';
import '../../features/profile/presentation/pages/profile_page.dart';
import '../../features/profile/presentation/pages/settings_page.dart';
import '../../features/social/presentation/pages/bucket_list_page.dart';
import '../../features/social/presentation/pages/favorites_page.dart';
import '../../features/social/presentation/pages/moodboard_detail_page.dart';
import '../../features/social/presentation/pages/moodboards_page.dart';
import '../../features/social/presentation/pages/saved_cities_page.dart';
import '../../features/social/presentation/pages/submit_spot_page.dart';
import '../../features/spot/presentation/pages/spot_detail_page.dart';
import '../../features/subscription/presentation/pages/premium_page.dart';
import '../../shared/widgets/main_shell.dart';
import 'app_routes.dart';
import 'page_transitions.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.spotDetail,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return SlideUpTransitionPage(
            key: state.pageKey,
            child: SpotDetailPage(spotId: id),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.poseAssistant,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => FadeScaleTransitionPage(
          key: state.pageKey,
          child: const PoseAssistantPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.outfitPlanner,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => FadeScaleTransitionPage(
          key: state.pageKey,
          child: const OutfitPlannerPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.photoAssistant,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => FadeScaleTransitionPage(
          key: state.pageKey,
          child: const PhotoAssistantPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.favorites,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => FadeScaleTransitionPage(
          key: state.pageKey,
          child: const FavoritesPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.bucketList,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => FadeScaleTransitionPage(
          key: state.pageKey,
          child: const BucketListPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.savedCities,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => FadeScaleTransitionPage(
          key: state.pageKey,
          child: const SavedCitiesPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.moodboards,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => FadeScaleTransitionPage(
          key: state.pageKey,
          child: const MoodboardsPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.moodboardDetail,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) {
          final id = state.pathParameters['id'] ?? '';
          return FadeScaleTransitionPage(
            key: state.pageKey,
            child: MoodboardDetailPage(moodboardId: id),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.submitSpot,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => FadeScaleTransitionPage(
          key: state.pageKey,
          child: const SubmitSpotPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.premium,
        parentNavigatorKey: _rootNavigatorKey,
        pageBuilder: (context, state) => SlideUpTransitionPage(
          key: state.pageKey,
          child: const PremiumPage(),
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.home,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: HomePage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.discover,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: DiscoverPage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.plan,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: PlanPage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.create,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: CreatePage(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoutes.profile,
                pageBuilder: (context, state) => const NoTransitionPage(
                  child: ProfilePage(),
                ),
                routes: [
                  GoRoute(
                    path: 'settings',
                    parentNavigatorKey: _rootNavigatorKey,
                    pageBuilder: (context, state) => FadeScaleTransitionPage(
                      key: state.pageKey,
                      child: const SettingsPage(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
