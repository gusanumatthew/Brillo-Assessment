import 'package:brilloconnetz_test/src/features/buddies/buddies_view.dart';
import 'package:brilloconnetz_test/src/features/discover/discover_view.dart';
import 'package:brilloconnetz_test/src/features/profile/model/app_user.dart';
import 'package:brilloconnetz_test/src/features/profile/view/profile_view.dart';
import 'package:brilloconnetz_test/src/features/settings/view/settings_view.dart';
import 'package:brilloconnetz_test/src/general_widgets/app_bottom_nav.dart';
import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  final AppUser user;
  const DashboardView({super.key, required this.user});
  @override
  DashboardViewState createState() => DashboardViewState();
}

class DashboardViewState extends State<DashboardView> {
  int currentIndex = 0;

  final PageController pageController = PageController();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  pageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: IndexedStack(
        index: currentIndex,
        children: [
          const BuddiesView(),
          const DiscoverView(),
          const SettingsView(),
          ProfileView(appUser: widget.user),
        ],
      ),
    );
  }
}
