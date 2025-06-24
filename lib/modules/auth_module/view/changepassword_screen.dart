import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app_settings/components/common_textfield.dart';
import '../../../app_settings/components/label.dart';
import '../../../app_settings/components/widget_global_margin.dart';
import '../../../app_settings/constants/app_assets.dart';
import '../../../app_settings/constants/app_colors.dart';
import '../../../app_settings/constants/app_const.dart';
import '../../../app_settings/constants/common_button.dart';
import '../controller/change_password_controller.dart';

class PgChangePassword extends GetView<ChangePasswordController> {
  const PgChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  AppAssets.logo,
                  width: 34,
                  height: 34,
                  fit: BoxFit.contain,
                ),
              ).marginSymmetric(vertical: Get.height*0.03),

              const Label(txt: "Create A New", type: TextTypes.f_30_700),
              const Label(txt: "Password", type: TextTypes.f_30_700),
              const Label(
                txt: "Create new password at least 8 digit long.",
                type: TextTypes.f_14_400,
                forceColor: AppColors.smalltxt,
              ),

              commonTxtField(
                hTxt: "New password",
                controller: controller.newPasswordController,
                obscureText: false,
              ).marginSymmetric(vertical: Get.height*0.02),

              commonTxtField(
                hTxt: "Confirm password",
                controller: controller.confirmPasswordController,
                obscureText: false,
              ),

              Obx(()=>SizedBox(
                width: double.infinity,
                child: commonButton(
                  txt: "Confirm",
                  context: context,
                  loading: controller.loading.value,
                  onPressed: controller.onConfirmPressed,
                ),)
              ).marginSymmetric(vertical: Get.height*0.03),
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Align(
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
                            ..onTap = () {
                              controller.newPasswordController.text="";
                              controller.confirmPasswordController.text='';
                              Get.offAllNamed("/login");
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ).marginOnly(top: Get.height*0.35),
            ],
          ).marginSymmetric(horizontal: 20),
        ),
      ),
    );
  }
}