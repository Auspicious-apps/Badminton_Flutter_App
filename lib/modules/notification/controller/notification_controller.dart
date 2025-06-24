import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badminton/repository/api_repository.dart';
import 'package:badminton/models/notification_model.dart';

import '../../courtscreens/models/booking_request_model.dart';

class NotificationController extends GetxController {
  final APIRepository _apiRepository = Get.find<APIRepository>();

  RxList<NotficationItem> notifications = <NotficationItem>[].obs;
  RxBool isLoading = false.obs;
  RxBool isLoadingMore = false.obs;
  RxBool hasError = false.obs;
  RxString errorMessage = ''.obs;
  RxInt Pageindex = 1.obs;
  RxBool hasMoreData = true.obs;
  
  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  // Initial fetch of notifications
  Future<void> fetchNotifications() async {
    Pageindex.value = 1;
    isLoading.value = true;
    hasError.value = false;

    try {
      final response = await _apiRepository.getNotifications(query: {"page": Pageindex.value, "limit": 10});
      if (response != null && response.data != null) {
        if (Pageindex.value == 1) {
          // Clear the list only on initial fetch (optional, depending on your use case)
          notifications.clear();
        }
        // Append new notifications to the existing list
        notifications.addAll(response.data!);

        // Check if there's more data to load
        // if (response.pagination != null) {
        //   hasMoreData.value = response.pagination!.page! < response.pagination!.pages!;
        // } else {
        //   hasMoreData.value = false;
        // }
      } else {
        hasError.value = true;
        errorMessage.value = 'No notifications found';
      }
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'Failed to load notifications: $e';
      debugPrint('Error fetching notifications: $e');
    } finally {
      isLoading.value = false;
    }
  }
  
  // Load more notifications
  Future<void> loadMoreNotifications() async {
    if (isLoadingMore.value || !hasMoreData.value) return;

    isLoadingMore.value = true;
    Pageindex.value++;

    try {
      final response = await _apiRepository.getNotifications(query: {"page": Pageindex.value, "limit": 10});
      if (response != null && response.data != null && response.data!.isNotEmpty) {
        notifications.addAll(response.data!);

        // Check if there's more data to load
        // if (response.pagination != null) {
        //   hasMoreData.value = response.pagination!.page! < response.pagination!.pages!;
        // } else {
        //   hasMoreData.value = false;
        // }
      } else {
        hasMoreData.value = false;
      }
    } catch (e) {
      debugPrint('Error loading more notifications: $e');
      Pageindex.value--; // Revert page index on error
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<void> markAsRead(String notificationId) async {
    try {
      Map<String, dynamic> requestModel =
      BookingRequestModel.notificationRead(notificationId: notificationId);
      final response = await _apiRepository.markNotificationAsRead(dataBody: requestModel);
      if (response != null) {
        fetchNotifications();

      }
    } catch (e) {
      debugPrint('Error marking notification as read: $e');
    }
  }

  void handleNotificationTap(NotficationItem notification) {
    // Mark as read
    if (notification.sId != null) {
      markAsRead(notification.sId!);
    }

    // Navigate based on notification type
    switch (notification.type) {
      case 'FREE_GAME_EARNED':
        if (notification.type != null) {
          Get.back();
        }
        break;
      case 'FRIEND_REQUEST':
        if (notification.referenceId != null) {
          Get.toNamed('userprofiledetail', arguments:  {"id":notification.referenceId ,"isAdmin":false});
        }
        break;
      // case 'order_update':
      //   if (notification.targetId != null) {
      //     Get.toNamed('/order_details', arguments: {'orderId': notification.targetId});
      //   }
      //   break;
      // case 'chat_message':
      //   if (notification.type != null) {
      //     Get.toNamed('/chat_screen', arguments: {'id': notification.});
      //   }
        break;
      default:
        // Do nothing or show details
        break;
    }
  }
}
