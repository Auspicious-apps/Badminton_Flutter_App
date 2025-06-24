import 'package:badminton/app_settings/components/label.dart';
import 'package:badminton/app_settings/components/widget_global_margin.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/constants/app_dim.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';

import '../../../app_settings/constants/app_assets.dart';
import '../controller/merchandise_home.dart';
import '../controller/privacy_policy_controller.dart';

class PgPrivacyPolicy extends GetView<PrivacyPolicyController> {
  const PgPrivacyPolicy({Key? key}) : super(key: key);

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
                                onTap: () => Get.back(),
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
                              Obx(() => Label(
                                txt: "${controller.title.value}",
                                type: TextTypes.f_18_600,
                              )),
                            ],
                          ),
                          const SizedBox(height: 30),
                          Obx(() {
                            if (controller.loading.value ==true) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SkeletonLine(
                                    style: SkeletonLineStyle(
                                      height: 18,
                                      width: 200,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  SkeletonParagraph(
                                    style: SkeletonParagraphStyle(
                                      lines: 10,
                                      spacing: 8,
                                      lineStyle: SkeletonLineStyle(
                                        height: 14,
                                        borderRadius: BorderRadius.circular(4),
                                        randomLength: true,
                                        minLength: MediaQuery.of(context).size.width * 0.5,
                                        maxLength: MediaQuery.of(context).size.width * 0.9,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }
                            return Html(
                              data: controller.title.value == "Privacy Policy"
                                  ? controller.contentData.value.data?.privacyPolicy
                                  : controller.contentData.value.data?.termsAndConditions,
                              style: {
                                'p': Style(
                                  fontSize: FontSize(14),
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.smalltxt,
                                ),
                                'h2': Style(
                                  fontSize: FontSize(18),
                                  fontWeight: FontWeight.w600,
                                ),
                              },
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