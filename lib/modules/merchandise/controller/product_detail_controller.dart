// lib/controllers/pg_product_detail_controller.dart
import 'package:badminton/modules/merchandise/model%20/product_detail_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../repository/api_repository.dart';
import '../model /AllmerchandiseModel.dart';

class PgProductDetailController extends GetxController {
  var selectedIndex = 0.obs;

  RxBool loading = true.obs;
  RxBool team1select = false.obs;

  RxBool team2select = false.obs;
  final APIRepository _apiRepository = Get.find<APIRepository>();


  Rx<ProductDetailModel> allMerchandise = ProductDetailModel().obs;
  var Id = "".obs;
  var primaryImage = "".obs;
  RxList products = RxList([]);



  @override
  void onInit() {
    if(Get.arguments!=null){
      Id.value=Get.arguments['id'];
      getMerchandiseById( Id.value);


    }
    super.onInit();
  }



  Future getMerchandiseById(id) async {
    loading.value=true;
    try {
      final response = await _apiRepository.getMerchandiseById(Id: id);
      if (response != null) {
        allMerchandise.value = response;
        allMerchandise.refresh();
        print(allMerchandise.value.data?.productName);
        primaryImage.value=allMerchandise.value.data?.primaryImage??"";
        products.value=allMerchandise.value.data?.thumbnails??[];

        if(allMerchandise.value.data?.thumbnails?.length!=0){
          products.insert(0, primaryImage.value);
        }

      }
    } catch (e) {
      loading.value=false;
      Get.snackbar("Error", e.toString());
    }finally{
      loading.value=false;
    }

  }



  void updateSelectedIndex(int index) {
    selectedIndex.value = index;
  }
}