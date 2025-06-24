
import 'package:badminton/app_settings/components/label.dart';
import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/constants/app_const.dart';
import 'package:badminton/app_settings/constants/app_dim.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import '../../../repository/endpoint.dart';
import '../controllers/Chat_Controller.dart';

class PgChatView extends GetView<ChatController> {
  PgChatView({super.key});

  final TextEditingController _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
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
                      Label(
                        txt: "Messages",
                        type: TextTypes.f_18_600,
                      ).paddingOnly(left: 20.w),
                    ],
                  ),
                ],
              ),
            ),

            // // Typing Indicator
            // Obx(() => controller.typingUser.value.isNotEmpty
            //   ? Padding(
            //       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            //       child: Text(
            //         "Typing...",
            //         style: TextStyle(
            //           fontSize: 12,
            //           color: Colors.grey,
            //           fontStyle: FontStyle.italic,
            //         ),
            //       ),
            //     )
            //   : SizedBox.shrink()
            // ),

            // Chat messages or Shimmer effect
            Obx(() {
              if (controller.loading.value==true) {
                // Show shimmer effect when loading or data is null
                return Expanded(
                  child: SkeletonListView(
                    itemCount: 6,
                    itemBuilder: (context, index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 5.h),
                      child: Row(
                        mainAxisAlignment: index % 2 == 0
                            ? MainAxisAlignment.start
                            : MainAxisAlignment.end,
                        children: [
                          Flexible(
                            child: SizedBox(
                              width: Get.width * 0.7, // Match message bubble width
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  if (index % 2 == 0) ...[
                                    SkeletonAvatar(
                                      style: SkeletonAvatarStyle(
                                        shape: BoxShape.circle,
                                        width: 28.w,
                                        height: 28.h,
                                      ),
                                    ),
                                    SizedBox(width: 5.w),
                                  ],
                                  Flexible(
                                    child: SkeletonParagraph(
                                      style: SkeletonParagraphStyle(
                                        lines: 2,
                                        padding: EdgeInsets.all(12.w),
                                        lineStyle: SkeletonLineStyle(
                                          randomLength: true,
                                          height: 14.h,
                                          borderRadius: BorderRadius.circular(10.r),
                                          maxLength: 200.w,
                                          minLength: 100.w,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              } else if (controller.chatMessages.value.data?.messages?.isEmpty??true) {
                // Show empty state when there are no messages
                return const Expanded(
                  child: Center(
                    child: Label(
                      txt: "No messages yet",
                      type: TextTypes.f_14_400,
                      forceColor: AppColors.grey,
                    ),
                  ),
                );
              } else {
                // Show chat messages
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.chatMessages.value.data!.messages!.length,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemBuilder: (context, index) {
                      final message = controller.chatMessages.value.data!.messages![index];
                      final isMe = message.sender?.sId == controller.chatMessages.value.myId;

                      return Align(
                        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment:
                          isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                          children: [
                            if (isMe) ...[
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 5.h),
                                padding: EdgeInsets.all(12.w),
                                constraints: BoxConstraints(maxWidth: Get.width * 0.7),
                                decoration: BoxDecoration(
                                  color: AppColors.blue2,
                                  borderRadius: BorderRadius.circular(10.r).copyWith(
                                    topRight: Radius.zero,
                                    topLeft: Radius.circular(10.r),
                                  ),
                                ),
                                child: Label(
                                  txt: message.content ?? "No content",
                                  type: TextTypes.f_14_500,
                                  forceColor: AppColors.whiteColor,
                                  maxLines: 100,
                                ),
                              ),
                            ] else ...[
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // Navigate to profile page if needed
                                      // Get.to(() => PgProfileDetail(userId: message.sender?.sId));
                                    },
                                    child: Container(
                                      height: 34.h,
                                      width: 34.w,
                                      padding: EdgeInsets.all(2.w),
                                      decoration: BoxDecoration(
                                        color: AppColors.lightGrey,
                                        borderRadius: BorderRadius.circular(45.r),
                                        border: Border.all(
                                          width: 2.w,
                                          color: AppColors.blue,
                                        ),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(45.r),
                                        child: (message.sender?.profilePic != null &&
                                            message.sender!.profilePic!.isNotEmpty)
                                            ? Image.network(
                                          "$imageBaseUrl${message.sender!.profilePic}",
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
                                                Icons.broken_image,
                                                size: 20.sp,
                                                color: AppColors.grey,
                                              ),
                                            );
                                          },
                                        )
                                            : Container(
                                          color: AppColors.lightGrey,
                                          child: Icon(
                                            Icons.person,
                                            size: 20.sp,
                                            color: AppColors.grey,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5.w),
                                  Container(
                                    margin: EdgeInsets.symmetric(vertical: 5.h),
                                    padding: EdgeInsets.all(12.w),
                                    constraints: BoxConstraints(maxWidth: Get.width * 0.7),
                                    decoration: BoxDecoration(
                                      color: const Color(0x19176DBF),
                                      borderRadius: BorderRadius.circular(10.r).copyWith(
                                        topRight: Radius.circular(10.r),
                                        topLeft: Radius.zero,
                                      ),
                                    ),
                                    child: Label(
                                      txt: message.content ?? "No content",
                                      type: TextTypes.f_14_500,
                                      forceColor: AppColors.blackColor,
                                      maxLines: 100,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                            // Timestamp (uncomment and implement timeAgo if needed)
                            // Label(
                            //   txt: timeAgo(DateTime.parse(message.createdAt ?? DateTime.now().toString())),
                            //   type: TextTypes.f_12_400,
                            //   forceColor: AppColors.smalltxt,
                            // ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
            }),

            // Message input field
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        borderRadius: BorderRadius.circular(25.r),
                      ),
                      child: TextField(
                        controller: _messageController,
                        decoration: const InputDecoration(
                          hintText: 'Type a message...',
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          final chatId = Get.arguments?["id"] ?? "";
                          // if (chatId.isNotEmpty) {
                          //   controller.setTypingStatus(chatId, value.isNotEmpty);
                          // }
                        },
                        style: const TextStyle(
                          color: AppColors.blackColor,
                          fontFamily: AppConst.fontFamily,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  IconButton(
                    icon: const Icon(Icons.send, color: AppColors.primaryColor),
                    onPressed: () {
                      final chatId = Get.arguments?["id"] ?? "";
                      if (_messageController.text.isNotEmpty && chatId.isNotEmpty) {
                        controller.sendMessage(chatId, _messageController.text);
                        _messageController.clear();
                        // controller.setTypingStatus(chatId, false);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
