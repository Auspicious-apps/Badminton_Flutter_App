
import 'package:badminton/modules/merchandise/controller/merchandise_home.dart';
import 'package:get/get.dart';

import '../controller/product_detail_controller.dart';



class MerchandiseBinding  extends Bindings {
  @override
  void dependencies() {

    Get.lazyPut<MerchandiseController>(() => MerchandiseController());

  }
}
