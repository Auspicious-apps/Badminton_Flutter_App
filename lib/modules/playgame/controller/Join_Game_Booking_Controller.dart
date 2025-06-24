import 'package:badminton/modules/auth_module/models/forget_password_responsemodel.dart';
import 'package:badminton/modules/courtscreens/models/BookingResponseModel.dart';
import 'package:badminton/modules/courtscreens/models/Payment_ResponseModel.dart';
import 'package:badminton/modules/courtscreens/models/booking_request_model.dart';
import 'package:badminton/modules/home%20/controller/tabplay_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:super_tooltip/super_tooltip.dart';

import '../../../repository/api_repository.dart';
import '../../auth_module/models/auth_requestmodel.dart';
import '../../auth_module/models/user_response_model.dart';
import '../../home /controller/tab_more_controller.dart';
import '../model/Join_Open_match.dart';
import '../model/join_Booking_detail.dart';

class JoinConfirmPaymentController extends GetxController {
  late Razorpay _razorpay;

  RxBool isCancellationExpanded = false.obs;
  final tooltipcontroller = SuperTooltipController();
  Rx<JoinBookingDetail> bookingResponseModel = JoinBookingDetail().obs;
  Rx<JoinOpenMatchResponseModel> joinOpenMatchResponse = JoinOpenMatchResponseModel().obs;

  var selectedButton2 = 0.obs;
  RxBool loading = false.obs;
  final APIRepository _apiRepository = Get.find<APIRepository>();
  RxInt RacketA = 0.obs;
  RxInt RacketB = 0.obs;
  RxInt RacketC = 0.obs;
  RxInt RacketD = 0.obs;
  RxInt Balls = 0.obs;
  RxBool selectedRacketA = false.obs;
  RxBool selectedRacketB = false.obs;
  RxBool selectedRacketC = false.obs;
  RxBool selectedRacketD = false.obs;
  RxBool selectedBalls = false.obs;
  RxBool PayBooking = false.obs;
  RxBool isLoading = false.obs;
  var PaymentMethod = "Play Coins".obs;
  var player = "".obs;

  Rx<PaymentResponseModel> paymentModel = PaymentResponseModel().obs;
  Rx<userResponseModel> responseModel = userResponseModel().obs;
  @override
  void onInit() {
    super.onInit();
    getData();
    _razorpay = Razorpay();
    // Attach event listeners
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    // Extract arguments when the controller is initialized
    extractArguments();
  }

  Future getData() async {
    loading.value = true;
    try {
      final response = await _apiRepository.getuser();
      if (response != null) {
        responseModel.value = response;
        loading.value = false;
        responseModel.refresh();
        print(
            "useremail>>>>>>>>>>>>>>>>>>: ${responseModel.value.data?.email}????????????");
      }
    } catch (e) {
      loading.value = false;
      Get.snackbar("Error", e.toString());
    }
  }

  void openCheckout(String? amount, String? orderId) {
    if (amount == null || amount.isEmpty) {
      Get.snackbar('Invalid Input', 'Please enter an amount',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white);
      return;
    }

    double parsedAmount;
    try {
      parsedAmount = double.parse(amount);
      if (parsedAmount <= 0) {
        Get.snackbar('Invalid Input', 'Amount must be greater than 0',
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.orange,
            colorText: Colors.white);
        return;
      }
    } catch (e) {
      Get.snackbar('Invalid Input', 'Invalid amount format: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.orange,
          colorText: Colors.white);
      return;
    }

    var options = {
      'key': 'rzp_test_jODGJ0fppn1jdr', // Replace with your Razorpay Test Key
      'amount': (parsedAmount * 100).toInt(),
      "order_id": orderId,

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
      print("Error opening Razorpay: $e");
      Get.snackbar('Error', 'Failed to open Razorpay: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
  }

  void extractArguments() {
    // Get arguments passed via navigation
    final arguments = Get.arguments;
    if (arguments == null) {
      Get.snackbar('Error', 'No booking data provided',
          snackPosition: SnackPosition.TOP);
      return;
    }

    bookingResponseModel = Get.arguments["responseModel"];
    player.value = Get.arguments["player"];
    print(player);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Get.snackbar(
      'Payment Successful',
      'Payment ID: ${response.paymentId}',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.green,
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 4),
    );
    print(
        "Payment Success: ${response.paymentId}, Order: ${response.orderId}, Signature: ${response.signature}");
    Get.back();
    Get.offNamed("/mybookings");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Get.snackbar(
      'Payment Failed',
      'Error: ${response.message} (Code: ${response.code})',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 4),
    );
    print("Payment Error: Code ${response.code}, Message: ${response.message}");
    Get.back();
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Get.snackbar(
      'External Wallet',
      'Wallet Selected: ${response.walletName}',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.blue,
      colorText: Colors.white,
      margin: const EdgeInsets.all(10),
      duration: const Duration(seconds: 4),
    );
    print("External Wallet: ${response.walletName}");
  }

  // Helper method to format booking date for display
  // String getFormattedBookingDate() {
  //   try {
  //     final dateTime = DateTime.parse(bookingDate.value);
  //     return DateFormat('yyyy-MM-dd').format(dateTime);
  //   } catch (e) {
  //     return bookingDate.value;
  //   }
  // }

  void BookingApi() async {
    try {
      loading.value = true;
      Map<String, dynamic> requestModel = BookingRequestModel.JoinBooking(
          bookingId:bookingResponseModel.value.data?.sId??"",
          requestedPosition:player.value,
          requestedTeam:player.value=="player2"? "team1":"team2",
          rackets:RacketA?.value.toString()??"" ,
          // racketB: RacketB?.value.toString()??"",
          // racketC: RacketC?.value.toString()??"",
          balls:Balls?.value.toString()??"",
          paymentMethod: PaymentMethod.value=="Play Coins"?"playcoins":PaymentMethod.value=="Razor Pay"?"razorpay":"both"



      );

      final response =
          await _apiRepository.JoinCourtApi(dataBody: requestModel);

      if (response != null) {
        joinOpenMatchResponse.value = response;

        final profile = Get.put<MoreController>(MoreController());
        final playgames = Get.put<PlayController>(PlayController());
        playgames.getCurrentLocation();
        profile.getData();
        // Print(joinOpenMatchResponse.value.data?.payment?.amount)
        if (PaymentMethod.value != "Play Coins"||joinOpenMatchResponse.value.data?.payment==null&&PaymentMethod.value != "Both") {
          if (joinOpenMatchResponse.value.data?.payment?.amount== 0||joinOpenMatchResponse.value.data?.payment==null) {
            Get.offNamed("/mybookings");
          } else {
            openCheckout(joinOpenMatchResponse.value.data?.payment?.amount.toString(),
                joinOpenMatchResponse.value.data?.payment?.razorpayOrderId);
          }
        } else {
          Get.offNamed("/mybookings");
        }
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      loading.value = false;
    }finally{
      loading.value = false;
    }
  }


}
