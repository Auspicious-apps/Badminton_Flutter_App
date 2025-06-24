import 'package:badminton/modules/auth_module/models/forget_password_responsemodel.dart';
import 'package:badminton/modules/courtscreens/models/BookingResponseModel.dart';
import 'package:badminton/modules/courtscreens/models/Payment_ResponseModel.dart';
import 'package:badminton/modules/courtscreens/models/booking_request_model.dart';
import 'package:badminton/modules/home%20/controller/tab_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:super_tooltip/super_tooltip.dart';

import '../../../repository/api_repository.dart';
import '../../auth_module/models/auth_requestmodel.dart';
import '../../auth_module/models/user_response_model.dart';
import '../../home /controller/tab_more_controller.dart';
import '../models/BookingDetailResponseModel.dart';

class BookingDetailController extends GetxController {
  late Razorpay _razorpay;
  RxBool askToJoin = false.obs;
  RxBool isCompetitive = false.obs;
  RxDouble skillRequired = 0.0.obs;
  RxList<Map<String, String>> team1 = <Map<String, String>>[].obs;
  RxList<Map<String, String>> team2 = <Map<String, String>>[].obs;
  RxString venueId = ''.obs;
  RxBool isCancellationExpanded = false.obs;
  final tooltipcontroller = SuperTooltipController();
  final equipment = SuperTooltipController();
  RxString courtId = ''.obs;
  RxString image = ''.obs;
  RxString bookingDate = ''.obs;
  RxList<String> bookingSlots = <String>[].obs;
  RxString bookingType = ''.obs;
  var selectedButton2 = 0.obs;
  RxBool loading = false.obs;
  final APIRepository _apiRepository = Get.find<APIRepository>();
  RxInt RacketA = 0.obs;
  RxInt RacketB = 0.obs;
  RxInt RacketC = 0.obs;
  RxInt RacketD = 0.obs;
  RxInt Balls = 0.obs;
  RxBool selectedRacketA = false.obs;
  RxBool selectedRacketB = false.obs;
  RxBool selectedRacketC = false.obs;
  RxBool selectedRacketD = false.obs;
  RxBool selectedBalls = false.obs;
  RxBool PayBooking = false.obs;
  RxBool isLoading = false.obs;
  var PaymentMethod = "Play Coins".obs;
  // Variables for additional arguments
  RxString selectedGame = ''.obs;
  RxString address = ''.obs;
  RxString rate = ''.obs;
  RxString Hourlyrate = ''.obs;
  Rx<BookingDetailModel> bookingResponseModel = BookingDetailModel().obs;
  RxBool isCancel = false.obs;
  @override
  void onInit() {
    if (Get.arguments != null) {
      final id = Get.arguments["id"];
      isCancel.value=Get.arguments["isCancel"];

      fetchBookingDetailApi(id);
    }

    super.onInit();
  }

  Future CancleBooking(String? BookingId) async {
    Get.back();
    loading.value = true;
    try {
      Map<String, dynamic> requestModel =
          BookingRequestModel.CancleBooking(bookingId: BookingId);

      final response =
          await _apiRepository.CancleBookingApi(dataBody: requestModel);
      if (response != null) {
        fetchBookingDetailApi(BookingId);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.TOP);
      loading.value = false;
    } finally {
      loading.value = false;
    }
  }

  Future fetchBookingDetailApi(id) async {
    try {
      // Set loading state to true
      isLoading.value = true;

      // Fetch notifications from API
      final response = await _apiRepository.getBookingDetailApi(id: id);

      // Check if response and data are valid
      if (response != null) {
        bookingResponseModel.value = response;
        bookingResponseModel.refresh();
      }
    } catch (e) {
      // Log error and show user-friendly message
      print(e);
      Get.snackbar(
        'Error',
        'Failed to fetch packages. Please try again.',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      // Reset loading state
      isLoading.value = false;
    }
  }
}
