import 'package:badminton/modules/creategames/controller/Get_my_bookings_cotroller.dart';
import 'package:badminton/modules/creategames/controller/get_all_bookings_controller.dart';
import 'package:get/get.dart';



class GetMyBookingsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GetMyBookingsController>(() => GetMyBookingsController());
  }
}
