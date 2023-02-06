import 'package:brilloconnetz_test/src/core/constants/colors.dart';
import 'package:brilloconnetz_test/src/features/profile/view/about_view.dart';
import 'package:brilloconnetz_test/src/features/settings/view_model/settings_notifier.dart';

import 'package:brilloconnetz_test/src/general_widgets/profile_tile.dart';
import 'package:brilloconnetz_test/src/general_widgets/spacing.dart';
import 'package:flutter/material.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileView extends StatefulHookConsumerWidget {
  const ProfileView({super.key});

  @override
  ProfileViewState createState() => ProfileViewState();
}

class ProfileViewState extends ConsumerState<ProfileView> {
  void _aboutBeNotifiedScreen(context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      isScrollControlled: true,
      builder: (BuildContext context) => const AboutView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final user = ref.watch(settingsProvider.notifier).user;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios_outlined),
          color: AppColors.dark,
        ),
        title: const Text('Profile'),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Spacing.largeHeight(),
            CircleAvatar(
              backgroundColor: AppColors.lightBlue,
              radius: 36,
              child: Text(
                user.displayName![0],
                style: textTheme.headline6?.copyWith(
                  backgroundColor: AppColors.lightBlue,
                ),
              ),
            ),
            const Spacing.bigHeight(),
            Text(
              user.displayName!,
              style: textTheme.headline6,
            ),
            const Spacing.tinyHeight(),
            Text(user.email!),
            const Spacing.largeHeight(),
            const Spacing.bigHeight(),
            ProfileTile(
              leading: Icons.person_outline,
              onPressed: () => _aboutBeNotifiedScreen(context),
              title: 'About Brilloconnetz',
            ),
            const Spacing.bigHeight(),
            ProfileTile(
              leading: Icons.logout,
              onPressed: () async {
                await ref.read(settingsProvider.notifier).logoutUser();
              },
              title: 'Logout',
            ),
            const Spacing.bigHeight(),
          ],
        ),
      ),
    );
  }
}
