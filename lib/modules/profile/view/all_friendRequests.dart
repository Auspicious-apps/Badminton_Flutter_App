import 'package:badminton/app_settings/components/label.dart';
import 'package:badminton/app_settings/components/widget_global_margin.dart';
import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/constants/app_dim.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:get/get.dart';

import '../../../repository/endpoint.dart';
import '../controller/all_friend_requests_controller.dart';

class PgFriendRequests extends GetView<FriendRequestsController> {
  const PgFriendRequests({super.key});

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
                child: RefreshIndicator(
                  onRefresh: () async {
                    await controller.getFriendRequest(); // Fixed: Call the method
                  },
                  color: AppColors.primaryColor,
                  backgroundColor: AppColors.whiteColor,
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        padVertical(20),
                        Row(
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
                            padHorizontal(10),
                            const Label(
                              txt: "Friend Requests",
                              type: TextTypes.f_18_600,
                            ),
                          ],
                        ),
                        padVertical(40),
                        Obx(
                              () => controller.loading.value
                              ? _buildSkeletonUI()
                              : (controller.userdata.value.data?.requests ?? [])
                              .isNotEmpty
                              ? ListView.builder(
                            shrinkWrap: true,
                            physics:
                            const NeverScrollableScrollPhysics(),
                            itemCount: controller.userdata.value.data
                                ?.requests?.length ??
                                0,
                            itemBuilder: (context, index) {
                              final request = controller.userdata.value
                                  .data?.requests?[index];
                              return Container(
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
                                            children: [
                                      Container(
                                      height: 34,
                                        width: 34,
                                        padding: const EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          color: AppColors.lightGrey,
                                          borderRadius: BorderRadius.circular(45),
                                          border: Border.all(
                                            width: 2,
                                            color: AppColors.blue,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(45),
                                          child: (request?.profilePic != null &&
                                              request?.profilePic?.isNotEmpty==true)
                                              ? Image.network(
                                            "${imageBaseUrl}${request?.profilePic}",
                                            fit: BoxFit.cover,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Container(
                                                color: AppColors.lightGrey,
                                                child: Icon(
                                                  Icons.person, // Error image/icon
                                                  size: 20.sp,
                                                  color: AppColors.grey,
                                                ),
                                              );
                                            },
                                          )
                                              : Container(
                                            color: AppColors.lightGrey,
                                            child: Icon(
                                              Icons.person, // Default icon when no image
                                              size: 20.sp,
                                              color: AppColors.grey,
                                            ),
                                          ),
                                        ),
                                      ),
                                              padHorizontal(8),
                                              Label(
                                                txt: request?.fullName ??
                                                    "",
                                                type:
                                                TextTypes.f_14_700,
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () => controller
                                                    .cancelFriendRequest(
                                                    request
                                                        ?.relationshipId ??
                                                        ""),
                                                child: const Icon(
                                                  Icons
                                                      .cancel_outlined,
                                                  color: AppColors
                                                      .smalltxt,
                                                ),
                                              ),
                                              padHorizontal(10),
                                              GestureDetector(
                                                onTap: () => controller
                                                    .confirmFriendRequest(
                                                    request
                                                        ?.relationshipId),
                                                child: Container(
                                                  padding:
                                                  const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 15,
                                                    vertical: 5,
                                                  ),
                                                  decoration:
                                                  BoxDecoration(
                                                    color:
                                                    AppColors.blue2,
                                                    borderRadius:
                                                    BorderRadius
                                                        .circular(
                                                        15),
                                                  ),
                                                  child: const Label(
                                                    txt: "Confirm",
                                                    type: TextTypes
                                                        .f_10_600,
                                                    forceColor: AppColors
                                                        .whiteColor,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    padVertical(8),
                                    index ==
                                        ((controller.userdata.value
                                            .data
                                            ?.requests
                                            ?.length ??
                                            0) -
                                            1)
                                        ? SizedBox()
                                        : const Divider(),
                                    padVertical(8),
                                  ],
                                ),
                              );
                            },
                          )
                              : Container(
                            height: Get.height * 0.2,
                            child: Center(
                                child: Text("No Requests Found")),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeletonUI() {
    return SizedBox(
      height: Get.height * 0.5, // Constrain height to avoid layout issues
      child: SkeletonListView(
        itemCount: 5, // Number of skeleton items
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                          width: 24.w,
                          height: 24.h,
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      padHorizontal(10),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 30.h,
                          width: 80.w,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              padVertical(8),
              index == 4 ? SizedBox() : const Divider(),
              padVertical(8),
            ],
          ),
        ),
      ),
    );
  }
}