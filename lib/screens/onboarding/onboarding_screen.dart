import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/helpers/l10n_ext.dart';
import '../../models/user_model.dart';
import '../../providers/locale_provider.dart';
import '../../providers/theme_provider.dart';
import '../../providers/user_provider.dart';
import '../../widgets/primary_action_button.dart';
import 'widgets/onboarding_basics_step.dart';
import 'widgets/onboarding_settings_step.dart';
import 'widgets/onboarding_user_type_step.dart';
import 'widgets/onboarding_welcome_step.dart';

/// Gentle multi-step onboarding. Every input except the user type can
/// be skipped — no pressure, sensible defaults.
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  int _step = 0;

  UserType _userType = UserType.pregnant;
  String _firstName = '';
  DateTime? _date; // PDP for pregnancy, birth date otherwise
  bool _saving = false;

  static const _stepCount = 4;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goTo(int step) {
    setState(() => _step = step);
    _pageController.animateToPage(
      step,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
    );
  }

  void _next() {
    if (_step < _stepCount - 1) {
      _goTo(_step + 1);
    } else {
      _finish();
    }
  }

  Future<void> _finish() async {
    if (_saving) return;
    setState(() => _saving = true);

    final isPregnant = _userType == UserType.pregnant;
    final user = UserModel(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      firstName: _firstName.trim().isEmpty ? 'Mamica' : _firstName.trim(),
      lastName: '',
      userType: _userType,
      dueDate: isPregnant ? _date : null,
      birthDate: isPregnant ? null : _date,
      onboardingCompleted: true,
    );
    await context.read<UserProvider>().createUser(user);
    // Router redirect takes over from here.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Progress dots + skip
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPadding,
                vertical: AppSpacing.sm,
              ),
              child: Row(
                children: [
                  for (var i = 0; i < _stepCount; i++)
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOutCubic,
                      margin: const EdgeInsets.only(right: AppSpacing.xs),
                      width: i == _step ? 24 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: i <= _step
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context)
                                .colorScheme
                                .primary
                                .withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  const Spacer(),
                  if (_step > 0 && _step < _stepCount - 1)
                    TextButton(
                      onPressed: _next,
                      child: Text(context.l10n.commonSkip),
                    ),
                ],
              ),
            ),

            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  const OnboardingWelcomeStep(),
                  OnboardingUserTypeStep(
                    selected: _userType,
                    onChanged: (type) => setState(() => _userType = type),
                  ),
                  OnboardingBasicsStep(
                    userType: _userType,
                    firstName: _firstName,
                    date: _date,
                    onNameChanged: (name) => _firstName = name,
                    onDateChanged: (date) => setState(() => _date = date),
                  ),
                  const OnboardingSettingsStep(),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(AppSpacing.screenPadding),
              child: PrimaryActionButton(
                label: _step == 0
                    ? context.l10n.commonStart
                    : (_step == _stepCount - 1
                        ? context.l10n.commonFinish
                        : context.l10n.commonNext),
                isLoading: _saving,
                onPressed: _next,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Exposed for the settings step so it can live in its own file
/// without owning provider wiring.
class OnboardingSettingsControls extends StatelessWidget {
  const OnboardingSettingsControls({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final localeProvider = context.watch<LocaleProvider>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(context.l10n.language,
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          children: [
            for (final (label, code) in [
              ('Slovenščina', 'sl'),
              ('English', 'en'),
              ('Deutsch', 'de'),
            ])
              ChoiceChip(
                label: Text(label),
                selected: localeProvider.locale.languageCode == code,
                onSelected: (_) =>
                    context.read<LocaleProvider>().setLocaleByCode(code),
              ),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(context.l10n.theme,
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: AppSpacing.sm),
        Wrap(
          spacing: AppSpacing.sm,
          children: [
            for (final (label, mode) in [
              (context.l10n.themeLight, ThemeMode.light),
              (context.l10n.themeDark, ThemeMode.dark),
              (context.l10n.themeSystem, ThemeMode.system),
            ])
              ChoiceChip(
                label: Text(label),
                selected: themeProvider.themeMode == mode,
                onSelected: (_) =>
                    context.read<ThemeProvider>().setThemeMode(mode),
              ),
          ],
        ),
      ],
    );
  }
}
