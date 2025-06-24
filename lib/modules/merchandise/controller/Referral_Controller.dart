import 'package:get/get.dart';

import '../../../app_settings/constants/app_colors.dart';

class ReferCodeController extends GetxController {
  // Sample referral code
   var referralCode = "".obs;

   @override
  void onInit() {
if(Get.arguments!=null){
  referralCode.value=Get.arguments['code'];
}
    super.onInit();
  }

  void goBack() {
    Get.back();
  }


  void copyReferralCode() {
    Get.snackbar(
      'Success',
      'Referral code copied to clipboard!',
      snackPosition: SnackPosition.TOP,
      backgroundColor: AppColors.primaryColor,
      colorText: AppColors.whiteColor,
    );
  }
}