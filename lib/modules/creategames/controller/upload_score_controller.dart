import 'package:badminton/Pages/Notification/pg_notification.dart';
import 'package:badminton/modules/creategames/model/AllBookingsResponseModel.dart';
import 'package:badminton/modules/creategames/model/upload_Score_responseModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../repository/api_repository.dart';
import '../../courtscreens/models/booking_request_model.dart';

class UploadScoreController extends GetxController {
  RxBool loading = false.obs;
  final APIRepository _apiRepository = Get.find<APIRepository>();
 var selectedGame="".obs;
  RxBool showset1 = true.obs;
  RxBool showset2 = false.obs;
  RxBool showset3 = false.obs;
  Rx<UploadScoreResponseModel> scoresRates = UploadScoreResponseModel().obs;
  Rx<Score> scores = Score().obs;
 var address ="".obs;
  var time="".obs;
  var date ="".obs;
  var bookingId ="".obs;

  final SetP1 = TextEditingController();
  final SetP2 = TextEditingController();
  final SetP3 = TextEditingController();
  final SetP4 = TextEditingController();
  final SetP5 = TextEditingController();
  final SetP6 = TextEditingController();
 @override
 void onInit() {
     if(Get.arguments!=null){
       selectedGame.value=Get.arguments["game"];
       address.value=Get.arguments["address"];
       time.value=Get.arguments["time"];
       date.value=Get.arguments["date"];
       bookingId.value=Get.arguments["id"];
       scores.value=Get.arguments["score"];

       SetP1.text=scores.value?.set1?.team1.toString()??"";
       SetP2.text=scores.value?.set1?.team2.toString()??"";
       SetP3.text=scores.value?.set2?.team1.toString()??"";
       SetP4.text=scores.value?.set2?.team2.toString()??"";
       SetP5.text=scores.value?.set3?.team1.toString()??"";
       SetP6.text=scores.value?.set3?.team2.toString()??"";
     }
    super.onInit();
  }
  final matches = List.generate(
    4,
        (index) => {
      'sport': 'Padel',
      'duration': '90min',
      'type': 'Friendly Match',
      'location': 'Kemmer Trafficway, West Zenatown',
      'date': 'Nov 10, 2024 | 08:00 A.M.',
    },
  ).obs;


  void UploadScoreApi() async {

    try {

       loading.value=true;
        Map<String, dynamic> requestModel =
        BookingRequestModel.uploadScoreRequestModel(bookingId: bookingId.value,

            set1: {
              "team1":SetP1.text.isNotEmpty? int.parse(SetP1.text):0,
              "team2": SetP2.text.isNotEmpty?int.parse(SetP2.text):0 ,
            },

            set2: {
              "team1": SetP3.text.isNotEmpty?int.parse(SetP3.text):0 ,
              "team2":  SetP4.text.isNotEmpty?int.parse(SetP4.text):0
            },
            set3: {
              "team1":  SetP5.text.isNotEmpty?int.parse(SetP5.text):0,
              "team2": SetP6.text.isNotEmpty?int.parse(SetP6.text):0,
            }


            );


        final response = await _apiRepository.uploadScore(
            dataBody: requestModel);

        if (response != null) {
          loading.value = false;
          scoresRates.value = response;
          Get.back();

      }
      // else if(showset2.value==true) {
      //   Map<String, dynamic> requestModel =
      //   BookingRequestModel.uploadScoreRequestModel(bookingId: bookingId.value,
      //
      //       set2: {
      //         "team1": int.parse(SetP3.text) ,
      //         "team2":  int.parse(SetP4.text)
      //       });
      //
      //   final response = await _apiRepository.uploadScore(
      //       dataBody: requestModel);
      //
      //   if (response != null) {
      //     showset1.value = false;
      //     showset1.refresh();
      //
      //
      //     showset2.value=false;
      //     showset2.refresh();
      //     showset3.value=false;
      //     showset3.refresh();
      //     loading.value = false;
      //     scoresRates.value = response;
      //   }
      // }else  if(showset3.value==true) {
      //   Map<String, dynamic> requestModel =
      //   BookingRequestModel.uploadScoreRequestModel(bookingId: bookingId.value,
      //       set3: {
      //         "team1":  int.parse(SetP5.text),
      //         "team2": int.parse(SetP6.text),
      //       });
      //
      //   final response = await _apiRepository.uploadScore(
      //       dataBody: requestModel);
      //
      //   if (response != null) {
      //     showset1.value = false;
      //     showset1.refresh();
      //
      //
      //     showset2.value=false;
      //     showset2.refresh();
      //     showset3.value=false;
      //     showset3.refresh();
      //     loading.value = false;
      //     scoresRates.value = response;
      //   }
      // }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }finally{
      loading.value=false;
    }
  }


}