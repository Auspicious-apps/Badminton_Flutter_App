import 'package:get/get.dart';

import '../../../repository/api_repository.dart';
import '../../auth_module/models/auth_requestmodel.dart';
import '../../auth_module/models/forget_password_responsemodel.dart';
import '../models/Get_friend_request_model.dart';

class FriendRequestsController extends GetxController {
  // Simulated list of friend requests
  Rx<GetRequestsResponseModel> userdata = GetRequestsResponseModel().obs;
  Rx<ForgetPasswordModel> confirmRequest = ForgetPasswordModel().obs;


  final APIRepository _apiRepository = Get.find<APIRepository>();
  RxBool loading = false.obs;
  // Sample data for friend requests and friends (replace with actual data source)


  @override
  void onInit() {
    getFriendRequest();
    super.onInit();
  }

  Future<void> getFriendRequest()async {
    loading.value=true;
    Get.closeAllSnackbars(); //
    try {
      final response = await _apiRepository.getRequest({"status":"friends-requests"});
      if (response != null) {
        userdata.value = response;
        loading.value=false;

      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.TOP);
      loading.value=false;
    }finally{
      loading.value=false;
    }
  }
  // Navigation to BlockList page


  // Navigation to FriendRequests page
  void goToFriendRequests() {
    Get.toNamed("/allRequests");
  }

  // Go back
  void goBack() {
    Get.back();
  }

  // Handle confirm action for friend request (example)
  void confirmFriendRequest(String? id)async {
    print(">>>>>>>>>>>$id");
    try{
      loading.value=true;
      Map<String, dynamic> requestModel = AuthRequestModel.acceptRequestModel(
          requestId: id ??"",
          status: "accepted"
      );

      final response = await _apiRepository.confirmFriendRequest(dataBody: requestModel);

      if (response != null) {
        // loading.value=false;
        confirmRequest.value=response;

        Get.snackbar("Success",confirmRequest.value.message??"" );

        getFriendRequest();
      }


    } catch (e) {
      Get.snackbar("Error", e.toString());
      loading.value=false;
    }finally{
      loading.value=false;
    }

  }
  Future<void> refreshData() async {
    try {
      // Set loading to true
      loading.value = true;
      getFriendRequest();


    } catch (e) {
      // Handle errors (e.g., show a snackbar)
      Get.snackbar('Error', 'Failed to refresh data: $e');
    } finally {
      // Set loading to false
      loading.value = false;
    }
  }
  // Handle cancel action for friend request (example)
  void cancelFriendRequest(String? id)async {
    print(">>>>>>>>>>>$id");
    try{
      loading.value=true;
      Map<String, dynamic> requestModel = AuthRequestModel.acceptRequestModel(
          requestId: id ??"",
          status: "rejected"
      );

      final response = await _apiRepository.confirmFriendRequest(dataBody: requestModel);

      if (response != null) {
        // loading.value=false;
        confirmRequest.value=response;

        Get.snackbar("Success",confirmRequest.value.message??"" );

        getFriendRequest();
      }


    } catch (e) {
      Get.snackbar("Error", e.toString());
      loading.value=false;
    }finally{
      loading.value=false;
    }
  }

}