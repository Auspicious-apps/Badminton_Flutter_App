// pg_signin.dart
import 'dart:io';

import 'package:badminton/app_settings/components/common_textfield.dart';
import 'package:badminton/app_settings/components/label.dart';
import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/constants/app_const.dart';
import 'package:badminton/app_settings/constants/app_dim.dart';
import 'package:badminton/app_settings/constants/common_button.dart';
import 'package:badminton/app_settings/components/widget_global_margin.dart';
import 'package:badminton/modules/auth_module/controller/login_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../controller/forget_password_controller.dart';

class PgSignin extends GetView<LoginController> {
  const PgSignin({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.appBackground, // Set status bar color
        statusBarIconBrightness:
            Brightness.dark, // Ensure icons are visible on white
      ),
    );
    return Scaffold(
      backgroundColor: AppColors.appBackground,
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
                          Align(
                            alignment: Alignment.center,
                            child: Image.asset(AppAssets.logo,
                                width: 34, height: 34),
                          ).marginSymmetric(vertical: Get.height * 0.03),

                          const Label(
                              txt: "Sign in to your", type: TextTypes.f_30_700),
                          const Label(txt: "Account", type: TextTypes.f_30_700),
                          const Label(
                            txt: "Enter your email and password",
                            type: TextTypes.f_14_400,
                            forceColor: AppColors.smalltxt,
                          ),

                          commonTxtField(
                            hTxt: "Email",
                            keyboardType: TextInputType.emailAddress,
                            controller: controller.emailController,
                          ).marginSymmetric(vertical: Get.height * 0.03),

                          Obx(
                            () => Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              height: 50,
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: controller.passwordController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Password',
                                        hintStyle: TextStyle(
                                          color: AppColors.smalltxt,
                                          fontFamily: AppConst.fontFamily,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      style: const TextStyle(
                                        color: AppColors.blackColor,
                                        fontFamily: AppConst.fontFamily,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      obscureText:
                                          controller.obscurePassword.value,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      controller.obscurePassword.value
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      color: AppColors.eye,
                                    ),
                                    onPressed:
                                        controller.togglePasswordVisibility,
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Obx(() => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Checkbox(
                                        value: controller.rememberMe.value,
                                        onChanged: (val) => controller
                                            .rememberMe.value = val ?? false,
                                      ),
                                      const Label(
                                        txt: "Remember me",
                                        type: TextTypes.f_12_400,
                                        forceColor: AppColors.smalltxt,
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () => {
                                      controller.passwordController.text = "",
                                      controller.emailController.text = "",
                                      Get.toNamed("/forget")
                                    },
                                    child: const Text(
                                      'Forgot Password?',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: AppColors.blue,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              )).marginSymmetric(vertical: Get.height * 0.01),

                          Obx(() => SizedBox(
                                width: double.infinity,
                                child: commonButton(
                                  txt: "Log In",
                                  context: context,
                                  loading: controller.loading.value,
                                  onPressed: () {
                                    if (!controller.loading.value) {
                                      // Debounce by ignoring rapid clicks
                                      DateTime? lastClick;
                                      const debounceDuration =
                                          Duration(milliseconds: 500);
                                      if (lastClick == null ||
                                          DateTime.now().difference(lastClick) >
                                              debounceDuration) {
                                        lastClick = DateTime.now();
                                        controller.login();
                                      }
                                    }
                                  },
                                ),
                              )),

                          const Align(
                            alignment: Alignment.center,
                            child: Label(
                              txt: "-   Or   -",
                              type: TextTypes.f_14_400,
                              forceColor: AppColors.smalltxt,
                            ),
                          ).marginSymmetric(vertical: Get.height * 0.02),

                          // Google button
                          socialButton(
                              AppAssets.google, "Continue with Google"),

                      Platform.isIOS? Container(
                            child: SignInWithAppleButton(
                              onPressed: () async {
                                try {
                                  final credential = await SignInWithApple
                                      .getAppleIDCredential(
                                    scopes: [
                                      AppleIDAuthorizationScopes.email,
                                      AppleIDAuthorizationScopes.fullName,
                                    ],
                                  );
                                  print(
                                      "Apple Sign-In Credential: ${credential.identityToken}");

                                  controller.AppleLogin(
                                      credential.identityToken);
                                } catch (e) {
                                  print("Sign in with Apple failed: $e");
                                  Get.snackbar(
                                    "Sign-In Error",
                                    "Failed to sign in with Apple. Please try again.",
                                    snackPosition: SnackPosition.TOP,
                                    backgroundColor: AppColors.red,
                                    colorText: AppColors.whiteColor,
                                  );
                                }
                              },
                            ),
                          ).marginSymmetric(horizontal: 10, vertical: 20):SizedBox(height: 20,),

                          socialButton(
                                  AppAssets.facebook, "Continue with Facebook")
                              .marginOnly(bottom: Get.height * 0.02),

                          Align(
                            alignment: Alignment.center,
                            child: RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: 'Don’t have an account?',
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: AppConst.fontFamily,
                                  color: AppColors.grey,
                                ),
                                children: [
                                  TextSpan(
                                    text: ' Sign Up',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: AppColors.blue,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: AppConst.fontFamily,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () async {
                                        controller.emailController.text = "";
                                        controller.passwordController.text = "";
                                        if (Get.previousRoute == '/signup') {
                                          Get.back();
                                        } else {
                                          Get.toNamed("/signup");
                                          final savedEmail = controller.storage
                                                  .read('email') ??
                                              '';
                                          final savedPassword = controller
                                                  .storage
                                                  .read('password') ??
                                              '';
                                          final remember = controller.storage
                                                  .read('rememberMe') ??
                                              false;

                                          if (remember) {
                                            controller.emailController.text =
                                                savedEmail;
                                            controller.passwordController.text =
                                                savedPassword;
                                            controller.rememberMe.value = true;
                                          }
                                        }
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ).marginOnly(top: Get.height * 0.05),
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

  Widget socialButton(String iconPath, String label) {
    return GestureDetector(
      onTap: () {
        controller.signInWithGoogle();
      },
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(iconPath, width: 17, height: 17),
            padHorizontal(10),
            Label(
                txt: label,
                type: TextTypes.f_12_500,
                forceColor: AppColors.blackColor),
          ],
        ),
      ),
    );
  }
}
