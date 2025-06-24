// splash_second_binding.dart
import 'package:get/get.dart';

import '../controller/splashsecond_controller.dart';


class SplashSecondBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashSecondController>(() => SplashSecondController());
  }
}
