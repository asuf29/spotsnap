import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app.dart';
import '../../core/theme/app_colors.dart';
import '../../shared/widgets/app_logo.dart';
import 'app_bootstrap.dart';

/// Root widget: shows branded loader until [AppBootstrap] finishes.
class BootstrapApp extends StatefulWidget {
  const BootstrapApp({super.key});

  @override
  State<BootstrapApp> createState() => _BootstrapAppState();
}

class _BootstrapAppState extends State<BootstrapApp> {
  AppBootstrapResult? _bootstrap;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    try {
      final result = await AppBootstrap.load();
      if (mounted) setState(() => _bootstrap = result);
    } catch (e) {
      if (mounted) setState(() => _error = e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text('Failed to start app: $_error'),
            ),
          ),
        ),
      );
    }

    if (_bootstrap == null) {
      return const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: _BootstrapLoadingPage(),
      );
    }

    return ProviderScope(
      overrides: _bootstrap!.overrides,
      child: const SnapSpotApp(),
    );
  }
}

class _BootstrapLoadingPage extends StatelessWidget {
  const _BootstrapLoadingPage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.black,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppLogo(size: 48, showTagline: true),
            SizedBox(height: 32),
            SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.gold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
