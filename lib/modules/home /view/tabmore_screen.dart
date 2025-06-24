// lib/pages/pg_tabmore.dart
import 'package:badminton/repository/endpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:get/get.dart';

import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:badminton/app_settings/components/label.dart';
import 'package:badminton/app_settings/components/widget_global_margin.dart';

import '../../../Pages/MyOrder/pg_my_order.dart';
import '../../../Pages/Packages/pg_packages.dart';
import '../../../Pages/PlayCoins/pg_play_coins.dart';

import '../../../Pages/ReferCode/pg_refercode.dart';
import '../../../Pages/Voucher/pg_voucher.dart';
import '../../../app_settings/constants/app_dim.dart';
import '../controller/tab_more_controller.dart';

class PgTabmore extends StatelessWidget {
  const PgTabmore({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final MoreController controller = Get.put(MoreController());

    return GetBuilder<MoreController>(
      init: controller, // Optional: already initialized with Get.put
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.background,
          body: SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                await controller.getData();
              },
              child: Stack(
                children: [
                  Obx(
                    () => controller.loading.value
                        ? _buildSkeletonUI()
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: WidgetGlobalMargin(
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        padVertical(20),
                                        Row(
                                          children: [
                                            Container(
                                                height: 92,
                                                width: 92,
                                                padding: const EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                  color: AppColors.lightGrey,
                                                  borderRadius:
                                                      BorderRadius.circular(45),
                                                  border: Border.all(
                                                    width: 2,
                                                    color: AppColors.blue,
                                                  ),
                                                ),
                                                child: GestureDetector(
                                                  onTap: () {
                                                    print(
                                                        "${imageBaseUrl}${controller.responseModel.value.data!.profilePic}");
                                                    Get.toNamed(
                                                        '/userprofiledetail',
                                                        arguments: {
                                                          "id": controller
                                                                  .responseModel
                                                                  .value
                                                                  .data
                                                                  ?.sId ??
                                                              "",
                                                          "isAdmin": true
                                                        });
                                                  },
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(45),
                                                    child: (controller
                                                                    .responseModel
                                                                    .value
                                                                    .data
                                                                    ?.profilePic !=
                                                                null &&
                                                            controller
                                                                    .responseModel
                                                                    .value
                                                                    .data
                                                                    ?.profilePic !=
                                                                "")
                                                        ? Image.network(
                                                            controller
                                                                    .responseModel
                                                                    .value
                                                                    .data!
                                                                    .profilePic!
                                                                    .startsWith(
                                                                        'http')
                                                                ? controller
                                                                    .responseModel
                                                                    .value
                                                                    .data!
                                                                    .profilePic!
                                                                : "${imageBaseUrl}${controller.responseModel.value.data!.profilePic}",
                                                            fit: BoxFit.cover,
                                                            errorBuilder:
                                                                (context, error,
                                                                    stackTrace) {
                                                              return Container(
                                                                color: AppColors
                                                                    .lightGrey,
                                                                child: Icon(
                                                                  Icons
                                                                      .person, // Error image/icon
                                                                  size: 60.sp,
                                                                  color: AppColors
                                                                      .grey,
                                                                ),
                                                              );
                                                            },
                                                          )
                                                        : Container(
                                                            color: AppColors
                                                                .lightGrey,
                                                            child: Icon(
                                                              Icons
                                                                  .person, // Default icon when no image
                                                              size: 60.sp,
                                                              color:
                                                                  AppColors.grey,
                                                            ),
                                                          ),
                                                  ),
                                                )),
                                            padHorizontal(20),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Label(
                                                  txt:
                                                      "${controller.responseModel.value.data?.firstName ?? ""} ${controller.responseModel.value.data?.lastName ?? ""}",
                                                  type: TextTypes.f_16_600,
                                                ),
                                                padVertical(10),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 5,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.blue2,
                                                    borderRadius:
                                                        BorderRadius.circular(8),
                                                  ),
                                                  child: Label(
                                                    txt:
                                                        "${controller.responseModel.value.data?.loyaltyTier ?? "No Tier"}",
                                                    type: TextTypes.f_10_400,
                                                    forceColor:
                                                        AppColors.whiteColor,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        padVertical(20),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Label(
                                                    txt:
                                                        "${(controller.responseModel.value.data?.totalMatches ?? 0).toString()}",
                                                    type: TextTypes.f_20_400,
                                                  ),
                                                  Label(
                                                    txt: "Matches",
                                                    type: TextTypes.f_10_400,
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                height: 34,
                                                decoration: BoxDecoration(
                                                  color: AppColors.lightGrey,
                                                  border: Border.all(
                                                    width: 1,
                                                    color: AppColors.border2,
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Label(
                                                    txt:
                                                        "${(controller.responseModel.value.data?.totalFriends ?? 0).toString()}",
                                                    type: TextTypes.f_20_400,
                                                  ),
                                                  Label(
                                                    txt: "Friends",
                                                    type: TextTypes.f_10_400,
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                height: 34,
                                                decoration: BoxDecoration(
                                                  color: AppColors.lightGrey,
                                                  border: Border.all(
                                                    width: 1,
                                                    color: AppColors.border2,
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Label(
                                                    txt:
                                                        "${(controller.responseModel.value.data?.playCoins ?? 0).toString()}",
                                                    type: TextTypes.f_20_400,
                                                  ),
                                                  Label(
                                                    txt: "Play Coins",
                                                    type: TextTypes.f_10_400,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        padVertical(30),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            GestureDetector(
                                              behavior: HitTestBehavior.opaque,
                                              onTap: () {
                                                Get.toNamed('allusers',
                                                    arguments: {
                                                      "from": "All Users"
                                                    });
                                              },
                                              child: Container(
                                                width: 150,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 0,
                                                  vertical: 10,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                    width: 1,
                                                    color: AppColors.blue2,
                                                  ),
                                                ),
                                                child: const Align(
                                                  alignment: Alignment.center,
                                                  child: Label(
                                                    txt: "Invite Friends",
                                                    type: TextTypes.f_12_400,
                                                    forceColor: AppColors.blue2,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            padHorizontal(10),
                                            GestureDetector(
                                              onTap: () async {
                                                await Get.toNamed("/editProfile",
                                                    arguments: {
                                                      "userdata": controller
                                                          .responseModel.value
                                                    });
                                                controller.getData();
                                              },
                                              child: Container(
                                                width: 150,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 0,
                                                  vertical: 10,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: AppColors.blue2,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: const Align(
                                                  alignment: Alignment.center,
                                                  child: Label(
                                                    txt: "Edit Profile",
                                                    type: TextTypes.f_12_400,
                                                    forceColor:
                                                        AppColors.whiteColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        padVertical(30),
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 15,
                                            vertical: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.lightGrey,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          child: Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Get.toNamed("/mybookings");
                                                },
                                                behavior: HitTestBehavior.opaque,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 15),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: 40,
                                                        width: 40,
                                                        decoration: BoxDecoration(
                                                          color: AppColors
                                                              .whiteColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Image.asset(
                                                            AppAssets.mybooking,
                                                            fit: BoxFit.contain,
                                                            width: 16,
                                                            height: 16,
                                                          ),
                                                        ),
                                                      ),
                                                      padHorizontal(20),
                                                      const Label(
                                                        txt: "My Bookings",
                                                        type: TextTypes.f_12_700,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              padVertical(6),
                                              const Divider(),
                                              padVertical(6),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.toNamed("/my_orders");
                                                  // Navigator.push(
                                                  //   context,
                                                  //   MaterialPageRoute(
                                                  //     builder: (context) =>
                                                  //     const PgMyOrder(),
                                                  //   ),
                                                  // );
                                                },
                                                behavior: HitTestBehavior.opaque,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 15),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: 40,
                                                        width: 40,
                                                        decoration: BoxDecoration(
                                                          color: AppColors
                                                              .whiteColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Image.asset(
                                                            AppAssets.myOrder,
                                                            fit: BoxFit.contain,
                                                            width: 16,
                                                            height: 16,
                                                          ),
                                                        ),
                                                      ),
                                                      padHorizontal(20),
                                                      const Label(
                                                        txt: "My Orders",
                                                        type: TextTypes.f_12_700,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              padVertical(6),
                                              const Divider(),
                                              padVertical(6),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.toNamed("requests");
                                                },
                                                behavior: HitTestBehavior.opaque,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 15),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: 40,
                                                        width: 40,
                                                        decoration: BoxDecoration(
                                                          color: AppColors
                                                              .whiteColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Image.asset(
                                                            AppAssets.friends,
                                                            fit: BoxFit.contain,
                                                            width: 16,
                                                            height: 16,
                                                          ),
                                                        ),
                                                      ),
                                                      padHorizontal(20),
                                                      const Label(
                                                        txt: "Friends",
                                                        type: TextTypes.f_12_700,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              padVertical(6),
                                              const Divider(),
                                              padVertical(6),
                                              GestureDetector(
                                                onTap: () async {
                                                await  Get.toNamed("/package_screen");
                                                controller.getData();
                                                },
                                                behavior: HitTestBehavior.opaque,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 15),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: 40,
                                                        width: 40,
                                                        decoration: BoxDecoration(
                                                          color: AppColors
                                                              .whiteColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Image.asset(
                                                            AppAssets.package,
                                                            fit: BoxFit.contain,
                                                            width: 16,
                                                            height: 16,
                                                          ),
                                                        ),
                                                      ),
                                                      padHorizontal(20),
                                                      const Label(
                                                        txt: "Packages",
                                                        type: TextTypes.f_12_700,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              padVertical(6),
                                              const Divider(),
                                              padVertical(6),
                                              GestureDetector(
                                                onTap: () async {
                                                  await Get.toNamed(
                                                      "/TrasactionHistory");
                                                  controller.getData();
                                                },
                                                behavior: HitTestBehavior.opaque,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 15),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: 40,
                                                        width: 40,
                                                        decoration: BoxDecoration(
                                                          color: AppColors
                                                              .whiteColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Image.asset(
                                                            AppAssets.playcoins,
                                                            fit: BoxFit.contain,
                                                            width: 16,
                                                            height: 16,
                                                          ),
                                                        ),
                                                      ),
                                                      padHorizontal(20),
                                                      const Label(
                                                        txt: "Play Coins",
                                                        type: TextTypes.f_12_700,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              padVertical(6),
                                              const Divider(),
                                              padVertical(6),
                                              GestureDetector(
                                                onTap: () async {
                                                  print(
                                                      "${controller.responseModel.value.data?.referrals?.code ?? ""}");
                                                  await Get.toNamed("/Referrals",
                                                      arguments: {
                                                        "code": controller
                                                                .responseModel
                                                                .value
                                                                .data
                                                                ?.referrals
                                                                ?.code ??
                                                            ""
                                                      });
                                                  controller.getData();
                                                },
                                                behavior: HitTestBehavior.opaque,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 15),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: 40,
                                                        width: 40,
                                                        decoration: BoxDecoration(
                                                          color: AppColors
                                                              .whiteColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Image.asset(
                                                            AppAssets.referal,
                                                            fit: BoxFit.contain,
                                                            width: 16,
                                                            height: 16,
                                                          ),
                                                        ),
                                                      ),
                                                      padHorizontal(20),
                                                      const Label(
                                                        txt: "Referrals",
                                                        type: TextTypes.f_12_700,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              padVertical(6),
                                              const Divider(),
                                              padVertical(6),
                                              // GestureDetector(
                                              //   onTap: () {
                                              //     Navigator.push(
                                              //       context,
                                              //       MaterialPageRoute(
                                              //         builder: (context) =>
                                              //         const PgVoucher(),
                                              //       ),
                                              //     );
                                              //   },
                                              //   behavior: HitTestBehavior.opaque,
                                              //   child: Container(
                                              //     padding: const EdgeInsets.symmetric(
                                              //         horizontal: 15),
                                              //     child: Row(
                                              //       children: [
                                              //         Container(
                                              //           height: 40,
                                              //           width: 40,
                                              //           decoration: BoxDecoration(
                                              //             color: AppColors.whiteColor,
                                              //             borderRadius:
                                              //             BorderRadius.circular(20),
                                              //           ),
                                              //           child: Align(
                                              //             alignment: Alignment.center,
                                              //             child: Image.asset(
                                              //               AppAssets.voucher,
                                              //               fit: BoxFit.contain,
                                              //               width: 16,
                                              //               height: 16,
                                              //             ),
                                              //           ),
                                              //         ),
                                              //         padHorizontal(20),
                                              //         const Label(
                                              //           txt: "Vouchers",
                                              //           type: TextTypes.f_12_700,
                                              //         ),
                                              //       ],
                                              //     ),
                                              //   ),
                                              // ),
                                              // padVertical(6),
                                              // const Divider(),
                                              // padVertical(6),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.toNamed("/PrivacyPolicy",
                                                      arguments: {
                                                        "title": "Privacy Policy"
                                                      });
                                                },
                                                behavior: HitTestBehavior.opaque,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 15),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: 40,
                                                        width: 40,
                                                        decoration: BoxDecoration(
                                                          color: AppColors
                                                              .whiteColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Image.asset(
                                                            AppAssets.privacy,
                                                            fit: BoxFit.contain,
                                                            width: 16,
                                                            height: 16,
                                                          ),
                                                        ),
                                                      ),
                                                      padHorizontal(20),
                                                      const Label(
                                                        txt: "Privacy Policy",
                                                        type: TextTypes.f_12_700,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              padVertical(6),
                                              const Divider(),
                                              padVertical(6),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.toNamed("/PrivacyPolicy",
                                                      arguments: {
                                                        "title":
                                                            "Terms & Conditions"
                                                      });
                                                },
                                                behavior: HitTestBehavior.opaque,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 15),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: 40,
                                                        width: 40,
                                                        decoration: BoxDecoration(
                                                          color: AppColors
                                                              .whiteColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Image.asset(
                                                            AppAssets.privacy,
                                                            fit: BoxFit.contain,
                                                            width: 16,
                                                            height: 16,
                                                          ),
                                                        ),
                                                      ),
                                                      padHorizontal(20),
                                                      const Label(
                                                        txt: "Terms & Conditions",
                                                        type: TextTypes.f_12_700,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              padVertical(6),
                                              const Divider(),
                                              padVertical(6),
                                              GestureDetector(
                                                onTap: () {
                                                  Get.defaultDialog(
                                                    title: "Logout",
                                                    titleStyle: TextStyle(
                                                      fontSize: 18.sp,
                                                      fontWeight: FontWeight.w600,
                                                      color: AppColors.primaryColor,
                                                    ),
                                                    middleText: "Are you sure you want to Logout?",
                                                    middleTextStyle: TextStyle(fontSize: 16.sp),
                                                    textConfirm: "Logout",
                                                    textCancel: "Cancel",
                                                    confirmTextColor: AppColors.whiteColor,
                                                    cancelTextColor: AppColors.primaryColor,
                                                    buttonColor: AppColors.primaryColor,
                                                    backgroundColor: AppColors.background,
                                                    radius: 10,
                                                    onConfirm: () async {
                                                      Get.closeAllSnackbars();

                                                      controller.logout();

                                                    },
                                                    onCancel: () {
                                                      // // Close the dialog without action

                                                    },
                                                  );

                                                },
                                                behavior: HitTestBehavior.opaque,
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.symmetric(
                                                          horizontal: 15),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        height: 40,
                                                        width: 40,
                                                        decoration: BoxDecoration(
                                                          color: AppColors
                                                              .whiteColor,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                        ),
                                                        child: Align(
                                                          alignment:
                                                              Alignment.center,
                                                          child: Image.asset(
                                                            AppAssets.logout,
                                                            fit: BoxFit.contain,
                                                            width: 16,
                                                            height: 16,
                                                          ),
                                                        ),
                                                      ),
                                                      padHorizontal(20),
                                                      const Label(
                                                        txt: "Logout",
                                                        type: TextTypes.f_12_700,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        padVertical(6),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSkeletonUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        padVertical(10),
        SkeletonAvatar(
          style: SkeletonAvatarStyle(
            width: 38.w,
            height: 29.h,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        padVertical(20),
        Center(
          child: SkeletonAvatar(
            style: SkeletonAvatarStyle(
              shape: BoxShape.circle,
              width: 158.w,
              height: 158.h,
            ),
          ),
        ),
        padVertical(20),
        Center(
          child: SkeletonLine(
            style: SkeletonLineStyle(
              height: 20.h,
              width: 150.w,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        padVertical(10),
        Center(
          child: SkeletonLine(
            style: SkeletonLineStyle(
              height: 12.h,
              width: 200.w,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        padVertical(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SkeletonLine(
                style: SkeletonLineStyle(
                  height: 50.h,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            padHorizontal(20),
            Expanded(
              child: SkeletonLine(
                style: SkeletonLineStyle(
                  height: 50.h,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ],
        ),
        padVertical(10),
        SkeletonLine(
          style: SkeletonLineStyle(
            height: 16.h,
            width: 100.w,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        padVertical(10),
        _buildSkeletonStatRow(),
        _buildSkeletonStatRow(),
        _buildSkeletonStatRow(),
        _buildSkeletonStatRow(),
        _buildSkeletonStatRow(),
        _buildSkeletonStatRow(),
        _buildSkeletonStatRow(),
        padVertical(20),
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
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          SkeletonLine(
            style: SkeletonLineStyle(
              height: 12.h,
              width: 50.w,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }
}
