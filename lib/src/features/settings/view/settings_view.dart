import 'package:brilloconnetz_test/src/core/constants/colors.dart';
import 'package:brilloconnetz_test/src/core/constants/strings.dart';
import 'package:brilloconnetz_test/src/features/settings/view/update_email_view.dart';
import 'package:brilloconnetz_test/src/features/settings/view/update_password_view.dart';
import 'package:brilloconnetz_test/src/features/settings/view/update_user_view.dart';
import 'package:brilloconnetz_test/src/features/settings/view_model/settings_notifier.dart';
import 'package:brilloconnetz_test/src/general_widgets/app_button.dart';
import 'package:brilloconnetz_test/src/general_widgets/dialog.dart';
import 'package:brilloconnetz_test/src/general_widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SettingsView extends ConsumerWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(settingsProvider.notifier).user;
    final height = MediaQuery.of(context).size.height;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SizedBox(
        width: 767,
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacing.height(height * 0.1),
                Text(
                  'Settings',
                  style: textTheme.headline4?.copyWith(
                    color: AppColors.dark,
                  ),
                ),
                const Spacing.bigHeight(),
                ListTile(
                  title: Text(AppStrings.changeUsername,
                      style: textTheme.bodyText1),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => showDialog(
                    context: context,
                    builder: (_) => AppDialog(
                      child: UpdateProfileView(user: user),
                    ),
                  ),
                ),
                const Spacing.bigHeight(),
                const Divider(),
                const Spacing.bigHeight(),
                ListTile(
                  title: Text(
                    AppStrings.changePassword,
                    style: textTheme.bodyText1,
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => showDialog(
                    context: context,
                    builder: (_) => const AppDialog(
                      child: UpdatePasswordView(),
                    ),
                  ),
                ),
                const Spacing.bigHeight(),
                ListTile(
                  title:
                      Text(AppStrings.changeEmail, style: textTheme.bodyText1),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () => showDialog(
                    context: context,
                    builder: (_) => const AppDialog(
                      child: UpdateEmailView(),
                    ),
                  ),
                ),
                const Spacing.largeHeight(),
                AppButton(
                  text: AppStrings.logout,
                  onTap: ref.read(settingsProvider.notifier).logoutUser,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
