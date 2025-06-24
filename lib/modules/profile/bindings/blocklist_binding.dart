import 'package:get/get.dart';

import '../controller/blocklist_controler.dart';


class BlockListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BlockListController>(() => BlockListController());
  }
}