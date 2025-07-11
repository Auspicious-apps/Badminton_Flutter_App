import 'package:get/get.dart';

import '../controller/forget_password_controller.dart';


class ForgotPasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ForgotPasswordController>(() => ForgotPasswordController());
  }
}
