import 'package:badminton/modules/auth_module/controller/change_password_controller.dart';
import 'package:get/get.dart';




class ChangepasswordBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangePasswordController>(() => ChangePasswordController());
  }
}
