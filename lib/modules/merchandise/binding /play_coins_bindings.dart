import 'package:get/get.dart';

import '../controller/play_coins_controller.dart' show PlayCoinsController;


class PlayCoinsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PlayCoinsController>(() => PlayCoinsController());
  }
}