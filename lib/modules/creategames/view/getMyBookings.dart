import 'package:badminton/app_settings/components/label.dart';
import 'package:badminton/app_settings/components/widget_global_margin.dart';
import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/constants/app_dim.dart';
import 'package:badminton/modules/creategames/controller/get_all_bookings_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../repository/endpoint.dart';
import '../controller/Get_my_bookings_cotroller.dart';
import '../model/AllBookingsResponseModel.dart';

class Getmybookings extends GetView<GetMyBookingsController> {
  const Getmybookings({super.key});

  @override
  Widget build(BuildContext context) {
    // Get screen width for responsive sizing
    final double screenWidth = MediaQuery.of(context).size.width;
    final double playerSlotSize = screenWidth * 0.1; // 10% of screen width for each slot
    final double spacing = screenWidth * 0.02;

    bool isMatchTimePassed(String bookingDate) {
      try {
        final slot = bookingDate as String;
        final timeParts = slot.split(':');
        final matchDateTimeUtc = DateTime.parse(timeParts[0]);
        final matchDateTime = matchDateTimeUtc.toLocal(); // Convert to local time (IST)

        // Get current local date
        final now = DateTime.now();

        // Create DateTime objects to compare only date, month, and year
        final matchDate = DateTime(matchDateTime.year, matchDateTime.month, matchDateTime.day).toLocal();
        final currentDate = DateTime(now.year, now.month, now.day).toLocal();
        print("${matchDate.day},${matchDate.month}>>>>>>>>>>>>Dates");

        print(currentDate.isAtSameMomentAs(matchDate));
         if(currentDate.isAfter(matchDate)){
          return true;
        }else{
         return false;
        }
        // return currentDate.isAtSameMomentAs(matchDate);
      } catch (e) {
        print('Error parsing date: $e');
        return false; // Default to false if parsing fails
      }
    }

    bool isExactMatchTime(dynamic match) {
      try {
        // Ensure match is a Map and has required fields


        // Parse booking slot (e.g., "14:00")
        final slot = match as String;
        final timeParts = slot.split(':');
        if (timeParts.length < 2) {
          print('Invalid time format: $slot');
          return false; // Invalid time format
        }

        // Extract hour and minute from booking slot
        final matchHour = int.parse(timeParts[0]);
        final matchMinute = int.parse(timeParts[1]);

        // Get current time
        final now = DateTime.now().toLocal();

        // Extract current hour and minute
        final currentHour = now.hour;
        final currentMinute = now.minute;



        // Compare times: return true if current time is after match time
        if (currentHour.isLowerThan(matchHour)) {
          return true;
        }else{
          return false;
        }

      } catch (e) {
        print('Error parsing time: $e');
        return false; // Default to false if parsing fails
      }
    }



    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Obx(() => Skeleton(
          isLoading: controller.loading.value,
          skeleton: _buildSkeletonUI(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () => Get.back(),
                      child: Container(
                        width: 38,
                        height: 29,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Image.asset(
                          AppAssets.backbtn,
                          fit: BoxFit.contain,
                          height: 9,
                          width: 12,
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                    SizedBox(width: spacing),
                    const Label(
                      txt: 'My Bookings',
                      type: TextTypes.f_18_600,
                    ),
                  ],
                ),
                Obx(() => controller.bookList.value.data?.length == 0
                    ? SizedBox(
                  height: Get.height * 0.7,
                  width: Get.width,
                  child: Center(
                    child: Label(
                      txt: "No Booking Found",
                      type: TextTypes.f_16_600,
                      forceColor: AppColors.smalltxt,
                    ),
                  ),
                )
                    : RefreshIndicator(
                  onRefresh: () async {
                    await controller.getBookingList();
                  },
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.bookList.value.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      final match = controller.bookList.value.data?[index];
                      return GestureDetector(
                        onTap: () {
                          print(">>>>>>>>>>>>hellooooo>>>>>>");
                          Get.toNamed("/booking_detail", arguments: {
                            "id": controller.bookList.value.data?[index].sId,"isCancel": !isMatchTimePassed(match?.bookingDate ?? "") &&
                              isExactMatchTime(match?.bookingSlots)?true:match?.status=="upcoming"?true:false
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.lightGrey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Label(
                                        txt: "•  ${match?.courtId?.games}",
                                        type: TextTypes.f_10_600,
                                        forceColor: AppColors.smalltxt,
                                      ).marginSymmetric(horizontal: spacing),
                                      Label(
                                        txt: "• 60 Mins",
                                        type: TextTypes.f_10_600,
                                        forceColor: AppColors.smalltxt,
                                      ),
                                    ],
                                  ),
                                  Label(
                                    txt: match?.isCompetitive == true
                                        ? "Competitive Match"
                                        : "Friendly Match" ?? "",
                                    type: TextTypes.f_10_600,
                                    forceColor: AppColors.smalltxt,
                                  ).marginSymmetric(horizontal: spacing * 2),
                                ],
                              ).marginSymmetric(vertical: 10),
                              SizedBox(height: spacing),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 75,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: match?.team1?.length ?? 0,
                                      itemBuilder: (context, index) {
                                        final player = match?.team1?[index];
                                        return Column(
                                            children: [
                                        Padding(
                                        padding: EdgeInsets.only(right: spacing),
                                        child: Stack(
                                        clipBehavior: Clip.none,
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                        player?.playerData?.profilePic == null
                                        ? GestureDetector(
                                        onTap: () {
                                        Get.toNamed('/userprofiledetail',
                                        arguments: {
                                        "id": player?.playerData?.sId ?? "",
                                        "isAdmin": controller.responseModel.value.data?.sId ==
                                        player?.playerData?.sId
                                        });
                                        },
                                        child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: AppColors.lightGrey,
                                        border: Border.all(color: AppColors.primaryColor),
                                        ),
                                        child: Icon(
                                        Icons.person,
                                        size: 40.sp,
                                        color: AppColors.grey,
                                        ),
                                        ),
                                        )
                                            : GestureDetector(
                                        onTap: () {
                                        Get.toNamed('/userprofiledetail',
                                        arguments: {
                                        "id": player?.playerData?.sId ?? "",
                                        "isAdmin": controller.responseModel.value.data?.sId ==
                                        player?.playerData?.sId
                                        });
                                        },
                                        child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.network(
                                        "${imageBaseUrl}${player?.playerData?.profilePic}",
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: AppColors.lightGrey,
                                        border: Border.all(color: AppColors.primaryColor),
                                        ),
                                        child: Icon(
                                        Icons.person,
                                        size: 30.sp,
                                        color: AppColors.grey,
                                        ),
                                        );
                                        },
                                        height: 50,
                                        width: 50,
                                        ),
                                        ),
                                        ),
                                        Positioned(
                                        bottom: -4,
                                        right: 7,
                                        child: Container(
                                        decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: AppColors.blue2,
                                        border: Border.all(color: Colors.white),
                                        ),
                                        height: 15,
                                        width: 35,
                                        child: Center(
                                        child: Label(
                                        txt: "2.9",
                                        type: TextTypes.f_8_400,
                                        forceColor: Colors.white,
                                        ),
                                        ),
                                        ),
                                        ),
                                        ],
                                        ),
                                        ),
                                        Label(
                                        txt: player?.playerData?.fullName ?? "",
                                        type: TextTypes.f_8_400,
                                        forceColor: Colors.black,
                                        ).marginOnly(top: 10)
                                        ],
                                        );
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: spacing),
                                    child: Container(
                                      width: 2,
                                      height: playerSlotSize * 1.2,
                                      color: AppColors.whiteColor,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 75,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: match?.team2?.length ?? 0,
                                      itemBuilder: (context, index) {
                                        final player = match?.team2?[index];
                                        return Column(
                                            children: [
                                        Padding(
                                        padding: EdgeInsets.only(right: spacing),
                                        child: Stack(
                                        clipBehavior: Clip.none,
                                        alignment: Alignment.bottomCenter,
                                        children: [
                                        player?.playerData?.profilePic == null
                                        ? GestureDetector(
                                        onTap: () {
                                        Get.toNamed('/userprofiledetail',
                                        arguments: {
                                        "id": player?.playerData?.sId ?? "",
                                        "isAdmin": controller.responseModel.value.data?.sId ==
                                        player?.playerData?.sId
                                        });
                                        },
                                        child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: AppColors.lightGrey,
                                        border: Border.all(color: AppColors.primaryColor),
                                        ),
                                        child: Icon(
                                        Icons.person,
                                        size: 40.sp,
                                        color: AppColors.grey,
                                        ),
                                        ),
                                        )
                                            : GestureDetector(
                                        onTap: () {
                                        Get.toNamed('/userprofiledetail',
                                        arguments: {
                                        "id": player?.playerData?.sId ?? "",
                                        "isAdmin": controller.responseModel.value.data?.sId ==
                                        player?.playerData?.sId
                                        });
                                        },
                                        child: ClipRRect(
                                        borderRadius: BorderRadius.circular(50),
                                        child: Image.network(
                                        "${imageBaseUrl}${player?.playerData?.profilePic}",
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: AppColors.lightGrey,
                                        border: Border.all(color: AppColors.primaryColor),
                                        ),
                                        child: Icon(
                                        Icons.person,
                                        size: 30.sp,
                                        color: AppColors.grey,
                                        ),
                                        );
                                        },
                                        height: 50,
                                        width: 50,
                                        ),
                                        ),
                                        ),
                                        Positioned(
                                        bottom: -4,
                                        right: 7,
                                        child: Container(
                                        decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: AppColors.blue2,
                                        border: Border.all(color: Colors.white),
                                        ),
                                        height: 15,
                                        width: 30,
                                        child: Center(
                                        child: Label(
                                        txt: "2.9",
                                        type: TextTypes.f_8_400,
                                        forceColor: Colors.white,
                                        ),
                                        ),
                                        ),
                                        ),
                                        ],
                                        ),
                                        ),
                                        Label(
                                        txt: player?.playerData?.fullName ?? "",
                                        type: TextTypes.f_8_400,
                                        forceColor: Colors.black,
                                        ).marginOnly(top: 10)
                                        ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ).marginSymmetric(horizontal: spacing * 2),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: spacing / 2),
                                      Row(
                                        children: [
                                          Image.asset(
                                            AppAssets.location,
                                            fit: BoxFit.contain,
                                            width: 15,
                                            height: 15,
                                          ),
                                          SizedBox(width: spacing / 2),
                                          Label(
                                            txt: match?.venueId?.address ?? "",
                                            type: TextTypes.f_10_400,
                                            forceColor: AppColors.smalltxt,
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: spacing),
                                      Row(
                                        children: [
                                          Image.asset(
                                            AppAssets.calender2,
                                            fit: BoxFit.contain,
                                            width: 15,
                                            height: 15,
                                            color: AppColors.primaryColor,
                                          ),
                                          SizedBox(width: spacing / 2),
                                          Row(
                                            children: [
                                              Label(
                                                txt: match?.bookingDate != null
                                                    ? DateFormat('EEE, MMM d, yyyy')
                                                    .format(DateTime.parse(match?.bookingDate ?? "").toLocal())
                                                    : "Unknown Date",
                                                type: TextTypes.f_10_400,
                                                forceColor: AppColors.smalltxt,
                                              ),
                                              Label(
                                                txt: match?.bookingSlots != null
                                                    ? (() {
                                                  try {
                                                    final timeFormat = DateFormat('HH:mm');
                                                    final parsedTime = timeFormat.parse(match?.bookingSlots ?? "");
                                                    final today = DateTime.now();
                                                    final dateTime = DateTime(
                                                      today.year,
                                                      today.month,
                                                      today.day,
                                                      parsedTime.hour,
                                                      parsedTime.minute,
                                                    );
                                                    return DateFormat('h:mm a').format(dateTime);
                                                  } catch (e) {
                                                    return "Unknown Time";
                                                  }
                                                })()
                                                    : "Unknown Time",
                                                type: TextTypes.f_10_400,
                                                forceColor: AppColors.smalltxt,
                                              ).marginSymmetric(horizontal: 5),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ).marginSymmetric(vertical: 10),
                                ],
                              ).marginSymmetric(horizontal: spacing * 2),
                              Obx(
                                    () => controller.bookList.value.data?[index].score?.set1 != null
                                    ? Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Label(
                                          txt: "Team 1",
                                          type: TextTypes.f_14_600,
                                          forceColor: AppColors.smalltxt,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 30,
                                              child: Center(
                                                child: Label(
                                                  txt:
                                                  "${controller.bookList.value.data?[index].score?.set1?.team1 ?? "0"}",
                                                  type: TextTypes.f_14_600,
                                                  forceColor: AppColors.smalltxt,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 30,
                                              child: Center(
                                                child: Label(
                                                  txt:
                                                  "${controller.bookList.value.data?[index].score?.set2?.team1 ?? "0"}",
                                                  type: TextTypes.f_14_600,
                                                  forceColor: AppColors.smalltxt,
                                                ),
                                              ),
                                            ).marginSymmetric(horizontal: 10),
                                            SizedBox(
                                              width: 30,
                                              child: Center(
                                                child: Label(
                                                  txt:
                                                  "${controller.bookList.value.data?[index].score?.set3?.team1 ?? "0"}",
                                                  type: TextTypes.f_14_600,
                                                  forceColor: AppColors.smalltxt,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ).marginOnly(left: 100),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(width: 70, child: Divider()),
                                        Label(
                                          txt: "Points",
                                          type: TextTypes.f_14_500,
                                          forceColor: AppColors.smalltxt,
                                        ).marginSymmetric(horizontal: 10)
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Label(
                                          txt: "Team 2",
                                          type: TextTypes.f_14_600,
                                          forceColor: AppColors.smalltxt,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 30,
                                              child: Center(
                                                child: Label(
                                                  txt:
                                                  "${controller.bookList.value.data?[index].score?.set1?.team2 ?? "0"}",
                                                  type: TextTypes.f_14_600,
                                                  forceColor: AppColors.smalltxt,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 30,
                                              child: Center(
                                                child: Label(
                                                  txt:
                                                  "${controller.bookList.value.data?[index].score?.set2?.team2 ?? "0"}",
                                                  type: TextTypes.f_14_600,
                                                  forceColor: AppColors.smalltxt,
                                                ),
                                              ),
                                            ).marginSymmetric(horizontal: 10),
                                            SizedBox(
                                              width: 30,
                                              child: Center(
                                                child: Label(
                                                  txt:
                                                  "${controller.bookList.value.data?[index].score?.set3?.team2 ?? "0"}",
                                                  type: TextTypes.f_14_600,
                                                  forceColor: AppColors.smalltxt,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ).marginOnly(left: 100),
                                      ],
                                    ),
                                  ],
                                ).marginSymmetric(horizontal: 10)
                                    : SizedBox(),
                              ),
                              // Align(
                              //   alignment: Alignment.bottomRight,
                              //   child: Container(
                              //     child: match?.status == "upcoming"
                              //         ? match?.askToJoin == true || match?.bookingType == "Cancelled"
                              //         ? SizedBox()
                              //         : GestureDetector(
                              //       onTap: () async {
                              //         Get.defaultDialog(
                              //           title: "Confirm Cancellation",
                              //           titleStyle: TextStyle(
                              //             fontSize: 18.sp,
                              //             fontWeight: FontWeight.w600,
                              //             color: AppColors.primaryColor,
                              //           ),
                              //           middleText: "Are you sure you want to cancel this booking?",
                              //           middleTextStyle: TextStyle(fontSize: 16.sp),
                              //           textConfirm: "Yes, Cancel",
                              //           textCancel: "No",
                              //           confirmTextColor: AppColors.whiteColor,
                              //           cancelTextColor: AppColors.primaryColor,
                              //           buttonColor: AppColors.primaryColor,
                              //           backgroundColor: AppColors.background,
                              //           radius: 10,
                              //           onConfirm: () async {
                              //             Get.closeAllSnackbars();
                              //             controller.CancleBooking(match?.sId ?? "");
                              //           },
                              //           onCancel: () {},
                              //         );
                              //       },
                              //       child: Container(
                              //         padding: const EdgeInsets.all(10),
                              //         decoration: BoxDecoration(
                              //           color: AppColors.whiteColor,
                              //           border: Border.all(color: AppColors.orange),
                              //           borderRadius: BorderRadius.circular(5),
                              //         ),
                              //         child: Label(
                              //           txt: "Cancel",
                              //           type: TextTypes.f_10_600,
                              //           forceColor: AppColors.orange,
                              //         ),
                              //       ),
                              //     )
                              //         : isMatchTimePassed(match?.bookingDate ?? "", match?.bookingSlots ?? "")
                              //         ? GestureDetector(
                              //       onTap: () async {
                              //         final score = match?.score ??
                              //             Score(
                              //               set1: Set1(
                              //                 team1: match?.score?.set1?.team1,
                              //                 team2: match?.score?.set1?.team2,
                              //               ),
                              //               set2: Set1(
                              //                 team1: match?.score?.set2?.team1,
                              //                 team2: match?.score?.set2?.team2,
                              //               ),
                              //               set3: Set1(
                              //                 team1: match?.score?.set3?.team1,
                              //                 team2: match?.score?.set3?.team2,
                              //               ),
                              //               bookingId: match?.sId,
                              //             );
                              //         await Get.toNamed("uploadScore", arguments: {
                              //           "game": match?.courtId?.games ?? "",
                              //           "address": match?.venueId?.address ?? "",
                              //           "time": match?.bookingSlots,
                              //           "date": match?.bookingDate,
                              //           "id": match?.sId,
                              //           "score": score
                              //         });
                              //         controller.getBookingList();
                              //       },
                              //       child: Container(
                              //         padding: const EdgeInsets.all(10),
                              //         decoration: BoxDecoration(
                              //           color: AppColors.blue2,
                              //           borderRadius: BorderRadius.circular(5),
                              //         ),
                              //         child: Label(
                              //           txt: "Upload",
                              //           type: TextTypes.f_10_600,
                              //           forceColor: AppColors.whiteColor,
                              //         ),
                              //       ),
                              //     )
                              //         : match?.bookingType == "Cancelled" || match?.askToJoin == true
                              //         ? SizedBox()
                              //         : GestureDetector(
                              //       onTap: () async {
                              //         Get.defaultDialog(
                              //           title: "Confirm Cancellation",
                              //           titleStyle: TextStyle(
                              //             fontSize: 18.sp,
                              //             fontWeight: FontWeight.w600,
                              //             color: AppColors.primaryColor,
                              //           ),
                              //           middleText: "Are you sure you want to cancel this booking?",
                              //           middleTextStyle: TextStyle(fontSize: 16.sp),
                              //           textConfirm: "Yes, Cancel",
                              //           textCancel: "No",
                              //           confirmTextColor: AppColors.whiteColor,
                              //           cancelTextColor: AppColors.primaryColor,
                              //           buttonColor: AppColors.primaryColor,
                              //           backgroundColor: AppColors.background,
                              //           radius: 10,
                              //           onConfirm: () async {
                              //             Get.closeAllSnackbars();
                              //             controller.CancleBooking(match?.sId ?? "");
                              //           },
                              //           onCancel: () {},
                              //         );
                              //       },
                              //       child: Container(
                              //         padding: const EdgeInsets.all(10),
                              //         decoration: BoxDecoration(
                              //           color: AppColors.whiteColor,
                              //           border: Border.all(color: AppColors.orange),
                              //           borderRadius: BorderRadius.circular(5),
                              //         ),
                              //         child: Label(
                              //           txt: "Cancel",
                              //           type: TextTypes.f_10_600,
                              //           forceColor: AppColors.orange,
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ).marginSymmetric(vertical: 10, horizontal: 20),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                  child:
                                     !isMatchTimePassed(match?.bookingDate ?? "") &&
                                    isExactMatchTime(match?.bookingSlots)
                                      ?  match?.askToJoin == true ||
                                         match?.bookingType == "Cancelled"?SizedBox()  :GestureDetector(
                                    onTap: () async {
                                      Get.defaultDialog(
                                        title: "Confirm Cancellation",
                                        titleStyle: TextStyle(
                                          fontSize: 18.sp,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryColor,
                                        ),
                                        middleText: "Are you sure you want to cancel this booking?",
                                        middleTextStyle: TextStyle(fontSize: 16.sp),
                                        textConfirm: "Yes, Cancel",
                                        textCancel: "No",
                                        confirmTextColor: AppColors.whiteColor,
                                        cancelTextColor: AppColors.primaryColor,
                                        buttonColor: AppColors.primaryColor,
                                        backgroundColor: AppColors.background,
                                        radius: 10,
                                        onConfirm: () async {
                                          Get.closeAllSnackbars();
                                          controller.CancleBooking(match?.sId ?? "");
                                        },
                                        onCancel: () {},
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: AppColors.whiteColor,
                                        border: Border.all(color: AppColors.orange),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Label(
                                        txt: "Cancel",
                                        type: TextTypes.f_10_600,
                                        forceColor: AppColors.orange,
                                      ),
                                    ),
                                  )
                                      :match?.status=="upcoming"? GestureDetector(
                                       onTap: () async {
                                         Get.defaultDialog(
                                           title: "Confirm Cancellation",
                                           titleStyle: TextStyle(
                                             fontSize: 18.sp,
                                             fontWeight: FontWeight.w600,
                                             color: AppColors.primaryColor,
                                           ),
                                           middleText: "Are you sure you want to cancel this booking?",
                                           middleTextStyle: TextStyle(fontSize: 16.sp),
                                           textConfirm: "Yes, Cancel",
                                           textCancel: "No",
                                           confirmTextColor: AppColors.whiteColor,
                                           cancelTextColor: AppColors.primaryColor,
                                           buttonColor: AppColors.primaryColor,
                                           backgroundColor: AppColors.background,
                                           radius: 10,
                                           onConfirm: () async {
                                             Get.closeAllSnackbars();
                                             controller.CancleBooking(match?.sId ?? "");
                                           },
                                           onCancel: () {},
                                         );
                                       },
                                       child: Container(
                                         padding: const EdgeInsets.all(10),
                                         decoration: BoxDecoration(
                                           color: AppColors.whiteColor,
                                           border: Border.all(color: AppColors.orange),
                                           borderRadius: BorderRadius.circular(5),
                                         ),
                                         child: Label(
                                           txt: "Cancel",
                                           type: TextTypes.f_10_600,
                                           forceColor: AppColors.orange,
                                         ),
                                       ),
                                     )  :   GestureDetector(
                                    onTap: () async {
                                      final score = match?.score ??
                                          Score(
                                            set1: Set1(
                                              team1: match?.score?.set1?.team1,
                                              team2: match?.score?.set1?.team2,
                                            ),
                                            set2: Set1(
                                              team1: match?.score?.set2?.team1,
                                              team2: match?.score?.set2?.team2,
                                            ),
                                            set3: Set1(
                                              team1: match?.score?.set3?.team1,
                                              team2: match?.score?.set3?.team2,
                                            ),
                                            bookingId: match?.sId,
                                          );
                                      await Get.toNamed("uploadScore", arguments: {
                                        "game": match?.courtId?.games ?? "",
                                        "address": match?.venueId?.address ?? "",
                                        "time": match?.bookingSlots,
                                        "date": match?.bookingDate,
                                        "id": match?.sId,
                                        "score": score
                                      });
                                      controller.getBookingList();
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: AppColors.blue2,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Label(
                                        txt: "Upload",
                                        type: TextTypes.f_10_600,
                                        forceColor: AppColors.whiteColor,
                                      ),
                                    ),
                                  )
                                  ,
                                ),
                              ).marginSymmetric(vertical: 10, horizontal: 20),
                            ],
                          ),
                        ),
                      );
                    },
                  ).marginSymmetric(vertical: 20),
                )),
              ],
            ).marginSymmetric(horizontal: spacing * 2),
          ),
        )),
      ),
    );
  }

  Widget _buildSkeletonUI() {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              padVertical(20),
              Row(
                children: [
                  SkeletonItem(
                    child: Container(
                      width: 38,
                      height: 29,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  padHorizontal(10),
                  SkeletonItem(
                    child: Container(
                      width: 100,
                      height: 18,
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
              padVertical(20),
              SkeletonItem(
                child: Container(
                  width: 200,
                  height: 20,
                  color: Colors.grey[300],
                ),
              ),
              padVertical(5),
              SkeletonItem(
                child: Container(
                  width: 150,
                  height: 12,
                  color: Colors.grey[300],
                ),
              ),
              padVertical(15),
              Row(
                children: [
                  SkeletonItem(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: 80,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                  padHorizontal(10),
                  SkeletonItem(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: 120,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                  ),
                ],
              ),
              padVertical(30),
              Row(
                children: [
                  SkeletonItem(
                    child: Container(
                      width: 100,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  padHorizontal(10),
                  SkeletonItem(
                    child: Container(
                      width: 100,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ],
              ),
              padVertical(20),
              SkeletonItem(
                child: Container(
                  width: 150,
                  height: 14,
                  color: Colors.grey[300],
                ),
              ),
              padVertical(5),
              SkeletonItem(
                child: Container(
                  width: double.infinity,
                  height: 60,
                  color: Colors.grey[300],
                ),
              ),
              padVertical(15),
              SkeletonItem(
                child: Container(
                  width: 150,
                  height: 14,
                  color: Colors.grey[300],
                ),
              ),
              padVertical(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SkeletonItem(
                    child: Container(
                      width: 80,
                      height: 12,
                      color: Colors.grey[300],
                    ),
                  ),
                  SkeletonItem(
                    child: Container(
                      width: 100,
                      height: 12,
                      color: Colors.grey[300],
                    ),
                  ),
                ],
              ),
              padVertical(30),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    3,
                        (index) => Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: SkeletonItem(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          width: 120,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              padVertical(50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SkeletonItem(
                    child: Container(
                      width: 150,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  padHorizontal(15),
                  SkeletonItem(
                    child: Container(
                      width: 150,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
              padVertical(20),
              SkeletonItem(
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              padVertical(20),
              SkeletonItem(
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              padVertical(20),
              SkeletonItem(
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              padVertical(20),
              SkeletonItem(
                child: Container(
                  width: double.infinity,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              padVertical(20),
              SkeletonItem(
                child: Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}