import 'package:badminton/modules/auth_module/models/forget_password_responsemodel.dart';
import 'package:badminton/modules/courtscreens/models/BookingResponseModel.dart';
import 'package:badminton/modules/courtscreens/models/Payment_ResponseModel.dart';
import 'package:badminton/modules/courtscreens/models/booking_request_model.dart';
import 'package:badminton/modules/home%20/controller/tab_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:super_tooltip/super_tooltip.dart';

import '../../../repository/api_repository.dart';
import '../../auth_module/models/auth_requestmodel.dart';
import '../../auth_module/models/user_response_model.dart';
import '../../home /controller/tab_more_controller.dart';

class ConfirmPaymentController extends GetxController {
  late Razorpay _razorpay;
  RxBool askToJoin = false.obs;
  RxBool isCompetitive = false.obs;
  RxDouble skillRequired = 0.0.obs;
  RxList<Map<String, String>> team1 = <Map<String, String>>[].obs;
  RxList<Map<String, String>> team2 = <Map<String, String>>[].obs;
  RxString venueId = ''.obs;
  RxBool isCancellationExpanded = false.obs;
  final tooltipcontroller = SuperTooltipController();
  final equipment = SuperTooltipController();
  RxString courtId = ''.obs;
  RxString image = ''.obs;
  RxString bookingDate = ''.obs;
  RxList<String> bookingSlots = <String>[].obs;
  RxString bookingType = ''.obs;
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
  // Variables for additional arguments
  RxString selectedGame = ''.obs;
  RxString address = ''.obs;
  RxString rate = ''.obs;
  RxString Hourlyrate = ''.obs;
  Rx<BookingResponseModel> bookingResponseModel = BookingResponseModel().obs;
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

  Future getData () async {

    loading.value=true;
    try {
      final response = await _apiRepository.getuser();
      if (response != null) {
        responseModel.value = response;
        loading.value=false;
        responseModel.refresh();
        print("useremail>>>>>>>>>>>>>>>>>>: ${responseModel.value.data?.email}????????????");

      }
    } catch (e) {
      loading.value=false;
      Get.snackbar("Error", e.toString());
    }

  }

