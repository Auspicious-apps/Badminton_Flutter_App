import 'package:badminton/modules/creategames/controller/Get_my_bookings_cotroller.dart';
import 'package:badminton/modules/creategames/controller/get_all_bookings_controller.dart';
import 'package:badminton/modules/creategames/controller/upload_score_controller.dart';
import 'package:get/get.dart';



class UploadScoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UploadScoreController>(() => UploadScoreController());
  }
}
