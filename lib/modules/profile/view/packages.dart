import 'package:badminton/app_settings/components/label.dart';
import 'package:badminton/app_settings/components/widget_global_margin.dart';
import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/constants/app_dim.dart';
import 'package:badminton/app_settings/constants/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:get/get.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';

import '../../../app_settings/components/common_textfield.dart';
import '../controller/package_controller.dart';

class PgPackagesView extends GetView<PgPackagesController> {
  const PgPackagesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            GetBuilder<PgPackagesController>(
              init: controller..fetchNotifications(),
              builder: (controller) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: WidgetGlobalMargin(
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              padVertical(20),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.back();
                                    },
                                    child: Container(
                                      width: 38,
                                      height: 29,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Image.asset(
                                        AppAssets.backbtn,
                                        fit: BoxFit.contain,
                                        height: 9,
                                        width: 12,
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ),
                                  padHorizontal(10),
                                  const Label(
                                    txt: "Packages",
                                    type: TextTypes.f_18_600,
                                  ),
                                ],
                              ),
                              padVertical(20),
                              Obx(() => controller.isLoading.value
                                  ? _buildShimmer(context)
                                  : Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      controller.RechargeOnce.value = false;
                                      controller.RechargeOnce.refresh();
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(vertical: 5),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 1, color: AppColors.border),
                                        color: AppColors.whiteColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Container(
                                                    width: 16,
                                                    height: 16,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(width: 1, color: AppColors.border),
                                                      color: AppColors.appBackground,
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                    child: controller.RechargeOnce.value == false
                                                        ? Center(
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                          color: AppColors.primaryColor,
                                                          borderRadius: BorderRadius.circular(10),
                                                        ),
                                                      ),
                                                    ).marginAll(3)
                                                        : SizedBox(),
                                                  ),
                                                  padHorizontal(10),
                                                  const Label(
                                                    txt: "Enter Amount",
                                                    type: TextTypes.f_14_600,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Label(
                                                txt: "₹",
                                                type: TextTypes.f_20_900,
                                              ).marginOnly(right: 20),
                                              Container(
                                                width: Get.width * 0.65,
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.grey.withOpacity(0.5)),
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                                child: commonTxtField(
                                                  hTxt: "Enter Amount",
                                                  controller: controller.firstNameController,
                                                  keyboardType: TextInputType.number,
                                                ).marginSymmetric(),
                                              ),
                                            ],
                                          ).marginSymmetric(vertical: 20, horizontal: 20),
                                        ],
                                      ),
                                    ),
                                  ),
                                  padVertical(10),
                                  GestureDetector(
                                    onTap: () {
                                      controller.RechargeOnce.value = true;
                                      controller.RechargeOnce.refresh();
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(vertical: 5),
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        border: Border.all(width: 1, color: AppColors.border),
                                        color: AppColors.whiteColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: 16,
                                                height: 16,
                                                decoration: BoxDecoration(
                                                  border: Border.all(width: 1, color: AppColors.border),
                                                  color: AppColors.appBackground,
                                                  borderRadius: BorderRadius.circular(10),
                                                ),
                                                child: controller.RechargeOnce.value == true
                                                    ? Center(
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      color: AppColors.primaryColor,
                                                      borderRadius: BorderRadius.circular(10),
                                                    ),
                                                  ),
                                                ).marginAll(3)
                                                    : SizedBox(),
                                              ),
                                              padHorizontal(10),
                                              const Label(
                                                txt: "Recharge Once",
                                                type: TextTypes.f_14_600,
                                              ),
                                            ],
                                          ),
                                          padVertical(20),
                                          ListView.builder(
                                            shrinkWrap: true,
                                            physics: const NeverScrollableScrollPhysics(),
                                            itemCount: controller.packages.value.data?.length ?? 0,
                                            itemBuilder: (context, index) {
                                              final package = controller.packages.value.data?[index];
                                              return GestureDetector(
                                                onTap: (){
                                                  controller.BuyFixPackagesApiCall(package?.sId);
                                                },
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                                                          decoration: BoxDecoration(
                                                            color: AppColors.green2,
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                          child: Column(
                                                            children: [
                                                              Label(
                                                                txt: (package?.extraCoins ?? 0).toString(),
                                                                type: TextTypes.f_18_600,
                                                                forceColor: AppColors.whiteColor,
                                                              ),
                                                              const Label(
                                                                txt: "Coins Extra",
                                                                type: TextTypes.f_10_600,
                                                                forceColor: AppColors.whiteColor,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: Container(
                                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                                            decoration: BoxDecoration(
                                                              border: Border.all(width: 1, color: AppColors.green2),
                                                              color: AppColors.whiteColor,
                                                              borderRadius: BorderRadius.circular(8),
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                              children: [
                                                                Column(
                                                                  children: [
                                                                    const Label(
                                                                      txt: "Recharge With",
                                                                      type: TextTypes.f_10_600,
                                                                      forceColor: AppColors.smalltxt,
                                                                    ),
                                                                    Label(
                                                                      txt: (package?.amount ?? 0).toString(),
                                                                      type: TextTypes.f_14_600,
                                                                      forceColor: AppColors.smalltxt,
                                                                    ),
                                                                  ],
                                                                ),
                                                                Row(
                                                                  children: [
                                                                    const Dash(
                                                                      direction: Axis.vertical,
                                                                      length: 50,
                                                                      dashLength: 5,
                                                                      dashThickness: 1,
                                                                      dashColor: Colors.grey,
                                                                    ),
                                                                    padHorizontal(20),
                                                                    Column(
                                                                      children: [
                                                                        const Label(
                                                                          txt: "Avail Now",
                                                                          type: TextTypes.f_10_600,
                                                                          forceColor: AppColors.smalltxt,
                                                                        ),
                                                                        padVertical(10),
                                                                        Container(
                                                                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                                                                          decoration: BoxDecoration(
                                                                            color: AppColors.green2,
                                                                            borderRadius: BorderRadius.circular(10),
                                                                          ),
                                                                          child: const Icon(
                                                                            Icons.arrow_forward,
                                                                            size: 18,
                                                                            color: AppColors.whiteColor,
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    padHorizontal(20),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    padVertical(15),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                          padVertical(10),
                                        ],
                                      ),
                                    ),
                                  ),
                                  controller.RechargeOnce.value == false
                                      ? SizedBox(
                                    width: double.infinity,
                                    child: commonButton(
                                      txt: "Recharge Now",
                                      context: context,
                                      onPressed: () {
                                        controller.BuyPackagesApiCall();
                                      },
                                    ),
                                  ).marginOnly(top: 20)
                                      : SizedBox(),
                                ],
                              )),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShimmer(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SkeletonItem(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: AppColors.border),
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: 16,
                            height: 16,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        padHorizontal(10),
                        SkeletonLine(
                          style: SkeletonLineStyle(
                            width: 100,
                            height: 14,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        width: 20,
                        height: 20,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ).marginOnly(right: 20),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        width: Get.width * 0.65,
                        height: 40,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ],
                ).marginSymmetric(vertical: 20, horizontal: 20),
              ],
            ),
          ),
        ),
        padVertical(10),
        SkeletonItem(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: AppColors.border),
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        width: 16,
                        height: 16,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    padHorizontal(10),
                    SkeletonLine(
                      style: SkeletonLineStyle(
                        width: 100,
                        height: 14,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
                padVertical(20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3, // Show 3 placeholder items
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SkeletonAvatar(
                              style: SkeletonAvatarStyle(
                                width: 80,
                                height: 60,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                                decoration: BoxDecoration(
                                  border: Border.all(width: 1, color: AppColors.border),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SkeletonLine(
                                          style: SkeletonLineStyle(
                                            width: 80,
                                            height: 10,
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                        ),
                                        padVertical(5),
                                        SkeletonLine(
                                          style: SkeletonLineStyle(
                                            width: 60,
                                            height: 14,
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SkeletonLine(
                                          style: SkeletonLineStyle(
                                            width: 1,
                                            height: 50,
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                        ),
                                        padHorizontal(20),
                                        Column(
                                          children: [
                                            SkeletonLine(
                                              style: SkeletonLineStyle(
                                                width: 60,
                                                height: 10,
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                            ),
                                            padVertical(10),
                                            SkeletonAvatar(
                                              style: SkeletonAvatarStyle(
                                                width: 30,
                                                height: 20,
                                                borderRadius: BorderRadius.circular(10),
                                              ),
                                            ),
                                          ],
                                        ),
                                        padHorizontal(20),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        padVertical(15),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),
        ),
        padVertical(10),
        SkeletonItem(
          child: SizedBox(
            width: double.infinity,
            child: SkeletonLine(
              style: SkeletonLineStyle(
                height: 50,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ).marginOnly(top: 20),
      ],
    );
  }
}