import 'dart:async';

import 'package:badminton/app_settings/components/label.dart';
import 'package:badminton/app_settings/components/widget_global_margin.dart';
import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/constants/app_dim.dart';
import 'package:badminton/modules/profile/controller/allusers_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:get/get.dart';

import '../../../repository/endpoint.dart';

class AllUsers extends GetView<AllUsersController> {
  const AllUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: WidgetGlobalMargin(
                child: SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      padVertical(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
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
                          SizedBox(width: 20),
                          const Label(
                            txt: "All Users",
                            type: TextTypes.f_18_600,
                          ),
                        ],
                      ),
                      padVertical(10),
                      SizedBox(
                        height: 50,
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search friends...',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            filled: true,
                            fillColor: AppColors.whiteColor,
                          ),
                          onChanged: (value) {
                            controller.searchQuery.value = value;
                            controller.searchQuery.refresh();
                            // Cancel the previous timer if it exists
                            if (controller.debounce?.isActive ?? false) {
                              controller.debounce?.cancel();
                            }
                            // Start a new timer
                            controller.debounce = Timer(
                              const Duration(milliseconds: 500),
                              () {
                                // Call API after debounce duration
                                controller.getVenueData();
                              },
                            );
                          },
                        ),
                      ),
                      padVertical(20),
                      Obx(
                        () => controller.loading.value
                            ? SizedBox(
                                height: Get
                                    .height, // Provide a fixed height for skeleton
                                child: SkeletonListView(
                                  itemCount: 5, // Number of skeleton items
                                  itemBuilder: (context, index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                SkeletonAvatar(
                                                  style: SkeletonAvatarStyle(
                                                    shape: BoxShape.circle,
                                                    width: 35.w,
                                                    height: 35.h,
                                                  ),
                                                ),
                                                padHorizontal(8),
                                                SkeletonLine(
                                                  style: SkeletonLineStyle(
                                                    height: 14.h,
                                                    width: 100.w,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SkeletonLine(
                                              style: SkeletonLineStyle(
                                                height: 14.h,
                                                width: 80.w,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            ),
                                          ],
                                        ),
                                        padVertical(8),
                                        const Divider(),
                                        padVertical(8),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : (controller.allUsers.value.data?.length ?? 0) > 0
                                ? ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: controller
                                            .allUsers.value.data?.length ??
                                        0,
                                    itemBuilder: (context, index) {
                                      final request = controller
                                          .allUsers.value.data?[index];
                                      return GestureDetector(
                                        onTap: () {
                                          Get.toNamed('/userprofiledetail',
                                              arguments: {
                                                "id": request?.sId ?? "",
                                                "isAdmin": false
                                              });
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(),
                                          child: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 15),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          height: 34,
                                                          width: 34,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(2),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppColors
                                                                .lightGrey,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        45),
                                                            border: Border.all(
                                                              width: 2,
                                                              color: AppColors
                                                                  .blue,
                                                            ),
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        45),
                                                            child: (request?.profilePic !=
                                                                        null &&
                                                                    request?.profilePic
                                                                            ?.isNotEmpty ==
                                                                        true)
                                                                ? Image.network(
                                                                    "${imageBaseUrl}${request?.profilePic}",
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    errorBuilder:
                                                                        (context,
                                                                            error,
                                                                            stackTrace) {
                                                                      return Container(
                                                                        color: AppColors
                                                                            .lightGrey,
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .person, // Error image/icon
                                                                          size:
                                                                              20.sp,
                                                                          color:
                                                                              AppColors.grey,
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
                                                                      size:
                                                                          20.sp,
                                                                      color: AppColors
                                                                          .grey,
                                                                    ),
                                                                  ),
                                                          ),
                                                        ),
                                                        padHorizontal(8),
                                                        Label(
                                                          txt: request
                                                                  ?.fullName ??
                                                              "",
                                                          type: TextTypes
                                                              .f_14_700,
                                                        ),
                                                      ],
                                                    ),
                                                    Label(
                                                      txt: request?.isFriend ==
                                                              true
                                                          ? "Already Friend"
                                                          : "",
                                                      type: TextTypes.f_14_700,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              padVertical(8),
                                              const Divider(),
                                              padVertical(8),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : Container(
                                    height: Get.height * 0.2,
                                    child: Center(child: Text("No User Found")),
                                  ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
