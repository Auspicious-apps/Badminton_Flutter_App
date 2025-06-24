import 'package:get/get.dart';

import '../controller/all_friend_requests_controller.dart';


class FriendRequestsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FriendRequestsController>(() => FriendRequestsController());
  }
}