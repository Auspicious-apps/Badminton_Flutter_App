import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import '../../../repository/api_repository.dart';
import 'cart_controller.dart';

class OrderAddressController extends GetxController {
  // Observable variables (if needed for UI updates)
  final name = TextEditingController();
  final address = TextEditingController();
  final StreetAddress = TextEditingController();
  final pinCode = TextEditingController();
  final country = TextEditingController();
  final phoneNumber = TextEditingController();
  final city = TextEditingController();
  final state = TextEditingController();
  final latitude = 0.0.obs;
  final longitude = 0.0.obs;
  var isLoading = false.obs; // Loading state for UI feedback
  var locationStatus = ''.obs;
  final APIRepository _apiRepository = Get.find<APIRepository>();

  @override
  void onInit() {
    super.onInit();
    getCurrentLocation();
    // Initialize with default values if needed
  }

  // Prepare order data for submission
  Map<String, dynamic> prepareOrderData() {
    // Get cart controller to access cart items
    final cartController = Get.find<CartController>();
    
    // Prepare items array from cart items
    List<Map<String, dynamic>> items = [];
    for (var item in cartController.cartItems) {
      items.add({
        "productId": item.productId,
        "quantity": item.quantity
      });
    }
    
    // Prepare complete order data
    Map<String, dynamic> orderData = {
      "items": items,
      "lat":latitude.value,
      "lng":longitude.value,

      "address": {
        "nameOfRecipient": name.text,
        "phoneNumber": phoneNumber.text,
        "street": StreetAddress.text,
        "city": address.text,
        "state": state.text,
        "pinCode": pinCode.text
      }
    };
    
    return orderData;
  }
  
  // Validate form fields
  bool validateFields() {
    Get.closeAllSnackbars();
    if (name.text.isEmpty) {
      Get.snackbar('Error', 'Please enter recipient name');
      return false;
    }
    if (address.text.isEmpty) {
      Get.snackbar('Error', 'Please enter city');
      return false;
    }
    if (StreetAddress.text.isEmpty) {
      Get.snackbar('Error', 'Please enter street address');
      return false;
    }
    if (pinCode.text.isNotEmpty&&pinCode.text.length<6||pinCode.text.isEmpty) {
      Get.snackbar('Error', 'Please enter Postal code');
      return false;
    }
    if (country.text.isEmpty) {
      Get.snackbar('Error', 'Please enter Country ');
      return false;
    }
    if (phoneNumber.text.isEmpty||phoneNumber.text.isNotEmpty&&phoneNumber.text.length<10) {
      Get.snackbar('Error', 'Please enter phone number');
      return false;
    }




    return true;
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
  // Process order and navigate to order summary
  void processOrder() {
    if (!validateFields()) {
      return;
    }
    
    // Prepare order data
    Map<String, dynamic> orderData = prepareOrderData();
    
    // Navigate to order summary page with the data
    Get.offNamed("/orderSummary", arguments: orderData);
  }
}
