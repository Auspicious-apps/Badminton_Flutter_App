
import 'package:badminton/modules/merchandise/controller/merchandise_home.dart';
import 'package:badminton/modules/notification/controller/notification_controller.dart';
import 'package:get/get.dart';





class Notificationbinding  extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<NotificationController>(() => NotificationController());

  }
}