import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import '../../core/router/app_routes.dart';

/// Branch indices for [StatefulShellRoute.indexedStack] in [app_router.dart].
abstract final class ShellBranch {
  static const home = 0;
  static const discover = 1;
  static const plan = 2;
  static const create = 3;
  static const profile = 4;
}

const _shellRoutes = {
  AppRoutes.home,
  AppRoutes.discover,
  AppRoutes.plan,
  AppRoutes.create,
  AppRoutes.profile,
};

/// Exposes the active bottom-nav branch from [MainShell].
class ActiveShellBranch extends InheritedWidget {
  const ActiveShellBranch({
    super.key,
    required this.index,
    required super.child,
  });

  final int index;

  static int of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<ActiveShellBranch>();
    assert(scope != null, 'ActiveShellBranch not found in widget tree');
    return scope!.index;
  }

  @override
  bool updateShouldNotify(ActiveShellBranch oldWidget) =>
      oldWidget.index != index;
}

/// Heroes are only active on the visible shell tab while no overlay route is open.
/// Prevents duplicate hero tags across IndexedStack branches.
bool shellHeroesEnabled(BuildContext context, int branchIndex) {
  if (ActiveShellBranch.of(context) != branchIndex) return false;
  final location = GoRouterState.of(context).matchedLocation;
  return _shellRoutes.contains(location);
}
