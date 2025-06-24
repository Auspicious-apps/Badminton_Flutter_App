import 'dart:async';
import 'package:badminton/modules/auth_module/models/otpVerificationResponseModel.dart';
import 'package:badminton/modules/auth_module/models/resend_otp_responsemodel.dat.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../repository/api_repository.dart';
import '../../../repository/localstorage.dart';
import '../models/auth_requestmodel.dart';
import '../models/forget_password_responsemodel.dart';
import '../models/user_response_model.dart';

class OtpVerificationController extends GetxController {
  var otpCode = ''.obs;
  var timerSeconds = 120.obs; // 🕒 timer countdown value
  ForgetPasswordModel forgetResponseModel = ForgetPasswordModel();
  final TextEditingController pinController = TextEditingController();
  final FocusNode pinFocusNode = FocusNode();
  Timer? _timer;
  late final userResponseModel responseModel;
  OtpVerification otpverification = OtpVerification();
  ResendOtpResponse resendOtpResponse = ResendOtpResponse();
  final APIRepository _apiRepository = Get.find<APIRepository>();
  final LocalStorage _localStorage = Get.find<LocalStorage>();
  RxBool emailVerified = false.obs;
  var email = "".obs;
  RxBool loading = false.obs;
  RxBool resend = false.obs;
  @override
  void onInit() {
    super.onInit();
    if (Get.previousRoute == '/forget') {
      if (Get.arguments != null) {
      email.value= Get.arguments['email'];

      }
    } else {
      if (Get.arguments != null) {
        responseModel = Get.arguments['data'];
        print("${responseModel.data?.email}");
      }
    }
    startOtpTimer(); // start timer when page opens
  }



  void updateOtp(String value) {

      otpCode.value = value;

  }

  void verifyOtp() async {
    try{
      loading.value=true;
      if(emailVerified.value==false){
    Map<String, dynamic> requestModel = AuthRequestModel.emailVerificationRequest(
        emailOtp: otpCode.value
    );

    final response = await _apiRepository.emailVerifyApi(dataBody: requestModel);

    if (response != null) {
      otpverification = response;
      loading.value=false;
      print("token: ${otpverification.data?.token}");
      _localStorage.saveAuthToken(otpverification.data?.token ?? "");
      if (otpverification.data?.emailVerified == true) {
        // Clear OTP code once verification is successful
        pinController.clear();
        otpCode.value = '';
        otpCode.refresh();
        emailVerified.value = true;
        emailVerified.refresh();
        // startOtpTimer();
        Get.snackbar("Success","Email otp verified");
      }
    }else{
      pinController.clear();
      otpCode.value = '';
      otpCode.refresh();
    }
    }

  } catch (e) {
  Get.snackbar("Error", e.toString());
  pinController.clear();
  otpCode.value = '';
  loading.value=false;
  }
  }


  void phoneVerifyOtp() async {
    try{
      loading.value=true;
        Map<String, dynamic> requestModel = AuthRequestModel.phoneVerificationRequest(
            phoneOtp: otpCode.value
        );

        final response = await _apiRepository.emailVerifyApi(dataBody: requestModel);

        if (response != null) {
          otpverification = response;
          loading.value=false;
          print("token: ${otpverification.data?.token}");
          _localStorage.saveAuthToken(otpverification.data?.token ?? "");
          if (otpverification.data?.emailVerified == true) {
            pinController.clear();
            otpCode.value = '';
            Get.offAllNamed("/dashboard");
            loading.value=false;
          }
        }else{
          pinController.clear();
          otpCode.value = '';
          otpCode.refresh();
          loading.value=false;
        }


    } catch (e) {
      Get.snackbar("Error", e.toString());
      pinController.clear();
      otpCode.value = '';
      loading.value=false;
    }
  }

  void forgetVerifyOtp() async {
    try{
      loading.value=true;
      Map<String, dynamic> requestModel = AuthRequestModel.forgetVerificationRequest(
          otp: otpCode.value
      );

      final response = await _apiRepository.forgetVerifyOtpApi(dataBody: requestModel);

      if (response != null) {
        loading.value=false;
        Get.toNamed('/changePass');
      }


    } catch (e) {
      Get.snackbar("Error", e.toString());
      pinController.clear();
      otpCode.value = '';
      otpCode.refresh();
      loading.value=false;
    }
  }


  void onConfirm() async{
    try{
      Map<String, dynamic> requestModel = AuthRequestModel
          .resendOtpApiRequest(
        email:email.value?? "",
      );
      final response = await _apiRepository.forgetPassApi(dataBody: requestModel);
      if(response!=null){
        forgetResponseModel=response;
        _localStorage.saveAuthToken(forgetResponseModel.token??"");
        //
        Get.snackbar("Success","OTP Resend"??"");
        startOtpTimer();
        pinController.clear();
        otpCode.value = '';
        otpCode.refresh();
      }

    } catch (e) {
      Get.snackbar("Error", e.toString());
      pinController.clear();
      otpCode.value = '';
      otpCode.refresh();
    }

  }

  void resendOtp() async {
    try{
      if(emailVerified.value==false) {
        Map<String, dynamic> requestModel = AuthRequestModel
            .resendOtpApiRequest(
          email:  responseModel.data?.email ?? "",
        );
        final response = await _apiRepository.resendOtpApi(dataBody: requestModel);
        //
        if (response != null) {
          Get.snackbar("Success","OTP Resend");
          resendOtpResponse = response;

          startOtpTimer();
        }


      }else{
        Map<String, dynamic> requestModel = AuthRequestModel
            .resendOtpApiRequest(
          phoneNumber: responseModel.data?.phoneNumber ?? "",
        );
        final response = await _apiRepository.resendOtpApi(dataBody: requestModel);
        //
        if (response != null) {
          resendOtpResponse = response;
          Get.snackbar("Success","OTP Resend"??"");
          startOtpTimer();
        }


      }

    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  void startOtpTimer() {
    resend.value=true;
    resend.refresh();
    timerSeconds.value = 120; // Reset timer

    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerSeconds.value > 0) {
        timerSeconds.value--;
      } else {
        _timer?.cancel();
        resend.value=false;
        resend.refresh();
      }
    });
  }

  @override
  void onClose() {

    super.onClose();
  }
}
