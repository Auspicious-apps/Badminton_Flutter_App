// splash_second_controller.dart
import 'package:get/get.dart';

import '../../../repository/localstorage.dart';

class SplashSecondController extends GetxController {
  final LocalStorage _localStorage = LocalStorage();
  void goToSignIn() {
    _localStorage.saveOnboarded(true);
    Get.toNamed('/login');
  }
}
