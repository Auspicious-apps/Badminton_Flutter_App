import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../repository/api_repository.dart';
import '../../cart/model/transaction_history_response.dart';

class PlayCoinsController extends GetxController {

  final List<Map<String, dynamic>> transactionHistory = [
    {
      'title': 'Added to wallet',
      'amount': '+₹2000',
      'date': '23 July 2024',
    },
    {
      'title': 'Added to wallet',
      'amount': '+₹1500',
      'date': '20 July 2024',
    },
    {
      'title': 'Added to wallet',
      'amount': '+₹1000',
      'date': '15 July 2024',
    },
    {
      'title': 'Added to wallet',
      'amount': '+₹500',
      'date': '10 July 2024',
    },
  ];

  // Total play coins and matches played
  final String totalPlayCoins = '₹2000';
  final String matchesPlayed = '200 matches played';

  final APIRepository _apiRepository = Get.find<APIRepository>();

  Rx<TransactionResponseModel> transactionHistoryData = TransactionResponseModel().obs;
  RxBool loading = false.obs;

  @override
  void onInit() {
    GetContent();


    // TODO: implement onInit
    super.onInit();
  }


  void GetContent() async {
    loading.value = true;
    try {
      final response = await _apiRepository.GetTrasactions();

      if (response != null) {
        transactionHistoryData.value = response;

      }
    } catch (e) {
      debugPrint('Error fetching orders: $e');
      // Get.snackbar('Error', 'Failed to fetch order items');
    } finally {
      loading.value = false;
    }
  }


  void goBack() {
    Get.back();
  }
}