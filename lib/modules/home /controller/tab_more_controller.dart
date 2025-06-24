// lib/controllers/more_controller.dart
import 'package:badminton/modules/home%20/controller/tab_home_controller.dart';
import 'package:badminton/modules/home%20/controller/tabplay_controller.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

import '../../../repository/api_repository.dart';
import '../../../repository/localstorage.dart';
import '../../auth_module/models/auth_requestmodel.dart';
import '../../auth_module/models/user_response_model.dart';
import '../models/home_response_model.dart';

class MoreController extends GetxController {
  final userName = 'Claire Browne.'.obs;
  final userLevel = 'Beginner'.obs;
  final matches = 16.obs;
  final friends = 250.obs;
  final playCoins = 16.obs;
  final LocalStorage _localStorage = Get.find<LocalStorage>();
  final APIRepository _apiRepository = Get.find<APIRepository>();
  Rx<userResponseModel> responseModel = userResponseModel().obs;
  RxBool loading = true.obs;

  @override
  @override
  void onReady() {
    super.onReady();
    getData();

  }


  void logout() async {
    try {
      String? token = await FirebaseMessaging.instance.getToken();
      // ✅ Now sending selectedCountry phoneCode dynamically
      Map<String, dynamic> requestModel = AuthRequestModel.logout(

        fcmToken:token?? "", // optional: provide if available
      );

      final response = await _apiRepository.logoutApi(dataBody: requestModel);

      if (response != null) {
        _localStorage.removeAuthToken();
        Get.snackbar("Success", "Logout Sucessfully");
        Get.offAllNamed("/login");

      }
    }catch(e){
      print(">>>>>>>>>>>$e");
    }
  }

  Future getData () async {

    loading.value=true;
    try {
      final response = await _apiRepository.getuser();
      if (response != null) {
        responseModel.value = response;
        loading.value=false;
        responseModel.refresh();
        Get.put(TabHomeController()).getProfile();
        Get.put(PlayController()).getProfile();
        print("useremail>>>>>>>>>>>>>>>>>>: ${responseModel.value.data?.email}????????????");

      }
    } catch (e) {
      loading.value=false;
      Get.snackbar("Error", e.toString());
    }

  }
}