  void openCheckout(String? amount,String? orderId) {
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
      loading.value=false;
      print("Error opening Razorpay: $e");
      Get.snackbar('Error', 'Failed to open Razorpay: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }finally{
      loading.value=false;
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
    image.value=Get.arguments["image"];
    // Log arguments for debugging
    print('Received arguments: $arguments');
    arguments.forEach((key, value) => print('$key: ${value.runtimeType}'));

    // Extract requestModel
    final requestModel = arguments['requestModel'] as Map<String, dynamic>?;
    if (requestModel == null) {
      Get.snackbar('Error', 'Booking request data is missing',
          snackPosition: SnackPosition.TOP);
      return;
    }

    // Assign requestModel fields to variables
    askToJoin.value = requestModel['askToJoin'] as bool? ?? false;
    isCompetitive.value = requestModel['isCompetitive'] as bool? ?? false;
    skillRequired.value =
        (requestModel['skillRequired'] as num?)?.toDouble() ?? 0.0;

    // Handle team1
    team1.clear();
    final team1Data = requestModel['team1'] as List<dynamic>? ?? [];
    for (var player in team1Data) {
      if (player is Map<String, dynamic>) {
        team1.add({
          'playerId': player['playerId'] as String? ?? '0',
          'rackets': player['racketA'] as String? ?? '0',
          // 'racketB': player['racketB'] as String? ?? '0',
          // 'racketC': player['racketC'] as String? ?? '0',
          // 'racketD': player['racketD'] as String? ?? '0',
          'balls': player['balls'] as String? ?? '0',
        });
      }
    }

    // Handle team2
    team2.clear();
    final team2Data = requestModel['team2'] as List<dynamic>? ?? [];
    for (var player in team2Data) {
      if (player is Map<String, dynamic>) {
        team2.add({
          'playerId': player['playerId'] as String? ?? '0',
          'rackets': player['racketA'] as String? ?? '0',
          // 'racketB': player['racketB'] as String? ?? '0',
          // 'racketC': player['racketC'] as String? ?? '0',
          // 'racketD': player['racketD'] as String? ?? '0',
          'balls': player['balls'] as String? ?? '0',
        });
      }
    }

    venueId.value = requestModel['venueId'] as String? ?? '';
    courtId.value = requestModel['courtId'] as String? ?? '';
    bookingDate.value = requestModel['bookingDate'] as String? ?? '';


    bookingSlots.assignAll(
        (requestModel['bookingSlots'] as List<dynamic>?)?.cast<String>() ?? []);
    bookingType.value = requestModel['bookingType'] as String? ?? '';

    // Extract additional arguments with type checking
    final selectedGameArg = arguments['selectedGame'];
    selectedGame.value = selectedGameArg is String
        ? selectedGameArg
        : selectedGameArg is bool
            ? selectedGameArg.toString() // Convert bool to String
            : '';

    final addressArg = arguments['address'];
    address.value = addressArg is String
        ? addressArg
        : addressArg is bool
            ? addressArg.toString()
            : '';

    final rateArg = arguments['Rate'];

    rate.value = rateArg is String
        ? rateArg
        : rateArg is bool
            ? rateArg.toString()
            : '60 Mins';

    Hourlyrate.value= arguments['hourlyRate'].toString();

    // Hourlyrate.value = hourly is String
    //     ? hourly
    //     : hourly is bool
    //         ? hourly.toString()

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
    print("Payment Success: ${response.paymentId}, Order: ${response.orderId}, Signature: ${response.signature}");
     Get.back();
    Get.offNamed("/mybookings");

  }

  void _handlePaymentError(PaymentFailureResponse response) {
    loading.value=false;
    loading.refresh();
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
    loading.value=false;
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
  String getFormattedBookingDate() {

    try {
      final dateTime = DateTime.parse(bookingDate.value);
      return DateFormat('yyyy-MM-dd').format(dateTime);
    } catch (e) {
      return bookingDate.value;
    }
  }

  void BookingApi() async {
    try {
      loading.value = true;
      Map<String, dynamic> requestModel =
          BookingRequestModel.bookingRequestModel(
        askToJoin: askToJoin.value,
        isCompetitive: isCompetitive.value,
        skillRequired: skillRequired.value,
        team1: [
          if (team1.isNotEmpty && team1[0] != null)
            {
              "playerId": team1[0]["playerId"] ?? "",
              "rackets": RacketA.value?.toString() ?? "",
              "playerType": "player1",
              // "racketB": RacketB.value?.toString() ?? "",
              // "racketC": RacketC.value?.toString() ?? "",
              // "racketD": RacketD.value?.toString() ?? "",
              "balls": Balls.value?.toString() ?? "",
            },
          if (team1.length > 1 && team1[1] != null)
            {
              "playerId": team1[1]["playerId"] ?? "",
              "rackets": "0",
              // "racketB": "0",
              "playerType": "player2",
              // "racketC": "0",
              // "racketD": "0",
              "balls": "0",
            }
        ],
        // Always include team2, even if empty
        team2: team2.isEmpty ? [] : [
          if (team2.isNotEmpty && team2[0] != null)
            {
              "playerId": team2[0]["playerId"] ?? "",
              "rackets": "" ?? "",
              "playerType": "player3",
              // "racketB": "" ?? "",
              // "racketC": "" ?? "",
              // "racketD": "" ?? "",
              "balls": "" ?? "",
            },
          if (team2.length > 1 && team2[1] != null)
            {
              "playerId": team2[1]["playerId"] ?? "",
              "rackets": "0",
              // "racketB": "0",
              "playerType": "player4",
              // "racketC": "0",
              // "racketD": "0",
              "balls": "0",
            }
        ],
        venueId: venueId.value ?? "",
        courtId: courtId?.value ?? "",
        bookingDate: bookingDate.value?.toString() ?? "",
        bookingSlots: bookingSlots,
        bookingType: PayBooking.value ? "Booking" : "Complete",
      );




      final response =
          await _apiRepository.bookCourtApi(dataBody: requestModel);

      if (response != null) {
        bookingResponseModel.value = response;

        paymentVerifyOtp(bookingResponseModel.value.data?.transaction?.sId);
        // Get.offNamed("/mybookings");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      loading.value = false;
    }
  }

  void paymentVerifyOtp(String? bookingId) async {
    try {
      Map<String, dynamic> requestModel =
          BookingRequestModel.PaymentRequest(transactionId: bookingId ?? "",method:PaymentMethod.value=="Play Coins"?"playcoins":PaymentMethod.value=="Free"?"free":PaymentMethod.value=="Razor Pay"?"razorpay":"both");

      final response = await _apiRepository.PaymentApi(dataBody: requestModel);

      if (response != null) {

        loading.value = false;
        paymentModel.value = response;
        final profile = Get.put<MoreController>(MoreController());
        profile.getData();
        if(PaymentMethod.value =="Free"){
          Get.find<TabHomeController>().getCurrentLocation();
          Get.offNamed("/mybookings");
        }
      else if(PaymentMethod.value!="Play Coins"){
          if(paymentModel.value.data?.amount?.toInt()==0){
            Get.offNamed("/mybookings");

          }else{
            isLoading.value=false;
           openCheckout(paymentModel.value.data?.amount.toString(),paymentModel.value.data?.razorpayOrderId);
          }

        }else{
          Get.offNamed("/mybookings");
        }




      }
    } catch (e) {
      loading.value = false;
      Get.snackbar("Error", e.toString());
    }finally{
      loading.value=false;
    }
  }

  // Helper method to format booking slots for display
  String getFormattedBookingSlots() {
    return bookingSlots.isNotEmpty
        ? bookingSlots.join(',')
        : 'No slots selected';
  }
}
