// lib/controllers/play_controller.dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:linear_calender/linear_calender.dart';

import '../../../app_settings/components/label.dart';
import '../../../app_settings/constants/app_colors.dart';
import '../../../app_settings/constants/app_dim.dart';
import '../../../app_settings/constants/common_button.dart';
import '../../../repository/api_repository.dart';
import '../../auth_module/models/user_response_model.dart';
import '../../creategames/model/BookingResponseModel.dart';
import '../models/getOpenResponseModel.dart';

class PlayController extends GetxController {
  RxBool loading = true.obs;
  final APIRepository _apiRepository = Get.find<APIRepository>();
  Rx<GetOpenResponseModel> bookList = GetOpenResponseModel().obs;
  var location = "My Location".obs;
  var latitude = 0.0.obs;
  var longitude = 0.0.obs;
  var currentDate = "".obs;
  var game = "Padel".obs;
  final matches = List.generate(4, (index) => {}).obs;
  Rx<userResponseModel> ProfileData = userResponseModel().obs;

  @override
  void onInit() {
    getProfile();
    super.onInit();
  }


  void showCalendarBottomSheet(
      BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return Container(
          height: Get.height * 0.5,
          width: Get.width,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Select Date',
                      style:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                LinearCalendar(
                  itemWidth: 50,
                  selectedTextStyle:
                  TextStyle(fontSize: 10, color: Colors.white),
                  unselectedTextStyle:
                  TextStyle(fontSize: 10, color: Colors.black),

                  selectedColor: AppColors.primaryColor,

                  unselectedColor: AppColors.whiteColor,
                  onChanged: (DateTime value) {
                    currentDate.value = DateFormat('yyyy-MM-dd').format(value);
                    // getVenueData(date: currentDate.value);
                    // onDateConfirmed(value);
                  },
                  height: 70,
                  key: ValueKey(currentDate.value),
                  startDate:DateTime.now(),
                  backgroundColor: Colors.transparent,
                ),

                const Text(
                  'Select Game',
                  style:
                  TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ).marginSymmetric(vertical: 10),
                Row(
                  children: [
                    GestureDetector(
                      onTap:(){

                        game.value="Padel";
                      },
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Row(

                            children: [
                              Obx(()=>  Container(
                                height: 20,
                                width: 20,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8),
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: AppColors.border,
                                  borderRadius:
                                  BorderRadius.circular(15),
                                ),
                                child:game.value=="Padel"? Container(
                                  padding: const EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius:
                                    BorderRadius.circular(15),
                                  ),
                                ):SizedBox(),
                              )),
                              padHorizontal(15),
                              const Label(
                                txt: "Paddle",
                                type: TextTypes.f_14_500,
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                    SizedBox(width: 20,),
                    GestureDetector(
                      onTap:(){

                        game.value="Pickleball";
                      },
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Obx(()=>  Container(
                                height: 20,
                                width: 20,
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8),
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: AppColors.border,
                                  borderRadius:
                                  BorderRadius.circular(15),
                                ),
                                child:game.value=="Pickleball"? Container(
                                  padding: const EdgeInsets.all(7),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius:
                                    BorderRadius.circular(15),
                                  ),
                                ):SizedBox(),
                              )),
                              padHorizontal(15),
                              const Label(
                                txt: "Pickleball",
                                type: TextTypes.f_14_500,
                              ),
                            ],
                          ),

                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Spacer(),
                Row(
                  children: [
                    Expanded(
                        child:GestureDetector(onTap:() {
                          Get.back();
                        } ,child:
                        Container(height:50,decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8),border: Border.all(color: AppColors.primaryColor)),child: Center(child: Label(txt: "Cancel", type: TextTypes.f_14_600,forceColor: AppColors.primaryColor,),),))
//                         commonButton(
//                           forceColor: Color(value),
//                             context: context,
//
//                             onPressed: () {
// Get.back();
//                             },
//                             txt: "Cancel"
//                         )
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                        child: commonButton(
                            context: context,
                            onPressed: () {
                              Get.back();
                              getBookingList();
                            },
                            txt: "Apply"
                        )
                    ),
                    // ElevatedButton(
                    //   onPressed: () {
                    //     Navigator.pop(context);
                    //     getVenueData(date: currentDate.value);
                    //   },
                    //   child: const Text('Confirm'),
                    // ),
                  ],
                ).marginSymmetric(vertical: 20),
              ],
            ),
          ),
        );
      },
    );
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
  @override
  void onReady() {
    super.onReady();
    getCurrentLocation();

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
    getBookingList();

  }

   getBookingList()async {
    loading.value=true;
    Get.closeAllSnackbars(); //
    try {
      final response = await _apiRepository.getAllopenBookings(query:{
        "lng":longitude.value,
        "lat":latitude.value,
        "date":currentDate.value,
        "game":game.value

      });
      if (response != null) {
        bookList.value = response;
        loading.value=false;

      }
    } catch (e) {
      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.TOP);
      loading.value=false;
    }finally{
      loading.value=false;
    }
  }


  void onJoinMatch(int index) {
    // Logic for joining a match
    print("Joining match at index: $index");
  }
}
