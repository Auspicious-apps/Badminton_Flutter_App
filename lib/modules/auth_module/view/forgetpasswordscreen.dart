import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:badminton/app_settings/components/common_textfield.dart';
import 'package:badminton/app_settings/components/label.dart';
import 'package:badminton/app_settings/components/widget_global_margin.dart';
import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/constants/app_const.dart';
import 'package:badminton/app_settings/constants/app_dim.dart';
import 'package:badminton/app_settings/constants/common_button.dart';

import '../controller/forget_password_controller.dart';

class PgForgotPassword extends GetView<ForgotPasswordController> {
  const PgForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => Get.back(),
                child: Image.asset(
                  AppAssets.backbtn,
                  width: 20,
                  height: 15,
                ),
              ).marginSymmetric(vertical: Get.width*0.05),
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  AppAssets.logo,
                  fit: BoxFit.contain,
                  width: 34,
                  height: 34,
                ),
              ),

              const Label(
                txt: "Forgot Your",
                type: TextTypes.f_30_700,
              ).marginOnly(top: Get.height*0.02),
              const Label(
                txt: "Password?",
                type: TextTypes.f_30_700,
              ),
              const Label(
                txt: "Enter the Email associated with your account.",
                type: TextTypes.f_14_400,
                forceColor: AppColors.smalltxt,
              ),

              commonTxtField(
                hTxt: "Email",
                keyboardType: TextInputType.text,
                controller: controller.phoneController,
              ).marginSymmetric(vertical: Get.height*0.03),

             Obx(()=> SizedBox(
                width: double.infinity,
                child: commonButton(
                  txt: "Confirm",
                  context: context,
                  loading: controller.loading.value,
                  onPressed: controller.onConfirm,
                ),
              )),

              SizedBox(height: Get.height*0.42,),
              Align(
                alignment: Alignment.center,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: 'Remember Password?',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      fontFamily: AppConst.fontFamily,
                      color: AppColors.grey,
                    ),
                    children: [
                      TextSpan(
                        text: ' Login',
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.blue,
                          fontWeight: FontWeight.w600,
                          fontFamily: AppConst.fontFamily,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = controller.goToLogin,
                      ),
                    ],
                  ),
                ),
              ),
              padVertical(20),
            ],
          ).marginSymmetric(horizontal:20),
        ),
      ),
    );
  }
}
