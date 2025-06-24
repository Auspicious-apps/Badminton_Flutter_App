import 'package:country_picker/country_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../app_settings/components/common_textfield.dart';
import '../../../app_settings/components/label.dart';
import '../../../app_settings/components/widget_global_margin.dart';
import '../../../app_settings/constants/app_assets.dart';
import '../../../app_settings/constants/app_colors.dart';
import '../../../app_settings/constants/app_const.dart';
import '../../../app_settings/constants/app_dim.dart';
import '../../../app_settings/constants/common_button.dart';
import '../controller/signup_controller.dart';

class PgSignup extends GetView<SignupController> {
  const PgSignup({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor:  AppColors.appBackground, // Set status bar color
        statusBarIconBrightness: Brightness.dark, // Ensure icons are visible on white
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

                          GestureDetector(
                            onTap: () => Get.back(),
                            child: Image.asset(
                              AppAssets.backbtn,
                              width: 20,
                              height: 15,
                            ),
                          ).marginSymmetric(vertical: Get.width*0.05),

                          const Label(txt: "Register", type: TextTypes.f_30_700),
                          const Label(
                            txt: "Create an account to continue!",
                            type: TextTypes.f_14_400,
                            forceColor: AppColors.smalltxt,
                          ),


                          /// First Name
                          commonTxtField(
                            hTxt: "First name",
                            controller: controller.firstNameController,
                          ).marginSymmetric(vertical: Get.height*0.03),


                          /// Last Name
                          commonTxtField(
                            hTxt: "Last name",
                            controller: controller.lastNameController,
                          ),


                          /// Email
                          commonTxtField(
                            hTxt: "Email",
                            keyboardType: TextInputType.emailAddress,
                            controller: controller.emailController,
                          ).marginSymmetric(vertical: Get.height*0.03),


                          /// Date of Birth Picker
                          Obx(
                                () => InkWell(
                              onTap: () async {
                                final today = DateTime.now();
                                final eighteenYearsAgo = DateTime(today.year, today.month, today.day);
                                final date = await showDatePicker(
                                  context: context,
                                  initialDate: eighteenYearsAgo,
                                  firstDate: DateTime(1900),
                                  lastDate: eighteenYearsAgo,
                                );
                                if (date != null) {
                                  controller.birthDate.value = date.toLocal().toString().split(' ')[0];
                                }
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                height: 50,
                                decoration: BoxDecoration(
                                  color: AppColors.whiteColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Label(
                                      txt: controller.birthDate.value.isEmpty ? 'Date of Birth' : controller.birthDate.value,
                                      type: TextTypes.f_20_900,
                                      forceColor: AppColors.smalltxt,

                                    ),
                                    Image.asset(
                                      AppAssets.calender,
                                      width: 20,
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),


                          /// Country Code + Phone Number
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  // showCountryPicker(
                                  //   context: context,
                                  //   countryListTheme: CountryListThemeData(
                                  //     flagSize: 25,
                                  //     backgroundColor: Colors.white,
                                  //     textStyle: const TextStyle(fontSize: 16, color: Colors.black),
                                  //     bottomSheetHeight: 500,
                                  //     borderRadius: const BorderRadius.only(
                                  //       topLeft: Radius.circular(20.0),
                                  //       topRight: Radius.circular(20.0),
                                  //     ),
                                  //     inputDecoration: InputDecoration(
                                  //       labelText: 'Search',
                                  //       hintText: 'Start typing to search',
                                  //       prefixIcon: const Icon(Icons.search),
                                  //       border: OutlineInputBorder(
                                  //         borderSide: BorderSide(color: const Color(0xFF8C98A8).withOpacity(0.2)),
                                  //       ),
                                  //     ),
                                  //   ),
                                  //   onSelect: (Country country) {
                                  //     controller.updateCountry(country);
                                  //   },
                                  // );
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
                                  decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Obx(
                                        () => Row(
                                      children: [
                                        Text(
                                          '${controller.selectedCountry.value.flagEmoji} +${controller.selectedCountry.value.phoneCode}',
                                          style: const TextStyle(
                                            color: AppColors.blackColor,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        // const Icon(Icons.arrow_drop_down, color: AppColors.blackColor),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: commonTxtField(
                                  hTxt: "Phone",
                                  keyboardType: TextInputType.phone,
                                  controller: controller.phoneController,
                                  maxLength: 10,
                                ),
                              ),
                            ],
                          ).marginSymmetric(vertical: Get.height*0.03),


                          /// Password Field
                          Obx(
                                () => Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
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
                                      obscureText: controller.obscurePassword.value,
                                    ),
                                  ),
                                  IconButton(
                                    icon: Icon(
                                      controller.obscurePassword.value
                                          ? Icons.visibility_off_outlined
                                          : Icons.visibility_outlined,
                                      color: AppColors.eye,
                                    ),
                                    onPressed: controller.togglePasswordVisibility,
                                  ),
                                ],
                              ),
                            ),
                          ),

                         Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              height: 50,
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: controller.refferalController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Referral Code (Optional)',
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

                                    ),
                                  ),

                                ],
                              ),
                            ).marginOnly(top: 20),

                          /// Register Button
                          Obx(()=>SizedBox(
                            width: double.infinity,
                            child: commonButton(
                              txt: "Register",
                              context: context,
                              loading: controller.loading.value,
                              onPressed:(){
                                if(controller.loading.value==false){
                                  controller.hitSignupApiCall();
                                }

                              }
                            ),
                          )).marginOnly(top: 30),

                          /// Bottom Login Text
                          Align(
                            alignment: Alignment.topCenter,
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
                                    style:  TextStyle(
                                      fontSize: 12,
                                      color: AppColors.blue,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: AppConst.fontFamily,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        if (Get.previousRoute == '/login') {
                                          Get.back();
                                        }else{
                                          controller.firstNameController.clear();
                                          controller.lastNameController.clear();
                                          controller.emailController.clear();
                                          controller.phoneController.clear();
                                          controller.passwordController.clear();
                                          controller.refferalController.clear();
                                          controller.birthDate.value='';
                                          Get.toNamed("/login");
                                        }
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ).marginOnly(top: 10),

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
