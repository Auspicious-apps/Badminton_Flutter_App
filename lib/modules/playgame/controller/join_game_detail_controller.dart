import 'package:get/get.dart';
import '../../../repository/api_repository.dart';
import '../model/join_Booking_detail.dart';

class PgJoinGameDetailController extends GetxController {
  RxBool loading = true.obs;
  RxBool team1select = false.obs;

  RxBool team2select = false.obs;
  final APIRepository _apiRepository = Get.find<APIRepository>();

  RxString Hourlyrate = ''.obs;
  Rx<JoinBookingDetail> bookingResponseModel = JoinBookingDetail().obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      print(">>>>>>>>>>>>>>>>>>>>${Get.arguments["id"]}");
      final id=Get.arguments["id"];
      getBookingDetail(id);

    }
  }


  Future getBookingDetail(id) async {
    loading.value=true;
    try {
      final response = await _apiRepository.getjoinBookingDetail(Id: id);
      if (response != null) {
        bookingResponseModel.value = response;
        bookingResponseModel.refresh();
        print(bookingResponseModel.value.data?.courtId?.games);

      }
    } catch (e) {
      loading.value=false;
      Get.snackbar("Error", e.toString());
    }finally{
      loading.value=false;
    }

  }




}
