import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../features/notifications/presentation/providers/notification_providers.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/providers/locale_provider.dart';
import '../../../../shared/providers/theme_mode_provider.dart';
import '../../../auth/presentation/providers/auth_providers.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final l10n = AppLocalizations.of(context)!;
    final themeMode = ref.watch(themeModeProvider);
    final locale = ref.watch(localeProvider);
    final notificationsOn = ref.watch(notificationsEnabledProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.settings)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.darkMode),
            activeThumbColor: AppColors.gold,
            value: themeMode == ThemeMode.dark,
            onChanged: (value) {
              ref.read(themeModeProvider.notifier).setMode(
                    value ? ThemeMode.dark : ThemeMode.light,
                  );
            },
          ),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.goldenHourAlerts),
            subtitle: Text(l10n.goldenHourAlertsSubtitle),
            activeThumbColor: AppColors.gold,
            value: notificationsOn,
            onChanged: (value) async {
              final service = ref.read(notificationServiceProvider);
              if (value) {
                await service.requestPermissionAndEnable();
              } else {
                await service.disable();
              }
              ref.invalidate(notificationsEnabledProvider);
            },
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              Icons.language_rounded,
              color: isDark
                  ? AppColors.textMutedOnDark
                  : AppColors.textSecondary,
            ),
            title: Text(l10n.language),
            subtitle: Text(
              locale?.languageCode == 'tr'
                  ? l10n.languageTurkish
                  : l10n.languageEnglish,
            ),
            trailing: const Icon(Icons.chevron_right, size: 20),
            onTap: () => _pickLanguage(context, ref),
          ),
          Divider(
            height: AppSpacing.lg,
            color: isDark ? AppColors.darkDivider : AppColors.beige,
          ),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: Icon(
              Icons.logout_rounded,
              color: theme.colorScheme.error,
            ),
            title: Text(
              l10n.signOut,
              style: TextStyle(color: theme.colorScheme.error),
            ),
            trailing: Icon(
              Icons.chevron_right,
              size: 20,
              color: theme.colorScheme.error,
            ),
            onTap: () async {
              await ref.read(authSessionProvider.notifier).signOut();
              if (context.mounted) context.go(AppRoutes.login);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _pickLanguage(BuildContext context, WidgetRef ref) async {
    final picked = await showModalBottomSheet<String>(
      context: context,
      builder: (ctx) {
        final sheetL10n = AppLocalizations.of(ctx)!;
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text(sheetL10n.languageEnglish),
                onTap: () => Navigator.pop(ctx, 'en'),
              ),
              ListTile(
                title: Text(sheetL10n.languageTurkish),
                onTap: () => Navigator.pop(ctx, 'tr'),
              ),
            ],
          ),
        );
      },
    );
    if (picked != null) {
      await ref.read(localeProvider.notifier).setLocale(Locale(picked));
    }
  }
}
