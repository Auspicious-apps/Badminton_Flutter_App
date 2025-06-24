import 'package:badminton/Pages/Notification/pg_notification.dart';
import 'package:badminton/modules/creategames/model/AllBookingsResponseModel.dart';
import 'package:get/get.dart';

import '../../../repository/api_repository.dart';
import '../../auth_module/models/user_response_model.dart';
import '../../courtscreens/models/BookingResponseModel.dart';
import '../../courtscreens/models/booking_request_model.dart';
import '../../home /controller/tab_home_controller.dart';
import '../../home /controller/tabplay_controller.dart';
import '../model/BookingResponseModel.dart';

class GetMyBookingsController extends GetxController {
  RxBool loading = false.obs;
  final APIRepository _apiRepository = Get.find<APIRepository>();
  Rx<UpcomingBookingResponseModel> bookList = UpcomingBookingResponseModel().obs;
  Rx<userResponseModel> responseModel = userResponseModel().obs;
  final matches = List.generate(
    4,
        (index) => {
      'sport': 'Padel',
      'duration': '90min',
      'type': 'Friendly Match',
      'location': 'Kemmer Trafficway, West Zenatown',
      'date': 'Nov 10, 2024 | 08:00 A.M.',
    },
  ).obs;

  // Navigate to Notification page
  void goToNotification() {
    // Get.to(() => const PgNotification());
  }
  @override
  void onInit() {
    getBookingList();
    getData();
    super.onInit();
  }


  Future getData () async {

    // loading.value=true;
    try {
      final response = await _apiRepository.getuser();
      if (response != null) {
        responseModel.value = response;
        responseModel.refresh();
        Get.put(TabHomeController()).getProfile();
        Get.put(PlayController()).getProfile();
        print("useremail>>>>>>>>>>>>>>>>>>: ${responseModel.value.data?.email}????????????");

      }
    } catch (e) {
      loading.value=false;
      Get.snackbar("Error", e.toString());
    }finally{
      loading.value=false;
    }

  }

  Future CancleBooking(String? BookingId)async {
    Get.back();

    loading.value=true;

    try {
      Map<String, dynamic> requestModel = BookingRequestModel.CancleBooking(bookingId: BookingId);

      final response = await _apiRepository.CancleBookingApi(dataBody:requestModel);
      if (response != null) {

        getBookingList();


      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.TOP);
      loading.value=false;
    }finally{
      loading.value=false;

    }
  }

   getBookingList()async {
    loading.value=true;
    Get.closeAllSnackbars(); //
    try {
      final response = await _apiRepository.getAllBookings();
      if (response != null) {
        bookList.value = response;
        bookList.refresh();

      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.TOP);
      loading.value=false;
    }finally{
      loading.value=false;
    }
  }


  // Example: Add logic for filters or joining a match
  void applyFilter(String filter) {
    // Implement filter logic here
    print('Filter applied: $filter');
  }

  // Example: Handle join match action
  void joinMatch(int index) {
    // Implement join match logic
    print('Joined match at index: $index');
  }
}