import 'package:get/get.dart';

import '../controller/friend_request_controller.dart';


class FriendsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FriendsController>(() => FriendsController());
  }
}