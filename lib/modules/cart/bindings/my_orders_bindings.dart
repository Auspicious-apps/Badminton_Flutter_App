import 'package:get/get.dart';

import '../controller/My_Orders_controller.dart';


class PgMyOrderBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PgMyOrderController>(() => PgMyOrderController());
  }
}