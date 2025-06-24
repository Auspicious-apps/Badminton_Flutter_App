import 'package:badminton/modules/profile/controller/edit_profile_controller.dart';
import 'package:get/get.dart';

import '../controller/user_profile_info_controller.dart';


class EditProfileBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileController>(() => EditProfileController());
  }
}