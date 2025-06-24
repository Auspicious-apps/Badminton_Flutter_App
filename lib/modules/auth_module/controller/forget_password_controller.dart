import 'package:badminton/modules/auth_module/models/forget_password_responsemodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repository/api_repository.dart';
import '../../../repository/localstorage.dart';
import '../models/auth_requestmodel.dart';

class ForgotPasswordController extends GetxController {
  final phoneController = TextEditingController();

  ForgetPasswordModel forgetResponseModel = ForgetPasswordModel();
  final LocalStorage _localStorage = Get.find<LocalStorage>();
  RxBool loading = false.obs;
  final APIRepository _apiRepository = Get.find<APIRepository>();
  @override



  void onConfirm() async{
    Get.closeAllSnackbars(); // Close any existing snackbars
    if (loading.value) return; // Prevent multiple API calls while loading

    // Validate if phoneController.text is empty
    if (phoneController.text.trim().isEmpty) {
      Get.snackbar("Error", "Please enter a valid email.");
      return; // Stop execution if the input is empty
    }
    try{
      loading.value=true;
        Map<String, dynamic> requestModel = AuthRequestModel
            .resendOtpApiRequest(
          email: phoneController.text?? "",
        );
        final response = await _apiRepository.forgetPassApi(dataBody: requestModel);
        if(response!=null){
          forgetResponseModel=response;
          Get.snackbar("Success",forgetResponseModel.message??"");
          _localStorage.saveAuthToken(forgetResponseModel.token??"");

          Get.toNamed("/otpVerification",arguments: {"email":phoneController.text});
          phoneController.text="";
          loading.value=false;
        }

    } catch (e) {
      Get.snackbar("Error", e.toString());
      loading.value=false;
    }
  }

  void goToLogin() {
     phoneController.text="";
      Get.offAllNamed('/login');
  }

  @override
  void onClose() {

    super.onClose();
  }


}
