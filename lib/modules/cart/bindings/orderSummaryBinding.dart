import 'package:get/get.dart';

import '../controller/orderSummaryController.dart';

class PgOrderSummaryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PgOrderSummaryController>(() => PgOrderSummaryController());
  }
}