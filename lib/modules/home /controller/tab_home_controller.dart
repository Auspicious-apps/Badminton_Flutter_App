import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get_storage/get_storage.dart';

import '../../../repository/api_repository.dart';
import '../../auth_module/models/user_response_model.dart';
import '../models/home_response_model.dart';

class TabHomeController extends GetxController {
  final RxInt currentBannerIndex = 0.obs;
  var location = "My Location".obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  final APIRepository _apiRepository = Get.find<APIRepository>();
  Rx<HomeDataModel> responseModel = HomeDataModel().obs;
  RxBool loading = true.obs;
  Rx<userResponseModel> ProfileData = userResponseModel().obs;

  void updateBannerIndex(int index) {
    currentBannerIndex.value = index;
  }

  @override
  void onReady() {
    super.onReady();
    getCurrentLocation();
    getProfile();
  }

  Future getProfile() async {


    try {
      final response = await _apiRepository.getuser();
      if (response != null) {
        ProfileData.value = response;
        ProfileData.refresh();


      }
    } catch (e) {
      loading.value=false;
      Get.snackbar("Error", e.toString());
    }

  }

  Future getData () async {
    loading.value=true;
    try {
      final response = await _apiRepository.getHomeDataApi(query:{
        "lng":longitude.value,
        "lat":latitude.value,
      });
      if (response != null) {
        responseModel.value = response;
        loading.value=false;
        responseModel.refresh();
        print("token: ${responseModel.value.data?.venueNearby?.length}????????????");

      }
    } catch (e) {
      loading.value=false;
      Get.snackbar("Error", e.toString());
    }

  }

  Future<void> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      location.value = "Location services are disabled.";
      return;
    }

    // Check for permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        location.value = "Location permission denied.";
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      location.value = "Location permission permanently denied.";
      return;
    }

    // Get position
    final Position pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    latitude.value = pos.latitude;
    longitude.value = pos.longitude;
    // getData();
    getData();
  }

}
