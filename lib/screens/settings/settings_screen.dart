import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/helpers/l10n_ext.dart';
import '../../core/widgets/veggie_mama_app_bar.dart';
import '../../providers/locale_provider.dart';
import '../../providers/theme_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/local/preferences_service.dart';
import '../../services/local/storage_service.dart';
import '../../widgets/section_title.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  Future<void> _confirmDeleteData(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(dialogContext.l10n.setDeleteConfirmTitle),
        content: Text(dialogContext.l10n.setDeleteConfirmBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(dialogContext.l10n.commonCancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(dialogContext.l10n.commonDelete),
          ),
        ],
      ),
    );

    if (confirmed != true || !context.mounted) return;

    await StorageService.instance.clearAll();
    if (PreferencesService.instance.isInitialized) {
      await PreferencesService.instance.clearAll();
    }
    if (context.mounted) {
      // Clearing the user triggers the router redirect to onboarding.
      await context.read<UserProvider>().reset();
    }
  }

  String _themeLabel(BuildContext context, ThemeMode mode) {
    switch (mode) {
      case ThemeMode.light:
        return context.l10n.themeLight;
      case ThemeMode.dark:
        return context.l10n.themeDark;
      case ThemeMode.system:
        return context.l10n.themeSystem;
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final localeProvider = context.watch<LocaleProvider>();

    return Scaffold(
      appBar:
          VeggieMamaAppBar(title: context.l10n.titleSettings, showBack: true),
      body: ListView(
        padding: const EdgeInsets.only(bottom: AppSpacing.xl),
        children: [
          SectionTitle(title: context.l10n.setAppearance),
          Card(
            margin: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenPadding,
            ),
            child: Column(
              children: [
                for (final mode in ThemeMode.values)
                  RadioListTile<ThemeMode>(
                    title: Text(_themeLabel(context, mode)),
                    value: mode,
                    groupValue: themeProvider.themeMode,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<ThemeProvider>().setThemeMode(value);
                      }
                    },
                  ),
              ],
            ),
          ),

          SectionTitle(title: context.l10n.language),
          Card(
            margin: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenPadding,
            ),
            child: Column(
              children: [
                for (final (label, code) in [
                  ('Slovenščina', 'sl'),
                  ('English', 'en'),
                  ('Deutsch', 'de'),
                ])
                  RadioListTile<String>(
                    title: Text(label),
                    value: code,
                    groupValue: localeProvider.locale.languageCode,
                    onChanged: (value) {
                      if (value != null) {
                        context.read<LocaleProvider>().setLocaleByCode(value);
                      }
                    },
                  ),
              ],
            ),
          ),

          SectionTitle(title: context.l10n.setPrivacy),
          Card(
            margin: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenPadding,
            ),
            child: ListTile(
              leading: const Icon(Icons.delete_outline, color: AppColors.error),
              title: Text(context.l10n.setDeleteData),
              subtitle: Text(
                context.l10n.setDeleteSubtitle,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              onTap: () => _confirmDeleteData(context),
            ),
          ),

          SectionTitle(title: context.l10n.setAbout),
          Card(
            margin: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenPadding,
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.cardPadding),
              child: Text(
                context.l10n.setAboutText,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
