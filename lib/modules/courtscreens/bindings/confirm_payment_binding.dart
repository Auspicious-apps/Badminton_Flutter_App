import 'package:get/get.dart';

import '../controller/confirm_payment_controller.dart';


class PgConfirmPaymentBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConfirmPaymentController>(() => ConfirmPaymentController());
  }
}