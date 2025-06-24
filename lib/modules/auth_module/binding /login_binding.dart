// auth_binding.dart
import 'package:badminton/modules/auth_module/controller/login_controller.dart';
import 'package:get/get.dart';


class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}
