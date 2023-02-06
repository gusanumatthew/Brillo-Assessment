import 'package:brilloconnetz_test/src/core/constants/colors.dart';
import 'package:brilloconnetz_test/src/features/authentication/model/interest_model.dart';
import 'package:brilloconnetz_test/src/features/profile/model/app_user.dart';
import 'package:brilloconnetz_test/src/features/profile/view/about_view.dart';
import 'package:brilloconnetz_test/src/features/settings/view_model/settings_notifier.dart';
import 'package:brilloconnetz_test/src/general_widgets/interest_tile.dart';

import 'package:brilloconnetz_test/src/general_widgets/profile_tile.dart';
import 'package:brilloconnetz_test/src/general_widgets/spacing.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';

class ProfileView extends StatefulHookConsumerWidget {
  const ProfileView({super.key, required this.appUser});
  final AppUser appUser;
  @override
  ProfileViewState createState() => ProfileViewState();
}

class ProfileViewState extends ConsumerState<ProfileView> {
  late Box<Interest> box;

  @override
  void initState() {
    super.initState();
    box = Hive.box<Interest>('interestBox');
  }

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
        centerTitle: true,
        title: Text(
          'Profile',
          style: textTheme.headline4,
        ),
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
            const Spacing.tinyHeight(),
            Text(widget.appUser.phone),
            const Spacing.largeHeight(),
            Text(
              'Selected Interests',
              style: textTheme.headline4?.copyWith(
                color: AppColors.dark,
              ),
            ),
            const Spacing.mediumHeight(),
            SizedBox(
              height: 45,
              child: ValueListenableBuilder<Box<Interest>>(
                  valueListenable: box.listenable(),
                  builder: (context, Box<Interest> box, _) {
                    List<Interest> interest =
                        box.values.toList().cast<Interest>();
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        itemCount: interest.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            child: GestureDetector(
                              onTap: () {
                                // not.updatePress(topics[index].id!);
                              },
                              child: SelectedTile(
                                model: interests[index],
                              ),
                            ),
                          );
                        });
                  }),
            ),
            const Spacing.bigHeight(),
            ProfileTile(
              leading: Icons.person_outline,
              onPressed: () => _aboutBeNotifiedScreen(context),
              title: 'About Brilloconnetz',
            ),
            const Spacing.bigHeight(),
          ],
        ),
      ),
    );
  }
}
