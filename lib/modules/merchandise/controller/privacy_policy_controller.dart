import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../repository/api_repository.dart';
import '../model /ContentModel.dart';

class PrivacyPolicyController extends GetxController {

  var title="".obs;

  final APIRepository _apiRepository = Get.find<APIRepository>();

  Rx<ContentResponseModel> contentData = ContentResponseModel().obs;
  RxBool loading = false.obs;

@override
  void onInit() {
  GetContent();
  if(Get.arguments!=null){
    title.value=Get.arguments["title"];

  }

    // TODO: implement onInit
    super.onInit();
  }
  void GetContent() async {
    loading.value = true;
    try {
      final response = await _apiRepository.GetContentApi();

      if (response != null) {
        contentData.value = response;

      }
    } catch (e) {
      debugPrint('Error fetching orders: $e');
      Get.snackbar('Error', 'Failed to fetch order items');
    } finally {
      loading.value = false;
    }
  }


  // HTML content for the privacy policy
  final String privacyPolicyHtml = """
    
    <p>Lorem Ipsum is simply dummy text of the printing and typesetting industry. 
    Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, 
    when an unknown printer took a galley of type and scrambled it to make a type specimen book. 
    It has survived not only five centuries, but also the leap into electronic typesetting, 
    remaining essentially unchanged. It was popularised in the 1960s with the release of 
    Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing 
    software like Aldus PageMaker including versions of Lorem Ipsum.</p>
    <p>Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece 
    of classical Latin literature from 45 BC, making it over 2000 years old.</p>
  """;

  void goBack() {
    Get.back();
  }
}