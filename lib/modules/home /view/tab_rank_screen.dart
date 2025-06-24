import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:badminton/app_settings/components/label.dart';
import 'package:badminton/app_settings/components/widget_global_margin.dart';
import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/constants/app_const.dart';
import 'package:badminton/app_settings/constants/app_dim.dart';

import '../controller/tab_rank_controller.dart';

class PgTabrank extends GetView<RankController> {
  const PgTabrank({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: WidgetGlobalMargin(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      padVertical(10),
                      const Label(txt: "Ranking", type: TextTypes.f_18_600),
                      padVertical(15),
                      _buildTabToggle(),
                      padVertical(20),
                      _buildSearchBar(),
                      padVertical(30),
                      _buildTopThree(),
                      padVertical(25),
                      _buildRankingList(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabToggle() {
    return Obx(() => Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(2, (index) {
        final isSelected = controller.selectedIndex.value == index;
        final labels = ['Worldwide', 'Friends'];
        return GestureDetector(
          onTap: () => controller.changeTab(index),
          child: Container(
            width: 150,
            padding: const EdgeInsets.symmetric(vertical: 10),
            margin: EdgeInsets.only(left: index == 0 ? 0 : 10),
            decoration: BoxDecoration(
              color:
              isSelected ? AppColors.primaryColor : AppColors.lightGrey,
              borderRadius: BorderRadius.circular(8),
            ),
            alignment: Alignment.center,
            child: Label(
              txt: labels[index],
              type: TextTypes.f_14_500,
              forceColor: isSelected
                  ? AppColors.whiteColor
                  : AppColors.primaryColor,
            ),
          ),
        );
      }),
    ));
  }

  Widget _buildSearchBar() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: AppColors.border, width: 1),
      ),
      child: Row(
        children: [
          Image.asset(AppAssets.search, width: 20, height: 20),
          padHorizontal(10),
          const Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Search anything....",
                hintStyle: TextStyle(
                  color: AppColors.smalltxt,
                  fontFamily: AppConst.fontFamily,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
              style: TextStyle(
                color: AppColors.blackColor,
                fontFamily: AppConst.fontFamily,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          padHorizontal(8),
          Image.asset(AppAssets.filter, width: 15, height: 15),
        ],
      ),
    );
  }

  Widget _buildTopThree() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(3, (index) {
        final isCenter = index == 1;
        return Column(
          children: [
            if (isCenter)
              Stack(
                alignment: Alignment.topCenter,
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.asset(AppAssets.rankProfile,
                        width: 117, height: 117, fit: BoxFit.cover),
                  ),
                  Positioned(
                    top: -28,
                    child: Image.asset(AppAssets.crown,
                        height: 39, width: 39, fit: BoxFit.contain),
                  ),
                ],
              )
            else
              ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.asset(AppAssets.rankProfile,
                    width: 76, height: 76, fit: BoxFit.cover),
              ),
            padVertical(8),
            Label(
              txt: controller.rankings[index]['name'].toString(),
              type: TextTypes.f_12_700,
            ),
            Label(
              txt: controller.rankings[index]['points'].toString(),
              type: TextTypes.f_12_500,
              forceColor: AppColors.grey,
            ),
            Label(
              txt: controller.rankings[index]['country'].toString(),
              type: TextTypes.f_12_500,
              forceColor: AppColors.grey,
            ),
          ],
        );
      }),
    );
  }

  Widget _buildRankingList() {
    return Obx(() => ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.rankings.length,
      itemBuilder: (context, index) {
        final user = controller.rankings[index];
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.whiteColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Container(
                  height: 27,
                  width: 27,
                  decoration: BoxDecoration(
                    color: AppColors.rankPoint,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  alignment: Alignment.center,
                  child: Label(
                      txt: "${index + 1}", type: TextTypes.f_12_700),
                ),
                padHorizontal(8),
                Row(
                  children: [
                    Image.asset(AppAssets.profile,
                        width: 42, height: 42, fit: BoxFit.contain),
                    padHorizontal(5),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Label(txt: user['name'].toString(), type: TextTypes.f_12_700),
                        Label(
                          txt: user['country'].toString(),
                          type: TextTypes.f_12_500,
                          forceColor: AppColors.grey,
                        ),
                      ],
                    ),
                  ],
                )
              ]),
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.blue2,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Label(
                  txt: user['points'].toString(),
                  type: TextTypes.f_12_700,
                  forceColor: AppColors.whiteColor,
                ),
              ),
            ],
          ),
        );
      },
    ));
  }
}
