// lib/controllers/merchandise_controller.dart
import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../repository/api_repository.dart';
import '../model /AllmerchandiseModel.dart';
import '../model /product_model.dart';


class MerchandiseController extends GetxController {
  // Reactive variables for selected buttons
  var selectedButton = 0.obs;
  var selectedButton2 = 0.obs;
  var primaryImage = "".obs;
  RxBool loading = true.obs;
  RxBool team1select = false.obs;

  RxBool team2select = false.obs;
  final APIRepository _apiRepository = Get.find<APIRepository>();


  Rx<AllMerchadiseModel> allMerchandise = AllMerchadiseModel().obs;


  @override
  void onInit() {
    super.onInit();

    getAllMerchandise();
  }


  Future getAllMerchandise() async {
    loading.value=true;
    try {
      final response = await _apiRepository.getMerchandise(query: {"type":  selectedButton.value==0?"all":selectedButton.value==1?"Padel":"Pickleball"});
      if (response != null) {
        allMerchandise.value = response;
        allMerchandise.refresh();
        print(allMerchandise.value.data?.length);

      }
    } catch (e) {
      loading.value=false;
      Get.snackbar("Error", e.toString());
    }finally{
      loading.value=false;
    }

  }

  // void loadProducts() {
  //   // Sample data; replace with API call or other data source if needed
  //   products.assignAll([
  //     Product(
  //       name: "HEAD Radical Elite 2024 Padel Racquet",
  //       price: "₹15,749",
  //       oldPrice: "₹20,999",
  //       image: AppAssets.rackettt,
  //     ),
  //     Product(
  //       name: "HEAD Radical Elite 2024 Padel Racquet",
  //       price: "₹15,749",
  //       oldPrice: "₹20,999",
  //       image: AppAssets.rackettt,
  //     ),
  //     Product(
  //       name: "HEAD Radical Elite 2024 Padel Racquet",
  //       price: "₹15,749",
  //       oldPrice: "₹20,999",
  //       image: AppAssets.rackettt,
  //     ),
  //     Product(
  //       name: "HEAD Radical Elite 2024 Padel Racquet",
  //       price: "₹15,749",
  //       oldPrice: "₹20,999",
  //       image: AppAssets.rackettt,
  //     ),
  //   ]);
  // }





  void updateSelectedButton(int index) {
    selectedButton.value = index;
    getAllMerchandise();
  }

  // Method to update second selected button (if needed)
  void updateSelectedButton2(int index) {
    selectedButton2.value = index;
  }
}