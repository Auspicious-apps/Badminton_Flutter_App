import 'dart:async';

import 'package:badminton/modules/profile/models/AllUsersModel.dart';
import 'package:get/get.dart';

import '../../../repository/api_repository.dart';

class AllUsersController extends GetxController {
  // Observable lists for friend requests and friends
  Timer? debounce;
  final searchQuery = ''.obs;
  Rx<AllUsersModel> allUsers = AllUsersModel().obs;

  final APIRepository _apiRepository = Get.find<APIRepository>();
  RxBool loading = false.obs;
  @override
  void onInit() {
    super.onInit();
    getVenueData();
    // friendRequests.addAll([
    //   {'name': 'Rowan Lopez', 'image': 'assets/racket.png'},
    //   {'name': 'Alice Brown', 'image': 'assets/racket.png'},
    //   {'name': 'Bob Wilson', 'image': 'assets/racket.png'},
    //   {'name': 'Emma Davis', 'image': 'assets/racket.png'},
    // ]);


  }


  Future getVenueData() async {
    try {
      loading.value=true;
      final response = await _apiRepository.getAllUsers(query:{
      "page":1,
        "limit":50,
        "search":searchQuery.value?.trim()

      });
      if (response != null) {
        allUsers.value = response;
        allUsers.refresh();

        loading.value=false;
        print("token: ${ allUsers.value.data?.length}????????????");

      }
    } catch (e) {
      loading.value=false;
      Get.snackbar("Error", e.toString());
    }
  }

  // Handle three-dot menu actions
  void handleMenuAction(String action) {
    switch (action) {
      case 'refresh':
      // Simulate refreshing data
        Get.snackbar('Refresh', 'Friends list refreshed!');
        break;
      case 'sort':
      // Sort friends alphabetically

        Get.snackbar('Sort', 'Friends sorted alphabetically!');
        break;
    }
  }
}