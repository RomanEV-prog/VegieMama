import 'package:flutter/material.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/helpers/l10n_ext.dart';
import '../../../core/helpers/format_helper.dart';
import '../../../models/user_model.dart';

class OnboardingBasicsStep extends StatelessWidget {
  final UserType userType;
  final String firstName;
  final DateTime? date;
  final ValueChanged<String> onNameChanged;
  final ValueChanged<DateTime> onDateChanged;

  const OnboardingBasicsStep({
    super.key,
    required this.userType,
    required this.firstName,
    required this.date,
    required this.onNameChanged,
    required this.onDateChanged,
  });

  bool get _isPregnant => userType == UserType.pregnant;

  Future<void> _pickDate(BuildContext context) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: date ?? now,
      // PDP can be ~9 months ahead; birth date up to 3 years back.
      firstDate: _isPregnant ? now : now.subtract(const Duration(days: 3 * 365)),
      lastDate: _isPregnant ? now.add(const Duration(days: 290)) : now,
      helpText:
          _isPregnant ? context.l10n.onbDueDate : context.l10n.onbBirthDate,
    );
    if (picked != null) onDateChanged(picked);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.xl),
      children: [
        Text(
          context.l10n.onbBasicsTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          context.l10n.onbBasicsSubtitle,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: AppSpacing.xl),
        TextFormField(
          initialValue: firstName,
          decoration: InputDecoration(
            labelText: context.l10n.onbNameLabel,
            hintText: context.l10n.onbNameHint,
          ),
          textCapitalization: TextCapitalization.words,
          onChanged: onNameChanged,
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(
          _isPregnant ? context.l10n.onbDueDate : context.l10n.onbBirthDate,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        OutlinedButton.icon(
          onPressed: () => _pickDate(context),
          icon: const Icon(Icons.calendar_today_outlined, size: 18),
          label: Text(
            date != null
                ? FormatHelper.shortDate(date!)
                : context.l10n.onbPickDate,
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          _isPregnant
              ? context.l10n.onbDateHelpPregnant
              : context.l10n.onbDateHelpChild,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
