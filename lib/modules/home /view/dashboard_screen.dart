import 'package:badminton/modules/home%20/view/tab_rank_screen.dart';
import 'package:badminton/modules/home%20/view/tabhome_screen.dart';
import 'package:badminton/modules/home%20/view/tabmore_screen.dart';
import 'package:badminton/modules/home%20/view/tabplay_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


import 'package:badminton/app_settings/components/label.dart';
import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/constants/app_const.dart';

import '../controller/dashboard_controller.dart';

class PgDashBoard extends GetView<DashboardController> {
  const PgDashBoard({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor:  AppColors.whiteColor, // Set status bar color
        statusBarIconBrightness: Brightness.dark, // Ensure icons are visible on white
      ),
    );
    return Scaffold(
      body: PageView(
        controller: controller.pageController,
        physics: const NeverScrollableScrollPhysics(),
        children:  [PgTabhome(), PgTabplay(), PgTabrank(), PgTabmore()],
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        child: Obx(() => BottomNavigationBar(
          elevation: 0.0,
          currentIndex: controller.selectedIndex.value,
          onTap: controller.onTabSelected,
          unselectedFontSize: 10,
          selectedFontSize: 10,
          unselectedLabelStyle:
          const TextStyle(fontFamily: AppConst.fontFamily),
          backgroundColor: Colors.white,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            _buildNavItem("Home", 0),
            _buildNavItem("Play", 1),
            _buildNavItem("Ranking", 2),
            _buildNavItem("More", 3),
          ],
        )),
      ),
    );
  }

  BottomNavigationBarItem _buildNavItem(String label, int index) {
    final isActive = controller.selectedIndex.value == index;

    return BottomNavigationBarItem(
      icon: SizedBox(
        child: Column(
          children: [
            Container(
              width: 58,
              height: 40,
              decoration: BoxDecoration(
                color:
                isActive ? AppColors.primaryColor : Colors.transparent,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Center(
                child: Image.asset(
                  getImageAsset(label),
                  fit: BoxFit.contain,
                  width: 25,
                  height: 20,
                  color: isActive
                      ? AppColors.whiteColor
                      : AppColors.primaryColor,
                ),
              ),
            ),
            Label(
              txt: label,
              type: TextTypes.f_10_600,
              forceColor:
              isActive ? AppColors.primaryColor : AppColors.grey,
            ),
          ],
        ),
      ),
      label: "",
    );
  }

  String getImageAsset(String label) {
    switch (label.toLowerCase()) {
      case "home":
        return AppAssets.home;
      case "play":
        return AppAssets.play;
      case "ranking":
        return AppAssets.rank;
      default:
        return AppAssets.more;
    }
  }
}
