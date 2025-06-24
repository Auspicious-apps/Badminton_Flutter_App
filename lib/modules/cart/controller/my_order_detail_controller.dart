import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../repository/api_repository.dart';
import '../model/myOrderDetailResponseModel.dart';

class myOrderDetailController extends GetxController {
  final APIRepository _apiRepository = Get.find<APIRepository>();

  Rx<MyOrderDetailResponseModel> myOrderDetail = MyOrderDetailResponseModel().obs;
  RxBool loading = false.obs;
  var items = [
    {"name": "HEAD Radical Elite", "price": 6250.00, "quantity": 2},

  ].obs;

  // Pickup and contact details
  var pickupLocation = "Sector 24, Chandigarh".obs;
  var contactNumber = "+91 25786 45879".obs;




  // Compute total bill amount reactively
  double get totalBill {
    return items.fold(0, (sum, item) => sum + (item["price"] as double) * (item["quantity"] as int));
  }

@override
  void onInit() {
  if(Get.arguments!=null){
    final orderId=Get.arguments["orderId"];
    print(">>>>>>>>>>>>>>>>${orderId}");
    GetMyOrders(orderId);
  }
    super.onInit();
  }


  void GetMyOrders(String? OrderId ) async {
    loading.value = true;
    try {
      final response = await _apiRepository.MyOrderDetailApiCall(OrderId: OrderId);

      if (response != null) {
        myOrderDetail.value = response;
        myOrderDetail.refresh();
        // Convert API response to Order objects

      }
    } catch (e) {
      debugPrint('Error fetching orders: $e');
      Get.snackbar('Error', 'Failed to fetch order items');
    } finally {
      loading.value = false;
    }
  }
}