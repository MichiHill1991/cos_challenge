import 'package:cos_challenge/utils/color.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TermsOfUseWidget extends StatelessWidget {
  final bool checked;
  final ValueChanged<bool?>? onChange;

  const TermsOfUseWidget({
    super.key,
    required this.checked,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    final defaultStyle = theme.textTheme.bodyLarge?.copyWith(
      color: theme.colorScheme.onSurface,
    );
    final linkStyle = defaultStyle?.copyWith(
      color: BrandColors.lila,
      fontWeight: FontWeight.bold,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(value: checked, onChanged: onChange),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 13),
            child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                style: defaultStyle,
                children: [
                  TextSpan(text: loc.termsOfUse01),
                  TextSpan(
                    text: loc.termsOfUse02,
                    style: linkStyle,
                    recognizer: _getTermsAndConditionsRecognizer(),
                  ),
                  TextSpan(text: loc.termsOfUse03),
                  TextSpan(
                    text: loc.termsOfUse04,
                    style: linkStyle,
                    recognizer: _getPrivacyPolicyRecognizer(),
                  ),
                  TextSpan(text: loc.termsOfUse05),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  TapGestureRecognizer _getTermsAndConditionsRecognizer() {
    return TapGestureRecognizer()..onTap = _launchTermsAndConditions;
  }

  TapGestureRecognizer _getPrivacyPolicyRecognizer() {
    return TapGestureRecognizer()..onTap = _launchPrivacyPolicy;
  }

  void _launchTermsAndConditions() {
    // TODO: Launch URL or Navigator
  }

  void _launchPrivacyPolicy() {
    // TODO: Launch URL or Navigator
  }
}
