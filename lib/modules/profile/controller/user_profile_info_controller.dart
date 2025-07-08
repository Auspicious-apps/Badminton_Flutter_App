import 'package:badminton/modules/profile/models/individual_chat_start.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../repository/api_repository.dart';
import '../../auth_module/models/auth_requestmodel.dart';
import '../../auth_module/models/forget_password_responsemodel.dart';
import '../models/friend_Request_Responsemodel.dart';
import '../models/get_user_by_id_model.dart';

class PgProfileDetailController extends GetxController {
  var friendId = "".obs;
  RxBool loading = true.obs;
  RxBool load = false.obs;
  RxBool isAdmin = false.obs;
  final profile = <String, dynamic>{
    'name': 'Rebecca Black',
    'lastPlayed': '14th Jun 2023',
    'image': 'assets/rank_profile.png',
    'level': '3436',
    'lastMonthLevel': '-1',
    'levelThisMonth': '-1',
    'levelSixMonthsAgo': '-1',
    'levelTwelveMonthsAgo': '-1',
    'improvement': '-0.01',
    'confidence': '27%',
  }.obs;

  FriendRequestResponseModel responseModel = FriendRequestResponseModel();
  Rx<GetUserIdResponseModel> userdata = GetUserIdResponseModel().obs;
  final previousGames = <Map<String, dynamic>>[].obs;

  Rx<ForgetPasswordModel> confirmRequest = ForgetPasswordModel().obs;
  Rx<IndividualStartChat> individualchat = IndividualStartChat().obs;
  final APIRepository _apiRepository = Get.find<APIRepository>();
  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      print(">>>>>>>>>id>>>>>>>>>>>${Get.arguments['isAdmin']}");
      friendId.value = Get.arguments['id'];
      isAdmin.value = Get.arguments['isAdmin'];

      friendGetById();
      ;
    }
    // // Initialize dummy previous games data
    // previousGames.addAll([
    //   {
    //     'type': 'Padel',
    //     'duration': '90min',
    //     'matchType': 'Friendly Match',
    //     'availability': ['Available', 'Available'],
    //     'location': 'Kemmer Trafficway, West Zenatown',
    //     'dateTime': 'Nov 10, 2024 | 08:00 A.M.',
    //     'team1': {'name': 'Team 1', 'score': '3 3 3', 'points': ''},
    //     'team2': {'name': 'Team 2', 'score': '2 2 2'},
    //   },
    //   {
    //     'type': 'Padel',
    //     'duration': '90min',
    //     'matchType': 'Friendly Match',
    //     'availability': ['Available', 'Available'],
    //     'location': 'Kemmer Trafficway, West Zenatown',
    //     'dateTime': 'Nov 10, 2024 | 08:00 A.M.',
    //     'team1': {'name': 'Team 1', 'score': '3 3 3', 'points': ''},
    //     'team2': {'name': 'Team 2', 'score': '2 2 2'},
    //   },
    // ]);
  }

  void friendGetById() async {
    loading.value = true;
    Get.closeAllSnackbars(); //
    try {
      final response = await _apiRepository.getUserId(id: friendId.value);
      if (response != null) {
        userdata.value = response;
        userdata.refresh();
        loading.value = false;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.TOP);
      loading.value = false;
    }
  }

  void RefreshId() async {
    load.value = true;
    Get.closeAllSnackbars(); //
    try {
      final response = await _apiRepository.getUserId(id: friendId.value);
      if (response != null) {
        userdata.value = response;
        userdata.refresh();
        load.value = false;
      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.TOP);
      load.value = false;
    }
  }

  void addFriend() async {
    Get.closeAllSnackbars(); //
    load.value = true;

    try {
      Map<String, dynamic> requestModel =
          AuthRequestModel.sendFriendRequest(friendId: friendId.value);

      final response =
          await _apiRepository.sendFriendRequest(dataBody: requestModel);
      if (response != null) {
        load.value = false;
        responseModel = response;
        Get.snackbar("Success", responseModel.message ?? "");
        RefreshId();
      }
    } catch (e) {
      load.value = false;
      loading.value = false;
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.TOP);
    }
  }

  void confirmFriendRequest() async {
    try {
      Map<String, dynamic> requestModel = AuthRequestModel.acceptRequestModel(
          requestId: userdata.value.data?.relationshipId ?? "",
          status: "accepted");

      final response =
          await _apiRepository.confirmFriendRequest(dataBody: requestModel);

      if (response != null) {
        // loading.value=false;
        confirmRequest.value = response;

        Get.snackbar("Success", confirmRequest.value.message ?? "");
        RefreshId();
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      loading.value = false;
    } finally {
      loading.value = false;
    }
  }

  void removeFriendRequest() async {
    try {
      load.value = true;
      Map<String, dynamic> requestModel = AuthRequestModel.acceptRequestModel(
          requestId: userdata.value.data?.relationshipId ?? "",
          status: "unfriend");

      final response =
          await _apiRepository.confirmFriendRequest(dataBody: requestModel);

      if (response != null) {
        // loading.value=false;
        confirmRequest.value = response;

        Get.snackbar("Success", confirmRequest.value.message ?? "");
        RefreshId();
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      load.value = false;
    } finally {
      load.value = false;
    }
  }
  // // Method to handle Message action
  // void sendMessage() {
  //     Get.toNamed("/chat_screen",arguments: {"id":userdata.value.data?.sId});
  // }

  void sendMessage() async {
    try {
      Map<String, dynamic> requestModel;

      requestModel = AuthRequestModel.MessageRequest(
        recipientId: userdata.value.data?.sId,
      );

      final response =
          await _apiRepository.IndividualChatCreate(dataBody: requestModel);
      individualchat.value = response;
      individualchat.refresh();

      print(">>>>>>>>>>>>>>>${individualchat.value.data?.sId}");

      Get.toNamed("/chat_screen",
          arguments: {"id": individualchat.value.data?.sId});
    } catch (e) {
      debugPrint('Error sending message: $e');
      Get.snackbar('Error', 'Failed to send message');
    }
  }

  // Method to handle Modify action for a game
  void modifyGame(int index) {
    Get.snackbar('Modify', 'Modifying game at index $index');
  }
}
