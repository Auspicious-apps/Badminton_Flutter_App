import 'package:get/get.dart';

import '../controller/package_controller.dart';


class PgPackagesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PgPackagesController>(() => PgPackagesController());
  }
}