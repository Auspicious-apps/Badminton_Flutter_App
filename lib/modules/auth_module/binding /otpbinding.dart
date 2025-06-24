import 'package:get/get.dart';

import '../controller/otp_controller.dart';


class OtpVerificationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OtpVerificationController>(() => OtpVerificationController());
  }
}
