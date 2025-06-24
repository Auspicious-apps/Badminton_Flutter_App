import 'package:get/get.dart';

import '../../courtscreens/controller/confirm_payment_controller.dart';
import '../controller/join_game_detail_controller.dart';



class PgJoinGameDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PgJoinGameDetailController>(() => PgJoinGameDetailController());
  }
}