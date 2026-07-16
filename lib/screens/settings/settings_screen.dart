import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
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
        title: const Text('Izbrišem tvoje podatke?'),
        content: const Text(
          'Izbrisalo bo profil, dnevne vnose in najljubše recepte. '
          'Tega ni mogoče razveljaviti.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Prekliči'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.error),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: const Text('Izbriši'),
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

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final localeProvider = context.watch<LocaleProvider>();

    return Scaffold(
      appBar: const VeggieMamaAppBar(title: 'Nastavitve', showBack: true),
      body: ListView(
        padding: const EdgeInsets.only(bottom: AppSpacing.xl),
        children: [
          const SectionTitle(title: 'Videz'),
          Card(
            margin: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenPadding,
            ),
            child: Column(
              children: [
                for (final mode in ThemeMode.values)
                  RadioListTile<ThemeMode>(
                    title: Text(_themeLabel(mode)),
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

          const SectionTitle(title: 'Jezik'),
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

          const SectionTitle(title: 'Zasebnost'),
          Card(
            margin: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenPadding,
            ),
            child: ListTile(
              leading: const Icon(Icons.delete_outline, color: AppColors.error),
              title: const Text('Izbriši moje podatke'),
              subtitle: Text(
                'Profil, vnosi in najljubši recepti se izbrišejo s te naprave.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              onTap: () => _confirmDeleteData(context),
            ),
          ),

          const SectionTitle(title: 'O aplikaciji'),
          Card(
            margin: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenPadding,
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.cardPadding),
              child: Text(
                'VeggieMama 1.0\n\n'
                'Aplikacija je v podporo in ne nadomešča nasveta zdravnika, '
                'pediatra ali druge strokovne osebe. Vsi tvoji podatki '
                'ostanejo na tej napravi.',
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
