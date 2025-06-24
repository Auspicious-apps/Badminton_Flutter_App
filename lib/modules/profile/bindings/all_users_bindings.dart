import 'package:badminton/modules/profile/controller/allusers_controller.dart';
import 'package:get/get.dart';


class AllUsersBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllUsersController>(() => AllUsersController());
  }
}