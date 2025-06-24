import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../app_settings/components/label.dart';
import '../../../app_settings/components/widget_global_margin.dart';
import '../../../app_settings/constants/app_assets.dart';
import '../../../app_settings/constants/app_colors.dart';
import '../../../app_settings/constants/app_const.dart';
import '../../../app_settings/constants/app_dim.dart';
import '../../../app_settings/constants/common_button.dart';
import '../controller/otp_controller.dart';

class PgOtpVerification extends GetView<OtpVerificationController> {
  const PgOtpVerification({super.key});

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
                txt: "Enter OTP",
                type: TextTypes.f_30_700,
              ).marginOnly(top: Get.height*0.02),
              Obx(
                () => controller.emailVerified == true
                    ? Label(
                        txt: "Enter the OTP received on your phone",
                        type: TextTypes.f_14_400,
                        forceColor: AppColors.smalltxt,
                      )
                    : Label(
                        txt: "Enter the OTP received on your email",
                        type: TextTypes.f_14_400,
                        forceColor: AppColors.smalltxt,
                      ),
              ),

              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
                child: PinCodeTextField(
                  appContext: context,
                  length: 6,
                  controller: controller
                      .pinController, // <-- controller added
                  focusNode: controller
                      .pinFocusNode, // <-- focus node added
                  onChanged: (value) => controller.updateOtp(value),
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.number,
                  textStyle: const TextStyle(
                    fontFamily: AppConst.fontFamily,
                    fontWeight: FontWeight.w500,
                  ),
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(10),
                    fieldHeight: 47,
                    fieldWidth: 40,
                    activeFillColor: AppColors.whiteColor,
                    inactiveFillColor: AppColors.whiteColor,
                    activeColor: AppColors.primaryColor,
                    selectedFillColor: Colors.white,
                    inactiveColor: AppColors.appBackground,
                    selectedColor: AppColors.blue,
                  ),
                  enableActiveFill: true,
                ),
              ).marginSymmetric(vertical:Get.height*0.03),

              Obx(() {
                return Center(
                  child: GestureDetector(
                    onTap: () {
                      if (controller.timerSeconds.value == 0 && controller.resend.value==false) {
                      controller.resend.value=true;
                      controller.resend.refresh();
                        if(Get.previousRoute=="/forget"){
                          controller.onConfirm();
                        }else{
                          controller.resendOtp();
                        }

                      }
                    },
                    child: Text(
                      controller.timerSeconds.value > 0
                          ? "Resend OTP in ${(controller.timerSeconds.value ~/ 60).toString().padLeft(2, '0')}:${(controller.timerSeconds.value % 60).toString().padLeft(2, '0')}"
                          : "Resend OTP",

                      style:  (controller.resend.value==false)?TextStyle(
                        fontSize: 12,
                        color: AppColors.blue,
                        fontWeight: FontWeight.w600,
                        fontFamily: AppConst.fontFamily,
                      ):  TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.grey,
                        fontFamily: AppConst.fontFamily,
                      ),
                    ),
                  ),
                );
              }),

              Obx(() => SizedBox(
                width: double.infinity,
                child: commonButton(
                  txt: "Verify",
                  context: context,
                  loading: controller.loading.value,
                  onPressed: () {
                    if (controller.otpCode.value.length != 6) {
                      Get.closeAllSnackbars(); //

                      Get.snackbar('Error', 'Please enter a valid 6-digit OTP');
                      return;
                    }

                    controller.loading.value = true; // Start loading

                    try {
                      if (Get.previousRoute == '/forget') {
                        controller.forgetVerifyOtp();
                      } else if (!controller.emailVerified.value) {
                        controller.verifyOtp();
                      } else {
                        controller.phoneVerifyOtp();
                      }
                    } catch (e) {
                      Get.snackbar('Error', 'Verification failed: $e');
                      controller.loading.value = false; // Reset loading on error
                    }
                  },
                ),
              )).marginSymmetric(vertical: Get.height*0.02),

              SizedBox(height: Get.height*0.4,),
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
                          ..onTap = () {
                            controller.pinController.clear();
                            controller.otpCode.value = '';
                            controller.otpCode.refresh();
                            Get.back();
                            Get.back();
                          },
                      ),
                    ],
                  ),
                ),
              ),
              padVertical(20),
            ],
          ).marginSymmetric(horizontal: 20),
        ),
      ),
    );
  }
}
