import 'package:brilloconnetz_test/src/core/constants/colors.dart';
import 'package:brilloconnetz_test/src/core/constants/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  const AppBottomNavBar(
      {required this.currentIndex, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<List> icons = [
      [
        currentIndex == 0
            ? SvgPicture.asset(
                AppIcons.buddies,
                color: AppColors.lightBlue,
              )
            : SvgPicture.asset(
                AppIcons.buddies,
                color: Colors.grey,
              ),
        "Buddies"
      ],
      [
        currentIndex == 1
            ? SvgPicture.asset(
                AppIcons.discover,
                color: AppColors.lightBlue,
              )
            : SvgPicture.asset(
                AppIcons.discover,
                color: Colors.grey,
              ),
        "Discover"
      ],
      [
        currentIndex == 2
            ? const Icon(
                Icons.settings,
                color: AppColors.lightBlue,
              )
            : const Icon(
                Icons.settings,
                color: Colors.grey,
              ),
        "Settings"
      ],
      [
        currentIndex == 3
            ? SvgPicture.asset(
                AppIcons.profile,
                color: AppColors.lightBlue,
              )
            : SvgPicture.asset(
                AppIcons.profile,
                color: Colors.grey,
              ),
        "Profile"
      ],
    ];

    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: onTap,
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.lightBlue,
      unselectedItemColor: Colors.grey,
      selectedLabelStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: AppColors.lightBlue),
      unselectedLabelStyle: const TextStyle(
        fontSize: 12,
        fontWeight: FontWeight.w400,
      ),
      items: icons
          .asMap()
          .map((i, e) => MapEntry(
                i,
                BottomNavigationBarItem(
                  icon: e[0],
                  label: e[1],
                ),
              ))
          .values
          .toList(),
    );
  }
}
