import 'package:badminton/app_settings/components/label.dart';
import 'package:badminton/app_settings/components/widget_global_margin.dart';
import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/constants/app_dim.dart';
import 'package:badminton/app_settings/constants/common_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';

import '../controller/Referral_Controller.dart';

class PgReferCode extends GetView<ReferCodeController> {
  const PgReferCode({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: WidgetGlobalMargin(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              GestureDetector(
                                onTap: controller.goBack,
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
                              const SizedBox(width: 10),
                              const Label(
                                txt: "Refer To A Friend",
                                type: TextTypes.f_18_600,
                              ),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Obx(() {
                            if (controller.referralCode.value.isEmpty) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SkeletonAvatar(
                                    style: SkeletonAvatarStyle(
                                      width: double.infinity,
                                      height: 200,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  // Step 1
                                  Row(
                                    children: [
                                      const SizedBox(width: 40),
                                      SkeletonAvatar(
                                        style: SkeletonAvatarStyle(
                                          width: 27,
                                          height: 27,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      SkeletonLine(
                                        style: SkeletonLineStyle(
                                          height: 12,
                                          width: 150,
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  // Step 2
                                  Row(
                                    children: [
                                      const SizedBox(width: 40),
                                      SkeletonAvatar(
                                        style: SkeletonAvatarStyle(
                                          width: 27,
                                          height: 27,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      SkeletonLine(
                                        style: SkeletonLineStyle(
                                          height: 12,
                                          width: 180,
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  // Step 3
                                  Row(
                                    children: [
                                      const SizedBox(width: 40),
                                      SkeletonAvatar(
                                        style: SkeletonAvatarStyle(
                                          width: 27,
                                          height: 27,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 20),
                                      SkeletonLine(
                                        style: SkeletonLineStyle(
                                          height: 12,
                                          width: 160,
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 30),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: SkeletonLine(
                                      style: SkeletonLineStyle(
                                        height: 50,
                                        width: double.infinity,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  AppAssets.referall,
                                  fit: BoxFit.contain,
                                ),
                                const SizedBox(height: 30),
                                Row(
                                  children: [
                                    const SizedBox(width: 40),
                                    Container(
                                      width: 27,
                                      height: 27,
                                      decoration: BoxDecoration(
                                        color: AppColors.blue3,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: const Align(
                                        alignment: Alignment.center,
                                        child: Label(
                                          txt: '1',
                                          type: TextTypes.f_14_400,
                                          forceColor: AppColors.whiteColor,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    const Label(
                                      txt: 'Share your referral code',
                                      type: TextTypes.f_12_500,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const SizedBox(width: 40),
                                    Container(
                                      width: 27,
                                      height: 27,
                                      decoration: BoxDecoration(
                                        color: AppColors.blue3,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: const Align(
                                        alignment: Alignment.center,
                                        child: Label(
                                          txt: '2',
                                          type: TextTypes.f_14_400,
                                          forceColor: AppColors.whiteColor,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    const Label(
                                      txt: 'Your friend creates a new account',
                                      type: TextTypes.f_12_500,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    const SizedBox(width: 40),
                                    Container(
                                      width: 27,
                                      height: 27,
                                      decoration: BoxDecoration(
                                        color: AppColors.blue3,
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: const Align(
                                        alignment: Alignment.center,
                                        child: Label(
                                          txt: '3',
                                          type: TextTypes.f_14_400,
                                          forceColor: AppColors.whiteColor,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    const Label(
                                      txt: 'You get 10% off on your next game.',
                                      type: TextTypes.f_12_500,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 30),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Clipboard.setData(ClipboardData(text: controller.referralCode.value));
                                          controller.copyReferralCode();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.all(15),
                                          decoration: BoxDecoration(
                                            color: AppColors.slidercon,
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Label(
                                                txt: controller.referralCode.value,
                                                type: TextTypes.f_12_500,
                                              ),
                                              const Label(
                                                txt: "copy",
                                                type: TextTypes.f_12_500,
                                                forceColor: AppColors.primaryColor,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}