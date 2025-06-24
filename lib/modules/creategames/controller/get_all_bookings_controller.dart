import 'package:badminton/Pages/Notification/pg_notification.dart';
import 'package:badminton/modules/creategames/model/AllBookingsResponseModel.dart';
import 'package:get/get.dart';

import '../../../repository/api_repository.dart';
import '../../courtscreens/models/booking_request_model.dart';

class GetAllBookingsController extends GetxController {
  RxBool loading = false.obs;
  final APIRepository _apiRepository = Get.find<APIRepository>();
  Rx<AllBookingResponseModel> bookingList = AllBookingResponseModel().obs;
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




  void goToNotification() {
    // Get.to(() => const PgNotification());
  }

  @override
  void onInit() {
   getBookingList();
    super.onInit();
  }

  void getBookingList()async {
    loading.value=true;
    Get.closeAllSnackbars(); //
    try {
      final response = await _apiRepository.uploadScoreBooking();
      if (response != null) {
        bookingList.value = response;
        loading.value=false;

      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.TOP);
      loading.value=false;
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