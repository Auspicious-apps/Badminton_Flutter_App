import 'package:badminton/modules/cart/controller/my_order_detail_controller.dart';
import 'package:get/get.dart';


class MyOrderDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<myOrderDetailController>(() => myOrderDetailController());
  }
}