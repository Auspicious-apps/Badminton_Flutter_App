import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:get/get.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../../../app_settings/constants/app_assets.dart';
import '../../../repository/api_repository.dart';
import '../../../repository/endpoint.dart';
import '../../auth_module/models/auth_requestmodel.dart';
import '../model/OrderResponse.dart';
import '../model/cart_item_model.dart';
import '../model/my_orders_responseModel.dart';
import 'cart_controller.dart';
import 'package:badminton/services/notification_service.dart';

class PgOrderSummaryController extends GetxController {
  // Observable variables
  var fcmToken = ''.obs; // Store FCM token
  var isLoading = false.obs; // Loading state for FCM or data fetching
  var orderItems = <Map<String, dynamic>>[].obs; // List of order items
  var totalAmount = 0.0.obs; // Total bill amount
  
  // Order data
  var orderData = <String, dynamic>{}.obs;
  var recipientName = ''.obs;
  var phoneNumber = ''.obs;
  var address = ''.obs;
  var cityStatePin = ''.obs;
  OrderCreateResponse orderCreateResponse = OrderCreateResponse();
  final APIRepository _apiRepository = Get.find<APIRepository>();
  late Razorpay _razorpay;
  
  // Flag to indicate if viewing from order history
  var isFromOrderHistory = false.obs;
  var orderId = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _razorpay = Razorpay();
    // Attach event listeners
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    getFCMToken();
    
    // Process arguments if available
    if (Get.arguments != null) {
      if (Get.arguments is Map<String, dynamic>) {
        Map<String, dynamic> args = Get.arguments;
        
        // Check if viewing from order history
        if (args.containsKey('isFromOrderHistory') && args['isFromOrderHistory'] == true) {
          isFromOrderHistory.value = true;
          orderId.value = args['orderId'] ?? '';
          
          // Process order data if available
          if (args.containsKey('orderData')) {
            processOrderHistoryData(args['orderData']);
          }
        } else {
          // Normal order flow
          processOrderData(args);
        }
      }
    } else {
      // If no arguments, fetch cart items directly
      loadCartItems();
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

      print("Error opening Razorpay: $e");
      Get.snackbar('Error', 'Failed to open Razorpay: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
    }
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
    final cartController = Get.find<CartController>();
     cartController.GetAddtocart();
     Get.offNamed("/my_orders");

  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // loading.value=false;
    // loading.refresh();
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
    // loading.value=false;
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
  
  // Get FCM token for notifications
  void getFCMToken() async {
    try {
      // Get notification service
      final notificationService = Get.find<NotificationService>();
      
      String? token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        fcmToken.value = token;
        print("FCM Token: $token");
      }
    } catch (e) {
      print("Error getting FCM token: $e");
    }
  }
  
  // Process order data from arguments
  void processOrderData(Map<String, dynamic> data) {
    orderData.value = data;
    
    // Extract address information
    if (data['address'] != null) {
      recipientName.value = data['address']['nameOfRecipient'] ?? '';
      phoneNumber.value = data['address']['phoneNumber'] ?? '';
      address.value = data['address']['street'] ?? '';
      cityStatePin.value = "${data['address']['city'] ?? ''}, ${data['address']['state'] ?? ''} ${data['address']['pinCode'] ?? ''}";
    }
    
    // Load order items based on the items array
    loadOrderItems(data['items'] ?? []);
  }
  
  // Load order items from cart controller
  void loadCartItems() {
    final cartController = Get.find<CartController>();
    
    orderItems.clear();
    for (var item in cartController.cartItems) {
      // Use discounted price if available, otherwise use regular price
      double priceToUse = item.discountedPrice > 0 ? item.discountedPrice : item.price;
      
      orderItems.add({
        'id': item.productId,
        'name': item.productName,
        'price': priceToUse,
        'actualPrice': item.price,
        'discountedPrice': item.discountedPrice,
        'quantity': item.quantity,
        'image': item.imageUrl
      });
    }
    
    // Calculate total amount
    calculateTotal();
  }
  
  // Load order items from provided items array
  void loadOrderItems(List<dynamic> items) {
    isLoading.value = true;
    
    // Get cart controller to access product details
    final cartController = Get.find<CartController>();
    
    orderItems.clear();
    for (var item in items) {
      // Find product details in cart
      int index = cartController.cartItems.indexWhere(
        (element) => element.productId == item['productId']
      );
      
      if (index >= 0) {
        // Use details from cart
        CartItem cartItem = cartController.cartItems[index];
        // Use discounted price if available, otherwise use regular price
        double priceToUse = cartItem.discountedPrice > 0 ? cartItem.discountedPrice : cartItem.price;
        
        orderItems.add({
          'id': cartItem.productId,
          'name': cartItem.productName,
          'price': priceToUse,
          'actualPrice': cartItem.price,
          'discountedPrice': cartItem.discountedPrice,
          'quantity': item['quantity'] ?? cartItem.quantity,
          'image': cartItem.imageUrl
        });
      } else {
        // If not found in cart, add with minimal info
        orderItems.add({
          'id': item['productId'],
          'name': 'Product',
          'price': 0.0,
          'actualPrice': 0.0,
          'discountedPrice': 0.0,
          'quantity': item['quantity'] ?? 1,
          'image': ''
        });
      }
    }
    
    // Calculate total amount
    calculateTotal();
    isLoading.value = false;
  }
  
  // Calculate total amount
  void calculateTotal() {
    double total = 0.0;
    for (var item in orderItems) {
      total += (item['price'] as double) * (item['quantity'] as int);
    }
    totalAmount.value = total;
  }


  void createOrder() async {
    isLoading.value = true;
    try {


      final response = await _apiRepository.OrderCartApiCall(dataBody: orderData.value);
      if (response != null) {
        orderCreateResponse=response;

        openCheckout(orderCreateResponse.data?.amount.toString(),orderCreateResponse.data?.razorpayOrderId);

      }
    } catch (e) {
      debugPrint('Error fetching cart: $e');
      Get.snackbar('Error', " $e");
    } finally {
      isLoading.value = false;
    }
  }

  // Process order history data
  void processOrderHistoryData(MyOrderData orderData) {
    // Set address information
    if (orderData.address != null) {
      recipientName.value = orderData.address?.nameOfRecipient ?? '';
      phoneNumber.value = orderData.address?.phoneNumber ?? '';
      address.value = orderData.address?.street ?? '';
      cityStatePin.value = "${orderData.address?.city ?? ''}, ${orderData.address?.state ?? ''} ${orderData.address?.pinCode ?? ''}";
    }
    
    // Set venue information
    if (orderData.venue != null) {
      // venueName.value = orderData.venue?.name ?? '';
      // venueAddress.value = orderData.venue?.address ?? '';
    }
    
    // Load order items
    orderItems.clear();
    if (orderData.items != null) {
      for (var item in orderData.items!) {
        orderItems.add({
          'id': item.productId ?? '',
          'name': item.name ?? 'Product',
          'price': item.price?.toDouble() ?? 0.0,
          'quantity': item.quantity ?? 1,
          'image': item.image != null ? "$imageBaseUrl${item.image}" : AppAssets.rackettt,
          'total': item.total?.toDouble() ?? 0.0
        });
      }
    }
    
    // Set total amount
    totalAmount.value = orderData.totalAmount?.toDouble() ?? 0.0;
    
    // Set order status
    // orderStatus.value = orderData.status ?? 'Processing';
    // paymentStatus.value = orderData.paymentStatus ?? 'Pending';
  }
}
