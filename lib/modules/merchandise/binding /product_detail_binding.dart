// lib/bindings/pg_product_detail_binding.dart
import 'package:get/get.dart';

import '../controller/product_detail_controller.dart';


class PgProductDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PgProductDetailController>(() => PgProductDetailController());
  }
}