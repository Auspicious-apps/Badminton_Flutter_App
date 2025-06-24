import 'package:badminton/modules/home%20/controller/tab_home_controller.dart';
import 'package:badminton/modules/home%20/controller/tab_more_controller.dart';
import 'package:badminton/modules/home%20/controller/tabplay_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  final PageController pageController = PageController();
  final RxInt selectedIndex = 0.obs;

  void onTabSelected(int index) {
    selectedIndex.value = index;
    if(index==1){
      final playgame=Get.put<PlayController>(PlayController());
     playgame.loading.value=true;
      playgame.getCurrentLocation();
    }else  if(index==3){

      final playgame=Get.put<MoreController>(MoreController());
      playgame.loading.value=true;
      playgame.getData();
    }else{
      final playgame=Get.put<TabHomeController>(TabHomeController());
      playgame.loading.value=true;
      playgame.getCurrentLocation();
    }
    pageController.jumpToPage(index);
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
