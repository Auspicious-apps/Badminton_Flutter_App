import 'package:get/get.dart';

import '../controller/court_detail_controller.dart';


class PgCourtdetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PgCourtdetailController>(() => PgCourtdetailController());
  }
}