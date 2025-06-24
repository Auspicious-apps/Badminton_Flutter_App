// splash_screen.dart
import 'package:badminton/app_settings/components/widget_global_margin.dart';
import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/constants/app_dim.dart';
import 'package:badminton/app_settings/constants/common_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/splash_controller.dart';


class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: Stack(children: [
            WidgetGlobalMargin(
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        padVertical(50),
                        SizedBox(
                          child: Image.asset(
                            AppAssets.splashback,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        padVertical(50),
                        Padding(
                            padding: const EdgeInsets.only(left: 14),
                            child: SizedBox(
                                width: MediaQuery.of(context).size.width / 3,
                                child: commonButton(
                                  txt: "Next",
                                  context: context,
                                  onPressed: controller.goToNextScreen,
                                )))
                      ]),
                )),
          ]),
        ));
  }
}
