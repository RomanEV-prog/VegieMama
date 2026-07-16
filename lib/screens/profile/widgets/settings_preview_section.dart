import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../providers/locale_provider.dart';
import '../../../providers/theme_provider.dart';
import '../../../widgets/section_title.dart';

/// Quick glance at key settings with a path into the settings screen.
class SettingsPreviewSection extends StatelessWidget {
  const SettingsPreviewSection({super.key});

  String _themeLabel(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return 'Svetla';
      case ThemeMode.dark:
        return 'Temna';
      case ThemeMode.system:
        return 'Sistemska';
    }
  }

  String _localeLabel(Locale? locale) {
    switch (locale?.languageCode) {
      case 'en':
        return 'English';
      case 'de':
        return 'Deutsch';
      default:
        return 'Slovenščina';
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeMode = context.watch<ThemeProvider>().themeMode;
    final locale = context.watch<LocaleProvider>().locale;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Nastavitve'),
        Card(
          margin: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenPadding,
          ),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.language,
                    color: AppColors.textSecondary),
                title: const Text('Jezik'),
                trailing: Text(
                  _localeLabel(locale),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                onTap: () => context.push('/settings'),
              ),
              ListTile(
                leading: const Icon(Icons.brightness_6_outlined,
                    color: AppColors.textSecondary),
                title: const Text('Tema'),
                trailing: Text(
                  _themeLabel(themeMode),
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppColors.textSecondary,
                      ),
                ),
                onTap: () => context.push('/settings'),
              ),
              ListTile(
                leading: const Icon(Icons.settings_outlined,
                    color: AppColors.textSecondary),
                title: const Text('Vse nastavitve'),
                trailing: const Icon(Icons.chevron_right,
                    color: AppColors.textLight),
                onTap: () => context.push('/settings'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
