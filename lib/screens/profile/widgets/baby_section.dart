import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/helpers/date_helper.dart';
import '../../../models/user_model.dart';
import '../../../providers/baby_provider.dart';
import '../../../providers/user_provider.dart';
import '../../../widgets/section_title.dart';

/// Entry into the child's profile — shown only for moms with a child.
class BabySection extends StatelessWidget {
  const BabySection({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    final hasChild = user?.userType == UserType.babyMom ||
        user?.userType == UserType.toddlerMom ||
        user?.userType == UserType.postpartum;
    if (!hasChild) return const SizedBox.shrink();

    final baby = context.watch<BabyProvider>().baby;
    final introduced = context.watch<BabyProvider>().introducedCount;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle(title: 'Tvoj otrok'),
        Card(
          margin: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenPadding,
          ),
          child: ListTile(
            leading: const Text('🧸', style: TextStyle(fontSize: 24)),
            title: Text(
              (baby?.name.isNotEmpty ?? false) ? baby!.name : 'Profil otroka',
            ),
            subtitle: Text(
              baby != null
                  ? '${DateHelper.babyAgeDisplay(baby.birthDate)}'
                      '${introduced > 0 ? ' · $introduced uvedenih živil' : ''}'
                  : 'Starost, uvajanje hrane in nežni vodnik',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: AppColors.textSecondary,
                  ),
            ),
            trailing:
                const Icon(Icons.chevron_right, color: AppColors.textLight),
            onTap: () => context.push('/baby'),
          ),
        ),
      ],
    );
  }
}
