import 'package:badminton/app_settings/components/label.dart';
import 'package:badminton/app_settings/components/widget_global_margin.dart';
import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/constants/app_dim.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';

import '../../../repository/endpoint.dart';
import '../controllers/messaging_controller.dart';

class PgMessages extends GetView<MessagesController> {
  const PgMessages({super.key});

  String timeAgo(DateTime timestamp) {
    final now = DateTime.now().toUtc();
    final difference = now.difference(timestamp);
    final seconds = difference.inSeconds;

    if (seconds >= 31536000) {
      final years = (seconds / 31536000).floor();
      return years == 1 ? '$years year ago' : '$years years ago';
    } else if (seconds >= 2592000) {
      final months = (seconds / 2592000).floor();
      return months == 1 ? '$months month ago' : '$months months ago';
    } else if (seconds >= 86400) {
      final days = (seconds / 86400).floor();
      return days == 1 ? '$days day ago' : '$days days ago';
    } else if (seconds >= 3600) {
      final hours = (seconds / 3600).floor();
      return hours == 1 ? '$hours hour ago' : '$hours hours ago';
    } else if (seconds >= 60) {
      final minutes = (seconds / 60).floor();
      return minutes == 1 ? '$minutes minute ago' : '$minutes minutes ago';
    } else if (seconds >= 1) {
      return seconds == 1 ? '$seconds second ago' : '$seconds seconds ago';
    } else {
      return 'just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: WidgetGlobalMargin(
          child: RefreshIndicator(
            color: AppColors.primaryColor, // Color of the refresh indicator
            backgroundColor: AppColors.whiteColor, // Background of the refresh circle
            displacement: 40.0, // Distance from top where refresh triggers
            onRefresh: () async {
              try {
                // Reset loading state and fetch fresh data
                controller.loading.value = true;
                await controller.getChatList();
                // Optional: Show a success snackbar

              } catch (e) {
                // Handle errors during refresh
                Get.snackbar(
                  'Error',
                  'Failed to refresh messages: $e',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: AppColors.whiteColor,
                  duration: const Duration(seconds: 3),
                );
              } finally {
                controller.loading.value = false;
              }
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(), // Ensures pull-to-refresh works even when content fits screen
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  padVertical(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                          padHorizontal(15),
                          const Label(
                            txt: "Messages",
                            type: TextTypes.f_18_600,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.toNamed("/allusers");
                            },
                            child: const Icon(
                              Icons.search,
                              color: AppColors.smalltxt,
                            ),
                          ),
                          padHorizontal(10),
                          const Icon(
                            Icons.more_vert,
                            color: AppColors.smalltxt,
                          ),
                        ],
                      ),
                    ],
                  ),
                  padVertical(20),
                  Obx(
                        () => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              controller.setSelectedIndex(0);
                              controller.getChatList();
                            },
                            child: Container(
                              height: 44,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                color: controller.selectedIndex.value == 0
                                    ? AppColors.primaryColor
                                    : AppColors.lightGrey,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Label(
                                  txt: "Messages",
                                  type: TextTypes.f_12_500,
                                  forceColor: controller.selectedIndex.value == 0
                                      ? AppColors.whiteColor
                                      : AppColors.smalltxt,
                                ),
                              ),
                            ),
                          ),
                        ),
                        padHorizontal(20),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              controller.setSelectedIndex(1);
                              controller.getChatList();
                            },
                            child: Container(
                              height: 44,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              decoration: BoxDecoration(
                                color: controller.selectedIndex.value == 1
                                    ? AppColors.primaryColor
                                    : AppColors.lightGrey,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Label(
                                  txt: "Groups",
                                  type: TextTypes.f_12_500,
                                  forceColor: controller.selectedIndex.value == 1
                                      ? AppColors.whiteColor
                                      : AppColors.smalltxt,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  padVertical(20),
                  Obx(
                        () => controller.loading.value
                        ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 5, // Show 5 skeleton items
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SkeletonAvatar(
                                    style: SkeletonAvatarStyle(
                                      shape: BoxShape.circle,
                                      width: 50,
                                      height: 50,
                                    ),
                                  ),
                                  padHorizontal(10),
                                  SizedBox(
                                    width: Get.width * 0.4,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        SkeletonLine(
                                          style: SkeletonLineStyle(
                                            height: 16,
                                            width: Get.width * 0.3,
                                            borderRadius:
                                            BorderRadius.circular(8),
                                          ),
                                        ),
                                        padVertical(2),
                                        SkeletonLine(
                                          style: SkeletonLineStyle(
                                            height: 14,
                                            width: Get.width * 0.35,
                                            borderRadius:
                                            BorderRadius.circular(8),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SkeletonLine(
                                style: SkeletonLineStyle(
                                  height: 12,
                                  width: 60,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    )
                        :controller.chatmessages.value.data?.chats?.length==0?Container(height: Get.height*0.2,child: Center(child:Label(txt: "No Chat Found", type: TextTypes.f_14_600)),) :ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.chatmessages.value.data?.chats?.length,
                      itemBuilder: (context, index) {
                        final chat = controller.chatmessages.value.data?.chats?[index];
                        return GestureDetector(
                          onTap: () async {
                            await Get.toNamed("/chat_screen",
                                arguments: {
                                  "id": controller
                                      .chatmessages.value.data?.chats?[index].sId
                                });
                            controller.getChatList();
                          },
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: AppColors.primaryColor,
                                          width: 1,
                                        ),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(45.r),
                                        child: (chat?.recipientProfilePic != null &&
                                            chat?.recipientProfilePic!.isNotEmpty == true)
                                            ? Image.network(
                                          "$imageBaseUrl${chat?.recipientProfilePic}",
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child, loadingProgress) {
                                            if (loadingProgress == null) return child;
                                            return Container(
                                              color: AppColors.lightGrey,
                                              child: const Center(
                                                child: CircularProgressIndicator(
                                                  color: AppColors.primaryColor,
                                                ),
                                              ),
                                            );
                                          },
                                          errorBuilder: (context, error, stackTrace) {
                                            return Container(
                                              color: AppColors.lightGrey,
                                              child: Icon(
                                                Icons.person,
                                                size: 30.sp,
                                                color: AppColors.grey,
                                              ),
                                            );
                                          },
                                        )
                                            : Container(
                                          color: AppColors.lightGrey,
                                          child: Icon(
                                            Icons.person,
                                            size: 30.sp,
                                            color: AppColors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                    padHorizontal(10),
                                    SizedBox(
                                      width: Get.width * 0.4,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Label(
                                            maxLines: 2,
                                            txt:
                                            "${controller.selectedIndex == 0 ? chat?.recipientName ?? "" : chat?.groupName ?? ""}",
                                            type: TextTypes.f_14_600,
                                          ),
                                          padVertical(2),
                                          chat?.lastMessage?.content != null ||
                                              chat?.lastMessage?.content?.isNotEmpty == true
                                              ? Label(
                                            txt: chat?.lastMessage?.content ?? "",
                                            type: TextTypes.f_14_400,
                                            forceColor: AppColors.smalltxt,
                                          )
                                              : SizedBox(),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                chat?.lastMessage?.timestamp != null ||
                                    chat?.lastMessage?.timestamp?.isNotEmpty == true
                                    ? Label(
                                  txt: timeAgo(DateTime.parse(
                                      chat?.lastMessage?.timestamp ?? '')),
                                  type: TextTypes.f_12_400,
                                  forceColor: AppColors.smalltxt,
                                )
                                    : SizedBox(),
                              ],
                            ),
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
    );
  }
}