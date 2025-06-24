// splash_controller.dart
import 'package:get/get.dart';

import '../../../repository/localstorage.dart';

class SplashController extends GetxController {

  @override
  void onInit() {
    super.onInit();

  }


  void goToNextScreen() {
    Get.toNamed('/splashSecond');
  }

}
