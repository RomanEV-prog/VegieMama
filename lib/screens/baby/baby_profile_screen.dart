import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_spacing.dart';
import '../../core/helpers/date_helper.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/loading_state.dart';
import '../../core/widgets/veggie_mama_app_bar.dart';
import '../../models/baby_profile_model.dart';
import '../../providers/baby_provider.dart';
import '../../providers/user_provider.dart';
import 'widgets/baby_stage_card.dart';
import 'widgets/child_disclaimer.dart';

class BabyProfileScreen extends StatefulWidget {
  const BabyProfileScreen({super.key});

  @override
  State<BabyProfileScreen> createState() => _BabyProfileScreenState();
}

class _BabyProfileScreenState extends State<BabyProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) return;
      final babyProvider = context.read<BabyProvider>();
      if (babyProvider.baby == null && !babyProvider.isLoading) {
        await babyProvider.load();
      }
      // Create the profile from the user's birth date on first visit.
      if (!mounted) return;
      final birthDate = context.read<UserProvider>().user?.birthDate;
      if (babyProvider.baby == null && birthDate != null) {
        await babyProvider.ensureBaby(birthDate);
      }
    });
  }

  Future<void> _editName(BuildContext context, BabyProfileModel baby) async {
    final controller = TextEditingController(text: baby.name);
    final name = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Ime otroka'),
        content: TextField(
          controller: controller,
          autofocus: true,
          textCapitalization: TextCapitalization.words,
          decoration: const InputDecoration(hintText: 'Kako je malčku ime?'),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Prekliči'),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.of(dialogContext).pop(controller.text.trim()),
            child: const Text('Shrani'),
          ),
        ],
      ),
    );
    if (name != null && context.mounted) {
      await context.read<BabyProvider>().saveBaby(baby.copyWith(name: name));
    }
  }

  Future<void> _editAllergies(
      BuildContext context, BabyProfileModel baby) async {
    final controller =
        TextEditingController(text: baby.allergies.join(', '));
    final value = await showDialog<String>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Alergije in občutljivosti'),
        content: TextField(
          controller: controller,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'npr. soja, gluten (loči z vejico)',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Prekliči'),
          ),
          FilledButton(
            onPressed: () =>
                Navigator.of(dialogContext).pop(controller.text),
            child: const Text('Shrani'),
          ),
        ],
      ),
    );
    if (value != null && context.mounted) {
      final allergies = value
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();
      await context
          .read<BabyProvider>()
          .saveBaby(baby.copyWith(allergies: allergies));
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<BabyProvider>();
    final baby = provider.baby;

    return Scaffold(
      appBar: const VeggieMamaAppBar(title: 'Tvoj otrok', showBack: true),
      body: Builder(
        builder: (context) {
          if (provider.isLoading && baby == null) {
            return const LoadingState(message: 'Samo trenutek... 🌿');
          }
          if (baby == null) {
            return const EmptyState(
              message:
                  'Za profil otroka najprej v profilu nastavi datum rojstva 💚',
              icon: Icons.child_care_outlined,
            );
          }

          return ListView(
            padding: const EdgeInsets.all(AppSpacing.screenPadding),
            children: [
              // Header
              Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor:
                        AppColors.lavender.withValues(alpha: 0.3),
                    child: const Text('🧸', style: TextStyle(fontSize: 28)),
                  ),
                  const SizedBox(width: AppSpacing.lg),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          baby.name.isEmpty ? 'Tvoj malček' : baby.name,
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          DateHelper.babyAgeDisplay(baby.birthDate),
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium
                              ?.copyWith(color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit_outlined,
                        color: AppColors.textSecondary),
                    tooltip: 'Uredi ime',
                    onPressed: () => _editName(context, baby),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),

              BabyStageCard(baby: baby),
              const SizedBox(height: AppSpacing.md),

              // Food guide entry
              Card(
                margin: EdgeInsets.zero,
                child: ListTile(
                  leading: const Text('🥄', style: TextStyle(fontSize: 24)),
                  title: const Text('Vodnik uvajanja hrane'),
                  subtitle: Text(
                    provider.foodGuide.isEmpty
                        ? 'Živila po starosti, prilagojena rastlinski prehrani'
                        : '${provider.introducedCount} od ${provider.foodGuide.length} živil že uvedenih',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  trailing: const Icon(Icons.chevron_right,
                      color: AppColors.textLight),
                  onTap: () => context.push('/baby/food-guide'),
                ),
              ),
              const SizedBox(height: AppSpacing.md),

              // Allergies
              Card(
                margin: EdgeInsets.zero,
                child: ListTile(
                  leading: const Icon(Icons.health_and_safety_outlined,
                      color: AppColors.warning),
                  title: const Text('Alergije in občutljivosti'),
                  subtitle: Text(
                    baby.allergies.isEmpty
                        ? 'Ni zabeleženih — dodaš lahko kadar koli'
                        : baby.allergies.join(', '),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                  ),
                  trailing: const Icon(Icons.edit_outlined,
                      size: 18, color: AppColors.textLight),
                  onTap: () => _editAllergies(context, baby),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),

              const ChildDisclaimer(),
            ],
          );
        },
      ),
    );
  }
}
