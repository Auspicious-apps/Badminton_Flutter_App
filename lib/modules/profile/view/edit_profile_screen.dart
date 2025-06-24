import 'package:badminton/app_settings/components/label.dart';
import 'package:badminton/app_settings/components/widget_global_margin.dart';
import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/constants/app_dim.dart';
import 'package:badminton/modules/profile/controller/edit_profile_controller.dart';
import 'package:badminton/repository/endpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../../../app_settings/components/common_textfield.dart';
import '../../../app_settings/constants/common_button.dart';
import '../controller/edit_profile_controller.dart';

class EditProfileScreen extends GetView<EditProfileController> {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: WidgetGlobalMargin(
            child: Obx(
                  () => controller.isLoading.value
                  ? _buildSkeletonUI()
                  : _buildProfileContent(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSkeletonUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _padVertical(10),
        SkeletonAvatar(
          style: SkeletonAvatarStyle(
            width: 38.w,
            height: 29.h,
            borderRadius: BorderRadius.circular(5.r),
          ),
        ),
        _padVertical(20),
        Center(
          child: SkeletonAvatar(
            style: SkeletonAvatarStyle(
              shape: BoxShape.circle,
              width: 158.w,
              height: 158.h,
            ),
          ),
        ),
        _padVertical(20),
        Center(
          child: SkeletonLine(
            style: SkeletonLineStyle(
              height: 20.h,
              width: 150.w,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ),
        _padVertical(10),
        Center(
          child: SkeletonLine(
            style: SkeletonLineStyle(
              height: 12.h,
              width: 200.w,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ),
        _padVertical(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SkeletonLine(
                style: SkeletonLineStyle(
                  height: 50.h,
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),
            ),
            _padHorizontal(20),
            Expanded(
              child: SkeletonLine(
                style: SkeletonLineStyle(
                  height: 50.h,
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),
            ),
          ],
        ),
        _padVertical(10),
        // Simplified skeleton stat rows using a loop
        for (int i = 0; i < 7; i++) _buildSkeletonStatRow(),
        _padVertical(20),
      ],
    );
  }

  Widget _buildSkeletonStatRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SkeletonLine(
            style: SkeletonLineStyle(
              height: 12.h,
              width: 120.w,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          SkeletonLine(
            style: SkeletonLineStyle(
              height: 12.h,
              width: 50.w,
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _padVertical(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                width: 38.w,
                height: 29.h,
                padding: EdgeInsets.all(10.w),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Image.asset(
                  AppAssets.backbtn,
                  fit: BoxFit.contain,
                  height: 9.h,
                  width: 12.w,
                  color: AppColors.whiteColor,
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Label(
                  txt: 'Edit Profile',
                  type: TextTypes.f_18_600,
                ),
              ),
            ),
            SizedBox(width: 38.w), // Spacer to balance the back button
          ],
        ),
        _padVertical(30),
        Center(
          child: Column(
            children: [
              GestureDetector(
                onTap: () => _showImageSourceDialog(context),
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 3.w, color: AppColors.blue2),
                        borderRadius: BorderRadius.all(Radius.circular(90.r)),
                      ),
                      height: 158.h,
                      width: 158.w,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(90.r)),
                        child: Obx(
                              () {
                                if ( controller.pickedImage.value != null) {
                                  return Image.file(
                                    controller.pickedImage.value!,
                                    fit: BoxFit.fill,
                                  );
                                } else  if (controller.profilePicUrl.value.isNotEmpty==true) {
                              return Image.network(
                               "${imageBaseUrl}${controller.profilePicUrl.value}",
                                fit: BoxFit.fill,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ?? 1)
                                          : null,
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) => Container(
                                  color: AppColors.lightGrey,
                                  child: Icon(
                                    Icons.person,
                                    size: 100.sp,
                                    color: AppColors.grey,
                                  ),
                                ),
                              );
                            }
                            // Display locally picked image if available
                            // Fallback to person icon with light grey background
                            else {
                              return Container(
                                color: AppColors.lightGrey,
                                child: Icon(
                                  Icons.person,
                                  size: 100.sp,
                                  color: AppColors.grey,
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10.h,
                      right: 10.w,
                      child: Container(
                        padding: EdgeInsets.all(6.sp),
                        decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.blue2,
                            width: 2.w,
                          ),
                        ),
                        child: Icon(
                          controller.profilePicUrl.value.isNotEmpty ||
                              controller.pickedImage.value != null
                              ? Icons.edit
                              : Icons.camera_alt,
                          size: 20.sp,
                          color: AppColors.blue2,
                        ),
                      ),
                    ),
                  ],
                ),
              ),


            ],
          ),
        ),
        _padVertical(20),
        _padVertical(20.h),
        const Label(
          txt: "First Name",
          type: TextTypes.f_14_600,
          forceColor: AppColors.smalltxt,
        ).marginSymmetric(vertical: 10 ),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey.withOpacity(0.5)),borderRadius: BorderRadius.circular(8)),
          child: commonTxtField(

            hTxt: "First name",
            controller: controller.firstNameController,
          ).marginSymmetric(),
        ),


        /// Last Name
        const Label(
          txt: "Last Name",
          type: TextTypes.f_14_600,
          forceColor: AppColors.smalltxt,
        ).marginSymmetric(vertical: 10 ),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey.withOpacity(0.5)),borderRadius: BorderRadius.circular(8)),
          child: commonTxtField(

            hTxt: "Last name",
            controller: controller.lastNameController,
          ).marginSymmetric(),
        ),

        const Label(
          txt: "Email Address",
          type: TextTypes.f_14_600,
          forceColor: AppColors.smalltxt,
        ).marginSymmetric(vertical: 10 ),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey.withOpacity(0.5)),borderRadius: BorderRadius.circular(8)),
          child: commonTxtField(
 enabled: false,
            hTxt: "Email Address",
            controller: controller.emailAddress,
          ).marginSymmetric(),
        ),
        const Label(
          txt: "Phone Number",
          type: TextTypes.f_14_600,
          forceColor: AppColors.smalltxt,
        ).marginSymmetric(vertical: 10 ),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey.withOpacity(0.5)),borderRadius: BorderRadius.circular(8)),
          child:    Row(
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
              const SizedBox(width:2),
              Expanded(
                child: commonTxtField(
                 enabled: false,
                  hTxt: "Phone",
                  keyboardType: TextInputType.phone,
                  controller: controller.phoneController,
                  maxLength: 10,
                ),
              ),
            ],
          ),
        ),
        const Label(
          txt: "Old Password",
          type: TextTypes.f_14_600,
          forceColor: AppColors.smalltxt,
        ).marginSymmetric(vertical: 10 ),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey.withOpacity(0.5)),borderRadius: BorderRadius.circular(8)),
          child: commonTxtField(

            hTxt: "Old Password",
            controller: controller.confirmPassword,
          ).marginSymmetric(),
        ),
        const Label(
          txt: "New Password",
          type: TextTypes.f_14_600,
          forceColor: AppColors.smalltxt,
        ).marginSymmetric(vertical: 10 ),
        Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.grey.withOpacity(0.5)),borderRadius: BorderRadius.circular(8)),
          child: commonTxtField(

            hTxt: "New Password",
            controller: controller.newPassword,
          ).marginSymmetric(),
        ),



    SizedBox(
          width: double.infinity,
          child: commonButton(
              txt: "Save Changes",
              context: context,
              // loading: controller.loading.value,
              onPressed:(){
                if (controller.pickedImage.value != null) {
                  controller.callUploadMedia(controller.pickedImage.value!);
                } else {
                  controller.hitSignupApiCall();
                }


              }

        )).marginOnly(top: Get.height*0.04,bottom:Get.height*0.03),
      ],
    );
  }

  // Show dialog to choose image source
  void _showImageSourceDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Gallery'),
                onTap: () {
                  controller.pickImage(ImageSource.gallery);
                  Get.back();
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Camera'),
                onTap: () {
                  controller.pickImage(ImageSource.camera);
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Helper methods for padding (assuming these are not defined in WidgetGlobalMargin)
  Widget _padVertical(double height) {
    return SizedBox(height: height.h);
  }

  Widget _padHorizontal(double width) {
    return SizedBox(width: width.w);
  }
}