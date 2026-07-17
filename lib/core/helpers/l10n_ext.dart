import 'package:flutter/widgets.dart';
import '../../l10n/app_localizations.dart';

/// Shorthand: `context.l10n.commonNext` instead of
/// `AppLocalizations.of(context)!.commonNext`.
extension L10nX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}
