import 'package:get/get.dart';

import '../controller/create_game_controller.dart';


class VenueBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VenueController>(() => VenueController());
  }
}
