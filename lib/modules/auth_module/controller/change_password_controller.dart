// controllers/change_password_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repository/api_repository.dart';
import '../../../repository/localstorage.dart';
import '../models/auth_requestmodel.dart';
import '../models/forget_password_responsemodel.dart';

class ChangePasswordController extends GetxController {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final APIRepository _apiRepository = Get.find<APIRepository>();
  ForgetPasswordModel forgetResponseModel = ForgetPasswordModel();
  final LocalStorage _localStorage = Get.find<LocalStorage>();
  final loading = false.obs;
  void onConfirmPressed() {
    final newPassword = newPasswordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();
    Get.closeAllSnackbars(); //
    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar("Error", "Please fill in both password fields");
      return;
    }

    if (newPassword.length < 8) {
      Get.snackbar("Error", "Password must be at least 8 characters");
      return;
    }

    if (newPassword != confirmPassword) {
      Get.snackbar("Error", "Passwords do not match");
      return;
    }
    onConfirm();
  }


  void onConfirm() async{
    try{
      loading.value=true;
      Map<String, dynamic> requestModel = AuthRequestModel
          .resetPassword(
        password:newPasswordController.text.trim()?? "",
      );
      final response = await _apiRepository.resetPassApi(dataBody: requestModel);
      if(response!=null){
        loading.value=false;
        forgetResponseModel=response;
        Get.snackbar("Success",forgetResponseModel.message??"");
        _localStorage.removeAuthToken();
        Get.offAllNamed("/login");
      }

    } catch (e) {
      loading.value=false;
      Get.snackbar("Error", e.toString());
    }

  }

  @override
  void onClose() {

    super.onClose();
  }
}
