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
import '../controller/blocklist_controler.dart';

class PgBlockList extends GetView<BlockListController> {
  const PgBlockList({super.key});

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
                    await controller.getBlockList();
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
                              onTap: controller.goBack,
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
                              txt: 'Blocklist',
                              type: TextTypes.f_18_600,
                            ),
                          ],
                        ),
                        padVertical(20),
                        Obx(
                              () => controller.loading.value
                              ? _buildSkeletonUI()
                              : (controller.userdata.value.data ?? []).isEmpty
                              ? Container(
                            height: Get.height * 0.6,
                            child: const Center(
                              child: Text('No Data Found'),
                            ),
                          )
                              : ListView.builder(
                            shrinkWrap: true,
                            physics:
                            const NeverScrollableScrollPhysics(),
                            itemCount: controller
                                .userdata.value.data?.length ??
                                0,
                            itemBuilder: (context, index) {
                              final item = controller
                                  .userdata.value.data?[index];
                              return Container(
                                decoration: const BoxDecoration(),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding:
                                      const EdgeInsets.symmetric(
                                        horizontal: 15,
                                      ),
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
                                          child: (item?.profilePic != null &&
                                              item?.profilePic?.isNotEmpty==true)
                                              ? Image.network(
                                            "${imageBaseUrl}${item?.profilePic}",
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
                                                txt:
                                                item?.fullName ??
                                                    '',
                                                type:
                                                TextTypes.f_14_700,
                                              ),
                                            ],
                                          ),
                                          PopupMenuButton<String>(
                                            icon: const Icon(
                                              Icons.more_vert,
                                              color: AppColors
                                                  .primaryColor,
                                            ),
                                            onSelected: (value) {
                                              if (value == 'unblock') {
                                                controller
                                                    .blockFriend(
                                                  item?.blockedUserId,
                                                );
                                              }
                                            },
                                            itemBuilder: (context) => [
                                              const PopupMenuItem<
                                                  String>(
                                                value: 'unblock',
                                                child: Text('Unblock'),
                                              ),
                                            ],
                                            color: AppColors.whiteColor,
                                            shape:
                                            RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius
                                                  .circular(8),
                                            ),
                                            offset: const Offset(0, 40),
                                          ),
                                        ],
                                      ),
                                    ),
                                    padVertical(8),
                                    index ==
                                        (controller.userdata.value
                                            .data?.length ??
                                            0) -
                                            1
                                        ? const SizedBox()
                                        : const Divider(),
                                    padVertical(8),
                                  ],
                                ),
                              );
                            },
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
      height: Get.height * 0.6,
      child: SkeletonListView(
        itemCount: 5,
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
                  SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                      shape: BoxShape.circle,
                      width: 24.w,
                      height: 24.h,
                    ),
                  ),
                ],
              ),
              padVertical(8),
              index == 4 ? const SizedBox() : const Divider(),
              padVertical(8),
            ],
          ),
        ),
      ),
    );
  }
}