import 'package:get/get.dart';

import '../controller/user_profile_info_controller.dart';


class PgProfileDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PgProfileDetailController>(() => PgProfileDetailController());
  }
}