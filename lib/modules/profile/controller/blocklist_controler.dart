import 'package:get/get.dart';

import '../../../repository/api_repository.dart';
import '../../auth_module/models/auth_requestmodel.dart';
import '../../auth_module/models/forget_password_responsemodel.dart';
import '../models/Get_friend_request_model.dart';
import '../models/blocklist_datamodel.dart';

class BlockListController extends GetxController {
  Rx<BlocklistModel> userdata = BlocklistModel().obs;
  final APIRepository _apiRepository = Get.find<APIRepository>();
  Rx<ForgetPasswordModel> confirmRequest = ForgetPasswordModel().obs;
  final blockList = [
    {"name": "Rowan Lopez"},
    {"name": "Jane Smith"},
    {"name": "Alex Johnson"},
    {"name": "Emily Davis"},
  ].obs; // Observable list for reactive updates
  RxBool loading = false.obs;
  // Function to handle navigation back

  @override
  void onInit() {
    super.onInit();
    getBlockList(); // Fetch data on initialization
  }

  Future<void> getBlockList() async {
    loading.value = true;
    Get.closeAllSnackbars();
    try {
      final response =
      await _apiRepository.getBlockedUsers({'status': 'blocked'});
      if (response != null) {
        userdata.value = response;
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      loading.value = false;
    }
  }

  void goBack() {
    Get.back();
  }

  void blockFriend(String? id) async {
    print(">>>>>>>>>>>$id");
    loading.value = true;
    try {

      Map<String, dynamic> requestModel = AuthRequestModel.blockRequestModel(
        userId: id ?? "",
      );

      final response =
      await _apiRepository.blockFriendRequest(dataBody: requestModel);

      if (response != null) {
        // loading.value=false;
        confirmRequest.value = response;
        Get.snackbar("Success", confirmRequest.value.message ?? "");
        getBlockList();
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
      loading.value = false;
    } finally {
      loading.value = false;
    }
  }



  // Function to handle option button tap (example)
  void onOptionTap(int index) {
    // Implement option logic here, e.g., show a dialog or menu
    print("Option tapped for ${blockList[index]['name']}");
  }
}