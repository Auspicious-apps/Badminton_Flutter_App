import 'package:badminton/modules/auth_module/models/forget_password_responsemodel.dart';
import 'package:get/get.dart';

import '../../../repository/api_repository.dart';
import '../../auth_module/models/auth_requestmodel.dart';
import '../models/Get_friend_request_model.dart';
import '../models/individual_chat_start.dart';

class FriendsController extends GetxController {
  Rx<GetRequestsResponseModel> userdata = GetRequestsResponseModel().obs;
  Rx<ForgetPasswordModel> confirmRequest = ForgetPasswordModel().obs;

  final APIRepository _apiRepository = Get.find<APIRepository>();
  RxBool loading = false.obs;
  // Sample data for friend requests and friends (replace with actual data source)
  Rx<IndividualStartChat> individualchat = IndividualStartChat().obs;
  @override
  void onInit() {
    getFriendRequest();
    super.onInit();
  }

  Future<void> getFriendRequest() async {
    loading.value = true;
    Get.closeAllSnackbars(); //
    try {
      final response =
          await _apiRepository.getRequest({"status": "friends-requests"});
      if (response != null) {
        userdata.value = response;
        loading.value = false;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.TOP);
      loading.value = false;
    } finally {
      loading.value = false;
    }
  }

  void sendMessage(String? receipentId) async {
    try {
      Map<String, dynamic> requestModel;

      requestModel = AuthRequestModel.MessageRequest(
        recipientId: receipentId,
      );

      final response =
          await _apiRepository.IndividualChatCreate(dataBody: requestModel);
      individualchat.value = response;
      individualchat.refresh();

      print(">>>>>>>>>>>>>>>${individualchat.value.data?.sId}");

      Get.toNamed("/chat_screen",
          arguments: {"id": individualchat.value.data?.sId});
    } catch (e) {
      print('Error sending message: $e');
      Get.snackbar('Error', 'Failed to send message');
    }
  }

  // // Navigation to BlockList page
  // void goToBlockList() {
  //   Get.to(());
  // }

  // Navigation to FriendRequests page
  void goToFriendRequests() async {
    await Get.toNamed("/allRequests");
    getFriendRequest();
  }

  // Go back
  void goBack() {
    Get.back();
  }

  // Handle confirm action for friend request (example)
  void confirmFriendRequest(String? id) async {
    print(">>>>>>>>>>>$id");
    try {
      loading.value = true;
      Map<String, dynamic> requestModel = AuthRequestModel.acceptRequestModel(
          requestId: id ?? "", status: "accepted");

      final response =
          await _apiRepository.confirmFriendRequest(dataBody: requestModel);

      if (response != null) {
        // loading.value=false;
        confirmRequest.value = response;

        Get.snackbar("Success", confirmRequest.value.message ?? "");

        getFriendRequest();
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      loading.value = false;
    } finally {
      loading.value = false;
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
  void cancelFriendRequest(String? id) async {
    print(">>>>>>>>>>>$id");
    try {
      loading.value = true;
      Map<String, dynamic> requestModel = AuthRequestModel.acceptRequestModel(
          requestId: id ?? "", status: "rejected");

      final response =
          await _apiRepository.confirmFriendRequest(dataBody: requestModel);

      if (response != null) {
        // loading.value=false;
        confirmRequest.value = response;

        Get.snackbar("Success", confirmRequest.value.message ?? "");

        getFriendRequest();
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      loading.value = false;
    } finally {
      loading.value = false;
    }
  }

  void removeFriendRequest(String? id) async {
    print(">>>>>>>>>>>$id");
    try {
      loading.value = true;
      Map<String, dynamic> requestModel = AuthRequestModel.acceptRequestModel(
          requestId: id ?? "", status: "unfriend");

      final response =
          await _apiRepository.confirmFriendRequest(dataBody: requestModel);

      if (response != null) {
        // loading.value=false;
        confirmRequest.value = response;

        Get.snackbar("Success", confirmRequest.value.message ?? "");

        getFriendRequest();
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      loading.value = false;
    } finally {
      loading.value = false;
    }
  }

  void blockFriend(String? id) async {
    print(">>>>>>>>>>>$id");
    try {
      loading.value = true;
      Map<String, dynamic> requestModel = AuthRequestModel.blockRequestModel(
        userId: id ?? "",
      );

      final response =
          await _apiRepository.blockFriendRequest(dataBody: requestModel);

      if (response != null) {
        // loading.value=false;
        confirmRequest.value = response;

        Get.snackbar("Success", confirmRequest.value.message ?? "");

        getFriendRequest();
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      loading.value = false;
    } finally {
      loading.value = false;
    }
  }
}
