import 'package:get/get.dart';

import '../controller/orderAddressController.dart';


class OrderAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OrderAddressController>(() => OrderAddressController());
  }
}