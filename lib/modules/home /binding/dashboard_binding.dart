import 'package:badminton/modules/home%20/controller/tab_home_controller.dart';
import 'package:badminton/modules/home%20/controller/tab_more_controller.dart';
import 'package:badminton/modules/home%20/controller/tab_rank_controller.dart';
import 'package:get/get.dart';

import '../controller/dashboard_controller.dart';
import '../controller/tabplay_controller.dart';


class DashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<TabHomeController>(() => TabHomeController());
    Get.lazyPut<MoreController>(() => MoreController());
    Get.lazyPut<PlayController>(() => PlayController());
    Get.lazyPut<RankController>(() => RankController());
  }
}
