import 'package:badminton/modules/creategames/controller/get_all_bookings_controller.dart';
import 'package:get/get.dart';



class GetAllBookingsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetAllBookingsController>(() => GetAllBookingsController());
  }
}
