import 'package:brilloconnetz_test/src/core/constants/strings.dart';
import 'package:brilloconnetz_test/src/features/authentication/view_model/verify_email_notifier.dart';
import 'package:brilloconnetz_test/src/general_widgets/app_button.dart';
import 'package:brilloconnetz_test/src/general_widgets/spacing.dart';
import 'package:brilloconnetz_test/src/general_widgets/two_colored_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VerifyEmailView extends ConsumerWidget {
  const VerifyEmailView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 36.0),
          child: Center(
            child: SizedBox(
              width: 500,
              child: Card(
                color: colorScheme.primary.withOpacity(0.1),
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const TwoColoredText(
                        first: 'Brillo',
                        second: 'Connectz',
                        fontSize: 28,
                      ),
                      const Spacing.mediumHeight(),
                      Icon(
                        Icons.mail,
                        size: 36,
                        color: colorScheme.primary,
                      ),
                      const Spacing.bigHeight(),
                      Text(
                        AppStrings.verifyMail,
                        style: textTheme.headline5,
                      ),
                      const Spacing.smallHeight(),
                      Center(
                        child: Text(
                          AppStrings.verifyMailText,
                          textAlign: TextAlign.center,
                          style: textTheme.subtitle2,
                        ),
                      ),
                      const Spacing.bigHeight(),
                      SizedBox(
                        width: 150,
                        child: AppButton(
                          text: AppStrings.goToLogin,
                          onTap: () async => await ref
                              .read(verifyEmailNotifierProvider.notifier)
                              .navigateToLogin(),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
