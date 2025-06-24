import 'package:badminton/modules/courtscreens/controller/booking_detail_controller.dart';
import 'package:get/get.dart';

import '../controller/confirm_payment_controller.dart';


class BookingDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BookingDetailController>(() => BookingDetailController());
  }
}