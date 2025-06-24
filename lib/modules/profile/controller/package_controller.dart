
import 'package:badminton/modules/profile/models/packgeModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../repository/api_repository.dart';
import '../../cart/model/OrderResponse.dart';
import '../../courtscreens/models/booking_request_model.dart';
import '../../home /controller/dashboard_controller.dart';

class PgPackagesController extends GetxController {
  late Razorpay _razorpay;
  final isLoading = false.obs;

  // Reactive list to store notifications
  Rx<PackagesResponseModel> packages = PackagesResponseModel().obs;
  Rx<OrderCreateResponse> orderResponse = OrderCreateResponse().obs;
  // API repository instance (injected or initialized)
  final APIRepository _apiRepository = Get.find<APIRepository>();
  final firstNameController = TextEditingController();
  RxBool RechargeOnce=false.obs;
@override
  void onInit() {
  fetchNotifications();
  _razorpay = Razorpay();
  // Attach event listeners
  _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
  _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
  _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.onInit();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Get.snackbar(
      'Payment Successful',
      'Payment ID: ${response.paymentId}',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 4),
    );
    print("Payment Success: ${response.paymentId}, Order: ${response.orderId}, Signature: ${response.signature}");
    Get.back();
    Get.put(DashboardController()).selectedIndex(0);
    Get.offAllNamed("/dashboard");





  }

  void _handlePaymentError(PaymentFailureResponse response) {
    isLoading.value=false;
    isLoading.refresh();
    Get.snackbar(
      'Payment Failed',
      'Error: ${response.message} (Code: ${response.code})',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 4),
    );
    print("Payment Error: Code ${response.code}, Message: ${response.message}");

    Get.back();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    isLoading.value=false;
    Get.snackbar(
      'External Wallet',
      'Wallet Selected: ${response.walletName}',
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 4),
    );

    print("External Wallet: ${response.walletName}");
  }

  void openCheckout(String? amount,String? orderId) {
    if (amount == null || amount.isEmpty) {
      Get.snackbar('Invalid Input', 'Please enter an amount',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.orange,
          colorText: Colors.white);
      return;
    }

    double parsedAmount;
    try {
      parsedAmount = double.parse(amount);
      if (parsedAmount <= 0) {
        Get.snackbar('Invalid Input', 'Amount must be greater than 0',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.orange,
            colorText: Colors.white);
        return;
      }
    } catch (e) {
      Get.snackbar('Invalid Input', 'Invalid amount format: $e',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.orange,
          colorText: Colors.white);
      return;
    }

    var options = {
      'key': 'rzp_test_jODGJ0fppn1jdr', // Replace with your Razorpay Test Key
      'amount': (parsedAmount * 100).toInt(),
      "order_id":orderId,

      'name': 'Badminton App',
      'description': 'Payment for Court Booking',
      'prefill': {
        'contact': '9999999999',
        'email': 'test@example.com',
      },
    };

    try {
      print("Opening Razorpay with options: $options");
      _razorpay.open(options);
    } catch (e) {
      isLoading.value=false;
      print("Error opening Razorpay: $e");
      Get.snackbar('Error', 'Failed to open Razorpay: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }finally{
      isLoading.value=false;
    }
  }

  /// Fetches notifications from the API
  Future fetchNotifications() async {
    try {
      // Set loading state to true
      isLoading.value = true;
      isLoading.refresh();

      // Fetch notifications from API
      final response = await _apiRepository.getPackages();

      // Check if response and data are valid
      if (response != null ) {
     packages.value=response;
     isLoading.value = false;
     isLoading.refresh();
      }
    } catch (e) {
      // Log error and show user-friendly message
      isLoading.value = false;
      isLoading.refresh();
      Get.snackbar(
        'Error',
        'Failed to fetch packages. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      // Reset loading state
      isLoading.value = false;
      isLoading.refresh();
    }
  }


  Future BuyPackagesApiCall() async {
    try {
      // Set loading state to true
      isLoading.value = true;
      isLoading.refresh();

      Map<String, dynamic> requestModel = BookingRequestModel.buyPackage(amount:firstNameController.text);
      final response = await _apiRepository.BuyPackages(dataBody: requestModel);

      // Check if response and data are valid
      if (response != null ) {
        orderResponse.value=response;
        print(">>>>>OrderResponseId${orderResponse.value.data?.razorpayOrderId}");
        openCheckout(orderResponse.value.data?.amount?.toString(),orderResponse.value.data?.razorpayOrderId);
        // isLoading.value = false;
        // isLoading.refresh();
      }
    } catch (e) {
      // Log error and show user-friendly message
      isLoading.value = false;
      isLoading.refresh();
      Get.snackbar(
        'Error',
        'Failed to fetch packages. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      // Reset loading state
      isLoading.value = false;
      isLoading.refresh();
    }
  }


  Future BuyFixPackagesApiCall(String? packageId) async {
    try {
      // Set loading state to true
      isLoading.value = true;
      isLoading.refresh();

      Map<String, dynamic> requestModel = BookingRequestModel.buyPackage(packageId:packageId);
      final response = await _apiRepository.BuyPackages(dataBody: requestModel);

      // Check if response and data are valid
      if (response != null ) {
        orderResponse.value=response;
        print(">>>>>OrderResponseId${orderResponse.value.data?.razorpayOrderId}");
        openCheckout(orderResponse.value.data?.amount?.toString(),orderResponse.value.data?.razorpayOrderId);
        // isLoading.value = false;
        // isLoading.refresh();
      }
    } catch (e) {
      // Log error and show user-friendly message
      isLoading.value = false;
      isLoading.refresh();
      Get.snackbar(
        'Error',
        'Failed to fetch packages. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      // Reset loading state
      isLoading.value = false;
      isLoading.refresh();
    }
  }
}