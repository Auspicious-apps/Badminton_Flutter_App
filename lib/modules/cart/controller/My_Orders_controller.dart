
import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../repository/api_repository.dart';
import '../../../repository/endpoint.dart';
import '../model/my_orders_responseModel.dart';
import '../view/orderSummary.dart';

class Order {
  final String orderId;
  final String title;
  final String imagePath;
  final String location;
  final String dateTime;
  final int quantity;
  final String price;
  final String status;
  final String paymentStatus;

  Order({
    required this.orderId,
    required this.title,
    required this.imagePath,
    required this.location,
    required this.dateTime,
    required this.quantity,
    required this.price,
    this.status = 'Processing',
    this.paymentStatus = 'Pending',
  });
}

class PgMyOrderController extends GetxController {
  // Reactive list of orders
  final RxList<Order> orders = <Order>[].obs;
  final APIRepository _apiRepository = Get.find<APIRepository>();

  Rx<My_Orders_Response> OrderListData = My_Orders_Response().obs;
  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    GetMyOrders();
  }

  // Handle back button press
  void onBackPressed() {
    Get.back();
  }

  void GetMyOrders() async {
    loading.value = true;
    try {
      final response = await _apiRepository.GetMyOrders(query:{
        "page":1,
        "limit":100
      });
      
      if (response != null) {
        OrderListData.value = response;
        // Convert API response to Order objects
        processOrderData();
      }
    } catch (e) {
      debugPrint('Error fetching orders: $e');
      Get.snackbar('Error', 'Failed to fetch order items');
    } finally {
      loading.value = false;
    }
  }

  // Process order data from API response
  void processOrderData() {
    orders.clear();
    
    if (OrderListData.value.data != null && OrderListData.value.data!.isNotEmpty) {
      for (var orderData in OrderListData.value.data!) {
        // For each order, we'll create an Order object for each item in the order
        if (orderData.items != null && orderData.items!.isNotEmpty) {
          for (var item in orderData.items!) {
            orders.add(Order(
              orderId: orderData.orderId ?? '',
              title: item.name ?? 'Product',
              imagePath: item.image != null ? "$imageBaseUrl${item.image}" : AppAssets.rackettt,
              location: getVenueAddress(orderData.venue),
              dateTime: formatOrderDate(orderData.orderDate),
              quantity: item.quantity ?? 1,
              price: "₹${(item.price?? 0)* (item.quantity??0) }",
              status: orderData.status ?? 'Processing',
              paymentStatus: orderData.paymentStatus ?? 'Pending'
            ));
          }
        } else {
          // If no items, still add the order with placeholder data
          orders.add(Order(
            orderId: orderData.orderId ?? '',
            title: "Order #${orderData.orderId?.substring(0, 8) ?? ''}",
            imagePath: AppAssets.rackettt,
            location: getVenueAddress(orderData.venue),
            dateTime: formatOrderDate(orderData.orderDate),
            quantity: 0,
            price: "₹${orderData.totalAmount ?? 0}",
            status: orderData.status ?? 'Processing',
            paymentStatus: orderData.paymentStatus ?? 'Pending'
          ));
        }
      }
    }
  }

  // Helper method to get venue address
  String getVenueAddress(Venue? venue) {
    if (venue == null) return "No venue information";
    
    List<String> addressParts = [];
    if (venue.name != null && venue.name!.isNotEmpty) 
      addressParts.add(venue.name!);
    if (venue.address != null && venue.address!.isNotEmpty) 
      addressParts.add(venue.address!);
    
    return addressParts.join(", ");
  }

  // Helper method to format order date
  String formatOrderDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) return "No date";
    
    try {
      DateTime date = DateTime.parse(dateString).toLocal();
      // Format: "Nov 10, 2024 | 08:00 A.M."
      String month = _getMonthAbbreviation(date.month);
      String day = date.day.toString();
      String year = date.year.toString();
      String hour = date.hour > 12 ? (date.hour - 12).toString().padLeft(2, '0') : date.hour.toString().padLeft(2, '0');
      String minute = date.minute.toString().padLeft(2, '0');
      String period = date.hour >= 12 ? "P.M." : "A.M.";
      
      return "$month $day, $year | $hour:$minute $period";
    } catch (e) {
      return dateString; // Return original string if parsing fails
    }
  }

  // Helper method to get month abbreviation
  String _getMonthAbbreviation(int month) {
    const months = [
      "Jan", "Feb", "Mar", "Apr", "May", "Jun", 
      "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
    ];
    return months[month - 1];
  }

  // Handle order item tap
  void onOrderTapped(BuildContext context, int index) {
    // Navigate to order details page
    if (index < orders.length) {
      final order = orders[index];
      
      // Find the full order data
      final fullOrderData = OrderListData.value.data?.firstWhere(
        (element) => element.orderId == order.orderId,
        orElse: () => MyOrderData()
      );
      
      if (fullOrderData != null) {
        Get.toNamed("my_orders_detail",arguments: {"orderId": order.orderId});

        // Get.to(() => PgOrderSummary(), arguments: {
        //   "orderId": order.orderId,
        //   "orderData": fullOrderData,
        //   "isFromOrderHistory": true
        // });
      }
    }
  }
}
