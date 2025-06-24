import 'package:get/get.dart';

import '../controller/Referral_Controller.dart';


class ReferCodeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ReferCodeController>(() => ReferCodeController());
  }
}