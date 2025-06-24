import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/modules/notification/controller/notification_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../../app_settings/components/label.dart';
import '../../../app_settings/constants/app_assets.dart';
import '../../../app_settings/constants/app_dim.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationController());
    final ScrollController scrollController = ScrollController();

    // Add listener to detect when user reaches the end of the list
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent * 0.9 &&
          !controller.isLoadingMore.value &&
          controller.hasMoreData.value) {
        controller.loadMoreNotifications();
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => controller.fetchNotifications(),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      controller: scrollController, // Attach ScrollController
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          padVertical(10),
                          // Header with back button and title
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                child: GestureDetector(
                                  onTap: () => {Get.back()},
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
                              ),
                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 15),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Label(
                                        txt: "Notifications",
                                        type: TextTypes.f_20_600,
                                      ),
                                      // Mark all as read button (commented out for now)
                                      GestureDetector(
                                        onTap: () {
                                          controller.markAsRead("");

                                        },
                                        child: Row(children: [
                                          Image.asset(
                                            AppAssets.read,
                                            fit: BoxFit.contain,
                                            width: 14,
                                            height: 7,
                                          ),
                                          padHorizontal(5),
                                          const Label(
                                            txt: "Mark All As Read",
                                            type: TextTypes.f_12_700,
                                            forceColor: AppColors.blue,
                                          )
                                        ]),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                          padVertical(20),
                          // Notifications content
                          Obx(() {
                            if (controller.isLoading.value) {
                              return _buildLoadingIndicator();
                            } else if (controller.hasError.value) {
                              return _buildErrorWidget(controller);
                            } else if (controller.notifications.isEmpty) {
                              return _buildEmptyNotifications();
                            } else {
                              return Column(
                                children: [
                                  _buildNotificationsList(controller),
                                  // Show loading indicator at the bottom when loading more
                                  Obx(() => controller.isLoadingMore.value
                                      ? Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                                      ),
                                    ),
                                  )
                                      : const SizedBox.shrink()),
                                ],
                              );
                            }
                          }),
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

  Widget _buildLoadingIndicator() {
    return Container(
      height: 200,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(),
    );
  }

  Widget _buildErrorWidget(NotificationController controller) {
    return Container(
      height: 300,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: AppColors.grey),
          padVertical(10),
          Label(
            txt: controller.errorMessage.value,
            type: TextTypes.f_14_500,
            forceColor: AppColors.smalltxt,
          ),
          padVertical(20),
          ElevatedButton(
            onPressed: () => controller.fetchNotifications(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyNotifications() {
    return Container(
      height: 300,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            AppAssets.notificationcancle,
            height: 80,
            width: 80,
          ),
          padVertical(16),
          const Label(
            txt: "No Notifications Yet",
            type: TextTypes.f_16_600,
            forceColor: AppColors.smalltxt,
          ),
          padVertical(8),
          const Label(
            txt: "You don't have any notifications at the moment",
            type: TextTypes.f_14_400,
            forceColor: AppColors.smalltxt,
          ),
        ],
      ),
    );
  }

  Widget _buildNotificationsList(NotificationController controller) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: controller.notifications.length,
      itemBuilder: (context, index) {
        final notification = controller.notifications[index];
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              child: GestureDetector(
                onTap: () => controller.handleNotificationTap(notification),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Notification icon
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Container(
                        width: 50,
                        height: 50,
                        color: AppColors.lightGrey,
                        child: Image.asset(
                          _getNotificationIcon(notification.type),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    padHorizontal(12),
                    // Notification content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Label(
                                  txt: notification.title ?? "Notification",
                                  type: TextTypes.f_14_700,
                                ),
                              ),
                              if (notification.isRead == false)
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ).marginSymmetric(horizontal: 20),
                            ],
                          ),
                          padVertical(4),
                          Label(
                            maxLines: 2,
                            txt: notification.message ?? "",
                            type: TextTypes.f_12_400,
                            forceColor: AppColors.smalltxt,
                          ),
                          padVertical(4),
                          Label(
                            maxLines: 4,
                            txt: _formatTimestamp(notification.createdAt),
                            type: TextTypes.f_10_400,
                            forceColor: AppColors.smalltxt,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (index < controller.notifications.length - 1)
              const Divider(height: 1, thickness: 1, indent: 15, endIndent: 15),
          ],
        );
      },
    );
  }

  String _getNotificationIcon(String? type) {
    switch (type) {
      case "PAYMENT_SUCCESSFUL":
        return AppAssets.notificationPayment;
      case "FREE_GAME_EARNED":
        return AppAssets.notificationfreegame;
        case "FREE_GAME_USED":
        return AppAssets.notificationfreegame;
      case "PLAYER_JOINED_GAME":
        return AppAssets.notificationPlayer;
      case "FRIEND_REQUEST":
        return AppAssets.newfriend;
      case "CUSTOM":
        return AppAssets.customicon;
      default:
        return AppAssets.notificationcancle;
    }
  }

  String _formatTimestamp(String? timestamp) {
    if (timestamp == null) return "";

    try {
      final DateTime dateTime = DateTime.parse(timestamp);
      final DateTime now = DateTime.now();
      final Duration difference = now.difference(dateTime);

      if (difference.inDays > 7) {
        return DateFormat('MMM d, yyyy').format(dateTime);
      } else if (difference.inDays > 0) {
        return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} ${difference.inMinutes == 1 ? 'minute' : 'minutes'} ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return timestamp;
    }
  }
}