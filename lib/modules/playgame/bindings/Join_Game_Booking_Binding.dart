import 'package:get/get.dart';

import '../controller/Join_Game_Booking_Controller.dart';




class PgJoinPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JoinConfirmPaymentController>(() => JoinConfirmPaymentController());
  }
}