import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../repository/api_repository.dart';
import '../../../repository/firebase.dart';
import '../../../repository/localstorage.dart';
import '../../cart/controller/cart_controller.dart';
import '../models/auth_requestmodel.dart';

import '../models/user_response_model.dart';
import 'package:badminton/services/notification_service.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final obscurePassword = true.obs;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final APIRepository _apiRepository = Get.find<APIRepository>();
  userResponseModel responseModel = userResponseModel();
  RxBool rememberMe = false.obs;
  final storage = GetStorage();
  final LocalStorage _localStorage = Get.find<LocalStorage>();
  final loading = false.obs;
  final RxDouble latitude = 0.0.obs;
  final RxDouble longitude = 0.0.obs;
  var fcmtoken = ''.obs;
  @override
  void onInit() {
    super.onInit();

    final savedEmail = storage.read('email') ?? '';
    final savedPassword = storage.read('password') ?? '';
    final remember = storage.read('rememberMe') ?? false;

    if (remember) {
      emailController.text = savedEmail;
      passwordController.text = savedPassword;
      rememberMe.value = true;
    }
    _getCurrentLocation();
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

  Future<void> _getCurrentLocation() async {
    try {
      // Check and request location permissions
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        Get.snackbar("Error", "Location services are disabled.",
            snackPosition: SnackPosition.TOP);
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          Get.snackbar("Error", "Location permissions are denied.",
              snackPosition: SnackPosition.TOP);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        Get.snackbar("Error", "Location permissions are permanently denied.",
            snackPosition: SnackPosition.TOP);
        return;
      }

      // Fetch the current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      // Update latitude and longitude
      latitude.value = position.latitude;
      longitude.value = position.longitude;

      print(
          "Location fetched: Lat: ${latitude.value}, Long: ${longitude.value}");
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch location: $e",
          snackPosition: SnackPosition.TOP);
    }
  }

  void login() async {
    Get.closeAllSnackbars(); //
    if (loading.value) return;

    try {
      loading.value = true;
      final email = emailController.text.trim();
      final password = passwordController.text;

      if (email.isEmpty || password.isEmpty) {
        Get.snackbar("Error", "Please fill in all fields",
            snackPosition: SnackPosition.TOP);
        loading.value = false;
        return;
      }

      Map<String, dynamic> requestModel = AuthRequestModel.loginApiRequest(
        email: email,
        password: password,
        authType: "Email-Phone",
        fcmToken: fcmtoken?.value??""
      );

      final response = await _apiRepository.loginApi(dataBody: requestModel);
      if (response != null) {
        responseModel = response;
        print("token: ${responseModel.data?.token}");
        Get.snackbar("Success","Login Successfully"??"");
        final cartController = Get.find<CartController>();


        _localStorage.saveAuthToken(responseModel?.data?.token ?? "");
        cartController.GetAddtocart();
        if (rememberMe.value) {
          storage.write('email', email);
          storage.write('password', password);
          storage.write('rememberMe', true);
        } else {
          storage.remove('email');
          storage.remove('password');
          storage.write('rememberMe', false);
        }
        Get.offAllNamed("/dashboard");
      } else {
        Get.snackbar("Error", "Login failed, please try again",
            snackPosition: SnackPosition.TOP);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.TOP);
    } finally {
      loading.value = false;
      loading.refresh();
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      Get.dialog(
        const Center(
          child: CircularProgressIndicator(),
        ),
        barrierDismissible: false,
        barrierColor: Colors.black.withOpacity(0.4), // Transparent background
      );
      final String clientId = defaultTargetPlatform == TargetPlatform.android
          ? DefaultFirebaseOptions.androidClientId
          : DefaultFirebaseOptions.iosClientId;

      print("Using Client ID: $clientId"); // Debug: Verify Client ID

      final GoogleSignIn googleSignIn = GoogleSignIn(
        clientId: clientId,
      );

      // Sign out previous sessions to ensure fresh login
      await googleSignIn.signOut();
      await FirebaseAuth.instance.signOut();

      // Start Google Sign-In flow
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      // User cancelled the sign-in
      if (googleUser == null) {
        // Get.snackbar('Cancelled', 'Google Sign-In was cancelled by the user');
        print("Google Sign-In cancelled"); // Debug
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      print("Google ID Token: ${googleAuth.idToken}>>>>>>>>>>>>>>>>>>>>>>>>");

      Map<String, dynamic> requestModel =
          AuthRequestModel.socialloginApiRequest(

        idToken: googleAuth.idToken ?? "",
        fcmToken: fcmtoken?.value??"",
        location: {
          "type": "Point",
          "coordinates": [longitude.value, latitude.value]
        }, // Pass latitude and longitude
        authType: "Google",
      );

      final response =
          await _apiRepository.socialLoginApi(dataBody: requestModel);
      if (response != null) {
        responseModel = response;
        print("token: ${responseModel.data?.token}");
        Get.offAllNamed("/dashboard");
        _localStorage.saveAuthToken(responseModel?.data?.token ?? "");
      }
    } catch (e) {
      print("Google Sign-In error: $e"); // Debug
      if (e.toString().contains('ApiException: 10')) {
      } else {
        // Get.snackbar('Error', 'Google Sign-In failed: $e');
      }
    } finally {
      Get.back(); // Close loader
    }
  }


  void AppleLogin(credentials)async{
    try{
      loading.value=true;
    Map<String, dynamic> requestModel =
    AuthRequestModel.socialloginApiRequest(

      idToken: credentials?? "",
      fcmToken: fcmtoken?.value??"",
      location: {
        "type": "Point",
        "coordinates": [longitude.value, latitude.value]
      }, // Pass latitude and longitude
      authType: "Apple",
    );

    final response =
        await _apiRepository.socialLoginApi(dataBody: requestModel);
    if (response != null) {
      responseModel = response;
      print("token: ${responseModel.data?.token}");
      Get.offAllNamed("/dashboard");
      _localStorage.saveAuthToken(responseModel?.data?.token ?? "");
    }
  } catch (e) {
  print("Google Sign-In error: $e"); // Debug
  if (e.toString().contains('ApiException: 10')) {
  } else {
  // Get.snackbar('Error', 'Google Sign-In failed: $e');
  }
  } finally {
  Get.back(); // Close loader
  }
  }

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  @override
  void onClose() {
    super.onClose();
  }
}
