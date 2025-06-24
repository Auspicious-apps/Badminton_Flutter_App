// splash_second.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/constants/app_dim.dart';
import 'package:badminton/app_settings/constants/common_button.dart';

import '../controller/splashsecond_controller.dart';


class SplashSecond extends GetView<SplashSecondController> {
  const SplashSecond({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(children: [
        SingleChildScrollView(
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            padVertical(50),
            SizedBox(
              child: Image.asset(
                AppAssets.splashback2,
                fit: BoxFit.contain,
                height: MediaQuery.of(context).size.height / 1.3,
                width: double.infinity,
              ),
            ),
            padVertical(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: SizedBox(
                width: double.infinity,
                child: commonButton(
                  txt: "Get Started",
                  context: context,
                  onPressed: controller.goToSignIn,
                ),
              ),
            ),
            padVertical(20),
          ]),
        )
      ]),
    );
  }
}
