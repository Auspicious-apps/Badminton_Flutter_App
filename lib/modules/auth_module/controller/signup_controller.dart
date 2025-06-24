import 'package:badminton/modules/auth_module/models/user_response_model.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:badminton/services/notification_service.dart';

import '../../../repository/api_repository.dart';
import '../../../repository/localstorage.dart';
import '../models/auth_requestmodel.dart';

class SignupController extends GetxController {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final refferalController = TextEditingController();
  final APIRepository _apiRepository = Get.find<APIRepository>();
  final LocalStorage _localStorage = Get.find<LocalStorage>();
  final birthDate = ''.obs;
  final obscurePassword = true.obs;
  final loading = false.obs;
  userResponseModel responseModel = userResponseModel();

  // 👉 Default Country changed to India
  Rx<Country> selectedCountry = Rx<Country>(
    Country(
      phoneCode: '91',
      countryCode: 'IN',
      e164Sc: 0,
      geographic: true,
      level: 1,
      name: 'India',
      example: '7012345678',
      displayName: 'India',
      displayNameNoCountryCode: 'India',
      e164Key: '',
    ),
  );

  final latitude = 0.0.obs;
  final longitude = 0.0.obs;
  var locationStatus = ''.obs;

  var fcmtoken = ''.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  @override
  void onInit() {
    super.onInit();

    getCurrentLocation();
    getFCMToken();
  }


  Future<void> getFCMToken() async {
    try {
      // Get notification service
      final notificationService = Get.find<NotificationService>();
      
      // Request permission for notifications (required for iOS)
      NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
        alert: true,
        badge: true,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        // Get the FCM token
        String? token = await FirebaseMessaging.instance.getToken();
        if (token != null) {
          print("FCM Token: $token");
          fcmtoken.value = token;
        } else {
          print("Failed to get FCM token");
        }
      } else {
        print("Notification permissions not granted");
      }
    } catch (e) {
      print("Error fetching FCM token: $e");
    }
  }

  void updateCountry(Country country) {
    selectedCountry.value = country;
  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      locationStatus.value = 'Location services are disabled.';
      return;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        locationStatus.value = 'Location permission denied.';
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      locationStatus.value = 'Location permission permanently denied.';
      return;
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    latitude.value = position.latitude;
    longitude.value = position.longitude;
    locationStatus.value = 'Location fetched successfully.';
  }

  Future<void> hitSignupApiCall() async {
    Get.closeAllSnackbars();
    if (loading.value==true) return;
    try {
      loading.value=true;
      if (latitude.value == 0.0 || longitude.value == 0.0) {
        Get.snackbar("Error", "Location data not available. Please enable location services.");
        loading.value=false;
        return;

      }
      if (firstNameController.text.isEmpty) {
        Get.snackbar("Error", "Please enter first name ");
        loading.value=false;
        return;

      }
      if (lastNameController.text.isEmpty) {
        Get.snackbar("Error", "Please enter last name ");
        loading.value=false;
        return;

      }

      if (emailController.text.isEmpty) {
        Get.snackbar("Error", "Please enter an email");
        loading.value = false;
        return;
      }

      if (birthDate.value.isEmpty) {
        Get.snackbar("Error", "Please enter Date of Birth");
        loading.value = false;
        return;
      }

      if (phoneController.text.length<10) {
        Get.snackbar("Error", "Phone number must be 10 digits.");
        loading.value=false;
        return;

      }




      if (passwordController.text.length<8) {
        Get.snackbar("Error", "Password must be at least 8 digit");
        loading.value=false;
        return;

      }

      // ✅ Now sending selectedCountry phoneCode dynamically
      Map<String, dynamic> requestModel = AuthRequestModel.signupRequestModel(
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        email: emailController.text.trim(),
        phoneNumber: phoneController.text.trim(),
        countryCode: "+${selectedCountry.value.phoneCode}", // 👈 important
        password: passwordController.text.trim(),
        referralUsed: refferalController?.text??"",

        dob: birthDate.value.trim(),
        coordinates: [
          longitude.value,
          latitude.value,
        ],
        fcmToken: fcmtoken?.value??"",  // optional: provide if available
      );

      final response = await _apiRepository.signupApi(dataBody: requestModel);

      if (response != null) {
        responseModel = response;
        print("token: ${responseModel.data?.token}");
        _localStorage.saveAuthToken(responseModel?.data?.token??"");
        firstNameController.clear();
        lastNameController.clear();
        emailController.clear();
        phoneController.clear();
        passwordController.clear();
        refferalController.clear();
        birthDate.value='';
        Get.toNamed('/otpVerification',arguments: {"data":responseModel});
        loading.value=false;
        Get.snackbar("Successful", "Signup Successfully");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      loading.value=false;
    }
  }

  @override
  void onClose() {

    super.onClose();
  }
}
