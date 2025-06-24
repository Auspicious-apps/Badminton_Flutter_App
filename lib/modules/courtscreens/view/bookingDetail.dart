import 'package:badminton/app_settings/components/label.dart';
import 'package:badminton/app_settings/components/widget_global_margin.dart';
import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/constants/app_dim.dart';

import 'package:cart_button/cart_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:super_tooltip/super_tooltip.dart';

import '../../../repository/endpoint.dart';
import '../../creategames/model/AllBookingsResponseModel.dart';
import '../controller/booking_detail_controller.dart';
import '../controller/confirm_payment_controller.dart';
import '../models/booking_request_model.dart';

class BookingDetailPage extends GetView<BookingDetailController> {
  BookingDetailPage({super.key});

// Get screen width for responsive sizing
  final double screenWidth = MediaQuery.of(Get.context!).size.width;
  final double playerSlotSize =
      Get.width * 0.1; // 10% of screen width for each slot
  final double spacing = Get.width * 0.02; // 2% of screen width for spacing
  bool isMatchTimePassed(String bookingDate, String timeSlot) {
    try {
      // Parse bookingDate (ISO 8601 format, UTC)
      final matchDateTimeUtc = DateTime.parse(bookingDate);
      final matchDateTime = matchDateTimeUtc.toLocal(); // Convert to local time

      // Get current local date and time
      final now = DateTime.now();

      // Check if bookingDate is in the past
      if (now.isAfter(matchDateTime)) {
        return true; // bookingDate has passed
      }

      // Check if bookingDate is today
      final isSameDay = now.year == matchDateTime.year &&
          now.month == matchDateTime.month &&
          now.day == matchDateTime.day;

      if (!isSameDay) {
        return false; // bookingDate is in the future
      }

      // Parse timeSlot (e.g., "14:00")
      final timeParts = timeSlot.split(':');
      if (timeParts.length != 2) {
        print('Invalid time format: $timeSlot');
        return false;
      }

      // Parse hour and minute
      final matchHour = int.parse(timeParts[0]);
      final matchMinute = int.parse(timeParts[1]);

      // Create DateTime for timeSlot on bookingDate
      final timeSlotDateTime = DateTime(
        matchDateTime.year,
        matchDateTime.month,
        matchDateTime.day,
        matchHour,
        matchMinute,
      );

      // Compare: return true if current time is after timeSlot
      return now.isAfter(timeSlotDateTime);
    } catch (e) {
      print('Error parsing date/time: $e');
      return false; // Default to false if parsing fails
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            Obx(() => controller.isLoading.value
                ? _buildSkeletonUI()
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: WidgetGlobalMargin(
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                padVertical(20),
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
                                          borderRadius:
                                              BorderRadius.circular(5),
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
                                    padHorizontal(10),
                                    const Label(
                                      txt: "Booking",
                                      type: TextTypes.f_18_600,
                                    ),
                                  ],
                                ),
                                padVertical(15),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: AppColors.lightGrey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Label(
                                        txt: "Booking Summary",
                                        // txt:" ${controller.bookingResponseModel.value.data?.}",
                                        type: TextTypes.f_14_700,
                                      ),
                                      padVertical(5),
                                      const Divider(),
                                      padVertical(5),
                                      controller.bookingResponseModel.value.data
                                                      ?.venueId?.image !=
                                                  null &&
                                              controller
                                                      .bookingResponseModel
                                                      .value
                                                      .data
                                                      ?.venueId
                                                      ?.image
                                                      ?.isNotEmpty ==
                                                  true
                                          ? Container(
                                              width: Get.width,
                                              height: Get.height * 0.2,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                      "${imageBaseUrl}${controller.bookingResponseModel.value.data?.venueId?.image}"),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              child: Image.asset(
                                                AppAssets.ban1,
                                                width: double.infinity,
                                                height: 112,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                      padVertical(10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Label(
                                                txt:
                                                    "${controller.bookingResponseModel.value.data?.courtId?.games ?? ""} Game",
                                                type: TextTypes.f_18_600,
                                              ),
                                              SizedBox(
                                                width: Get.width * 0.7,
                                                child: Label(
                                                  maxLines: 2,
                                                  txt:
                                                      "${controller.bookingResponseModel.value.data?.venueId?.address}",
                                                  type: TextTypes.f_12_500,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Image.asset(
                                            AppAssets.watch,
                                            width: 27,
                                            height: 27,
                                            fit: BoxFit.contain,
                                          ),
                                        ],
                                      ),
                                      padVertical(6),

                                      Row(
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.calendar_today_outlined,
                                                color: AppColors.grey,
                                                size: 15,
                                              ),
                                              padHorizontal(5),
                                              Label(
                                                txt: DateFormat('yyyy-MM-dd')
                                                    .format(DateTime.parse(
                                                        controller
                                                                .bookingResponseModel
                                                                .value
                                                                .data
                                                                ?.bookingDate ??
                                                            "")),
                                                type: TextTypes.f_12_500,
                                                forceColor: AppColors.grey,
                                              ),
                                            ],
                                          ),
                                          padHorizontal(20),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.watch_later_outlined,
                                                color: AppColors.grey,
                                                size: 15,
                                              ),
                                              padHorizontal(5),
                                              Label(
                                                txt: controller
                                                            .bookingResponseModel
                                                            .value
                                                            .data
                                                            ?.bookingSlots !=
                                                        null
                                                    ? () {
                                                        try {
                                                          final dateTime = DateFormat(
                                                                  'HH:mm')
                                                              .parse(controller
                                                                      .bookingResponseModel
                                                                      .value
                                                                      .data
                                                                      ?.bookingSlots ??
                                                                  "");
                                                          return DateFormat(
                                                                  'h:mm a')
                                                              .format(dateTime);
                                                        } catch (e) {
                                                          return controller
                                                              .bookingSlots
                                                              .first; // Fallback to original string
                                                        }
                                                      }()
                                                    : 'No slots selected',
                                                type: TextTypes.f_12_500,
                                                forceColor: AppColors.grey,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      padVertical(10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Label(
                                            txt: "Expected Amount",
                                            type: TextTypes.f_14_500,
                                            forceColor: AppColors.grey,
                                          ),
                                          Label(
                                            txt:
                                                "₹ ${controller.bookingResponseModel.value.data?.expectedPayment}",
                                            type: TextTypes.f_14_700,
                                            forceColor: AppColors.blackColor,
                                          ),
                                        ],
                                      ),
                                      padVertical(10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Label(
                                            txt: "Booking Amount",
                                            type: TextTypes.f_14_500,
                                            forceColor: AppColors.grey,
                                          ),
                                          Label(
                                            txt:
                                                "₹ ${controller.bookingResponseModel.value.data?.bookingAmount}",
                                            type: TextTypes.f_14_700,
                                            forceColor: AppColors.blackColor,
                                          ),
                                        ],
                                      ),
                                      // Removed commented-out date and time slot code
                                    ],
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: AppColors.lightGrey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Label(
                                            txt: "Game Type",
                                            type: TextTypes.f_14_700,
                                            forceColor: Colors.grey,
                                          ),
                                          Label(
                                            txt:
                                                "${controller.bookingResponseModel.value.data?.askToJoin == true ? "Open Match" : "Private"}",
                                            type: TextTypes.f_14_700,
                                          ),
                                        ],
                                      ),
                                      padVertical(10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Label(
                                            txt: "Court Booked",
                                            type: TextTypes.f_14_700,
                                            forceColor: Colors.grey,
                                          ),
                                          Label(
                                            txt: "Yes",
                                            type: TextTypes.f_14_700,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: AppColors.lightGrey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Label(
                                        txt: "Equipment Rented",
                                        type: TextTypes.f_16_600,
                                        forceColor: Colors.black,
                                      ),
                                      padVertical(10),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Label(
                                            txt: "Rackets",
                                            type: TextTypes.f_14_700,
                                            forceColor: Colors.grey,
                                          ),
                                          Label(
                                            txt:
                                                "${controller.bookingResponseModel.value.data?.rackets ?? "0"}",
                                            type: TextTypes.f_14_700,
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Label(
                                            txt: "balls",
                                            type: TextTypes.f_14_700,
                                            forceColor: Colors.grey,
                                          ),
                                          Label(
                                            txt:
                                                "${controller.bookingResponseModel.value.data?.balls ?? "0"}",
                                            type: TextTypes.f_14_700,
                                          ),
                                        ],
                                      ).marginSymmetric(vertical: 10),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: AppColors.lightGrey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Label(
                                            txt: "Match Type",
                                            type: TextTypes.f_14_700,
                                            forceColor: Colors.grey,
                                          ),
                                          Label(
                                            txt:
                                                "${controller.bookingResponseModel.value.data?.isCompetitive == true ? "Competitive" : "Friendly"}",
                                            type: TextTypes.f_14_700,
                                          ),
                                        ],
                                      ),
                                      Label(
                                        txt:
                                            "* The result of this match will contribute towards your level.*",
                                        maxLines: 2,
                                        forceAlignment: TextAlign.center,
                                        type: TextTypes.f_12_500,
                                        forceColor: Colors.grey,
                                      ).marginSymmetric(vertical: 10),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 8),
                                  padding: const EdgeInsets.all(15),
                                  decoration: BoxDecoration(
                                    color: AppColors.lightGrey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Label(
                                        txt: "Players",
                                        type: TextTypes.f_16_600,
                                        forceColor: Colors.black,
                                      ),
                                      padVertical(20),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          // Left side: Two player slots
                                          SizedBox(
                                            height: 70,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis
                                                  .horizontal, // Horizontal scrolling
                                              itemCount: controller
                                                      .bookingResponseModel
                                                      .value
                                                      .data
                                                      ?.team1
                                                      ?.length ??
                                                  0, // Number of players in team1
                                              itemBuilder: (context, index) {
                                                final player = controller
                                                        .bookingResponseModel
                                                        .value
                                                        .data
                                                        ?.team1?[
                                                    index]; // Access player at index
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                      right:
                                                          spacing), // Spacing between items
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Stack(
                                                        clipBehavior: Clip.none,
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        children: [
                                                          // Circular image or placeholder
                                                          player?.playerData
                                                                      ?.profilePic ==
                                                                  null
                                                              ? Container(
                                                                  height: 50,
                                                                  width: 50,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50),
                                                                      color: AppColors
                                                                          .lightGrey,
                                                                      border: Border.all(
                                                                          color:
                                                                              AppColors.primaryColor)),
                                                                  child: Icon(
                                                                    Icons
                                                                        .person, // Placeholder icon
                                                                    size: 40.sp,
                                                                    color:
                                                                        AppColors
                                                                            .grey,
                                                                  ),
                                                                )
                                                              : ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50),
                                                                  child: Image
                                                                      .network(
                                                                    "${imageBaseUrl}${player?.playerData?.profilePic}",
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    errorBuilder:
                                                                        (context,
                                                                            error,
                                                                            stackTrace) {
                                                                      return Container(
                                                                        height:
                                                                            50,
                                                                        width:
                                                                            50,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(50),
                                                                            color: AppColors.lightGrey,
                                                                            border: Border.all(color: AppColors.primaryColor)),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .person, // Error image/icon
                                                                          size:
                                                                              30.sp,
                                                                          color:
                                                                              AppColors.grey,
                                                                        ),
                                                                      );
                                                                    },
                                                                    height: 50,
                                                                    width: 50,
                                                                  ),
                                                                ),
                                                          // Blue container overlay at the bottom
                                                          Positioned(
                                                            bottom: -4,
                                                            right:
                                                                7, // Slightly offset to overlap the image
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4),
                                                                color: AppColors
                                                                    .primaryColor,
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              height: 12,
                                                              width: 35,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                              height: 10,
                                                              child: Center(
                                                                  child: Label(
                                                                txt:
                                                                    "${controller.bookingResponseModel.value.data?.team1?[index].playerData?.fullName}",
                                                                type: TextTypes
                                                                    .f_8_400,
                                                                forceColor:
                                                                    Colors
                                                                        .black,
                                                              )))
                                                          .marginSymmetric(
                                                              vertical: 3)
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          // Center line
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: spacing),
                                            child: Container(
                                              width: 2,
                                              height: playerSlotSize *
                                                  1.2, // Dynamic height
                                              color: AppColors.whiteColor,
                                            ),
                                          ),
                                          // Right side: Two player slots
                                          SizedBox(
                                            height: 70,
                                            child: ListView.builder(
                                              shrinkWrap: true,
                                              scrollDirection: Axis
                                                  .horizontal, // Horizontal scrolling
                                              itemCount: controller
                                                      .bookingResponseModel
                                                      .value
                                                      .data
                                                      ?.team2
                                                      ?.length ??
                                                  0, // Number of players in team1
                                              itemBuilder: (context, index) {
                                                final player = controller
                                                        .bookingResponseModel
                                                        .value
                                                        .data
                                                        ?.team2?[
                                                    index]; // Access player at index
                                                return Padding(
                                                  padding: EdgeInsets.only(
                                                      right:
                                                          spacing), // Spacing between items
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Stack(
                                                        clipBehavior: Clip.none,
                                                        alignment: Alignment
                                                            .bottomCenter,
                                                        children: [
                                                          // Circular image or placeholder
                                                          player?.playerData
                                                                      ?.profilePic ==
                                                                  null
                                                              ? Container(
                                                                  height: 50,
                                                                  width: 50,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              50),
                                                                      color: AppColors
                                                                          .lightGrey,
                                                                      border: Border.all(
                                                                          color:
                                                                              AppColors.primaryColor)),
                                                                  child: Icon(
                                                                    Icons
                                                                        .person, // Placeholder icon
                                                                    size: 40.sp,
                                                                    color:
                                                                        AppColors
                                                                            .grey,
                                                                  ),
                                                                )
                                                              : ClipRRect(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              50),
                                                                  child: Image
                                                                      .network(
                                                                    "${imageBaseUrl}${player?.playerData?.profilePic}",
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    errorBuilder:
                                                                        (context,
                                                                            error,
                                                                            stackTrace) {
                                                                      return Container(
                                                                        height:
                                                                            50,
                                                                        width:
                                                                            50,
                                                                        decoration: BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(50),
                                                                            color: AppColors.lightGrey,
                                                                            border: Border.all(color: AppColors.primaryColor)),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .person, // Error image/icon
                                                                          size:
                                                                              30.sp,
                                                                          color:
                                                                              AppColors.grey,
                                                                        ),
                                                                      );
                                                                    },
                                                                    height: 50,
                                                                    width: 50,
                                                                  ),
                                                                ),
                                                          // Blue container overlay at the bottom
                                                          Positioned(
                                                            bottom: -4,
                                                            right:
                                                                7, // Slightly offset to overlap the image
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            4),
                                                                color: AppColors
                                                                    .primaryColor,
                                                                border: Border.all(
                                                                    color: Colors
                                                                        .white),
                                                              ),
                                                              height: 12,
                                                              width: 35,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                              height: 10,
                                                              child: Center(
                                                                  child: Label(
                                                                txt:
                                                                    "${controller.bookingResponseModel.value.data?.team2?[index].playerData?.fullName}",
                                                                type: TextTypes
                                                                    .f_8_400,
                                                                forceColor:
                                                                    Colors
                                                                        .black,
                                                              )))
                                                          .marginSymmetric(
                                                              vertical: 3)
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ],
                                      ).marginSymmetric(
                                          horizontal: spacing * 2),
                                      Obx(
                                        () => controller.bookingResponseModel
                                                    .value.data?.score?.set1 !=
                                                null
                                            ? Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Label(
                                                        txt: "Team 1",
                                                        type:
                                                            TextTypes.f_14_600,
                                                        forceColor:
                                                            AppColors.smalltxt,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            width: 30,
                                                            child: Center(
                                                              child: Label(
                                                                txt:
                                                                    "${controller.bookingResponseModel.value.data?.score?.set1?.team1 ?? "0"}",
                                                                type: TextTypes
                                                                    .f_14_600,
                                                                forceColor:
                                                                    AppColors
                                                                        .smalltxt,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 30,
                                                            child: Center(
                                                              child: Label(
                                                                txt:
                                                                    "${controller.bookingResponseModel.value.data?.score?.set2?.team1 ?? "0"}",
                                                                type: TextTypes
                                                                    .f_14_600,
                                                                forceColor:
                                                                    AppColors
                                                                        .smalltxt,
                                                              ),
                                                            ),
                                                          ).marginSymmetric(
                                                              horizontal: 10),
                                                          SizedBox(
                                                            width: 30,
                                                            child: Center(
                                                              child: Label(
                                                                txt:
                                                                    "${controller.bookingResponseModel.value.data?.score?.set3?.team1 ?? "0"}",
                                                                type: TextTypes
                                                                    .f_14_600,
                                                                forceColor:
                                                                    AppColors
                                                                        .smalltxt,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ).marginOnly(left: 100),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      SizedBox(
                                                          width: 70,
                                                          child: Divider()),
                                                      Label(
                                                        txt: "Points",
                                                        type:
                                                            TextTypes.f_14_500,
                                                        forceColor:
                                                            AppColors.smalltxt,
                                                      ).marginSymmetric(
                                                          horizontal: 10)
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Label(
                                                        txt: "Team 2",
                                                        type:
                                                            TextTypes.f_14_600,
                                                        forceColor:
                                                            AppColors.smalltxt,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            width: 30,
                                                            child: Center(
                                                              child: Label(
                                                                txt:
                                                                    "${controller.bookingResponseModel.value.data?.score?.set1?.team2 ?? "0"}",
                                                                type: TextTypes
                                                                    .f_14_600,
                                                                forceColor:
                                                                    AppColors
                                                                        .smalltxt,
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 30,
                                                            child: Center(
                                                              child: Label(
                                                                txt:
                                                                    "${controller.bookingResponseModel.value.data?.score?.set2?.team2 ?? "0"}",
                                                                type: TextTypes
                                                                    .f_14_600,
                                                                forceColor:
                                                                    AppColors
                                                                        .smalltxt,
                                                              ),
                                                            ),
                                                          ).marginSymmetric(
                                                              horizontal: 10),
                                                          SizedBox(
                                                            width: 30,
                                                            child: Center(
                                                              child: Label(
                                                                txt:
                                                                    "${controller.bookingResponseModel.value.data?.score?.set3?.team2 ?? "0"}",
                                                                type: TextTypes
                                                                    .f_14_600,
                                                                forceColor:
                                                                    AppColors
                                                                        .smalltxt,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ).marginOnly(left: 100),
                                                    ],
                                                  ),
                                                ],
                                              ).marginSymmetric(
                                                horizontal: 10, vertical: 20)
                                            : SizedBox(),
                                      ),
                                    ],
                                  ),
                                ),
                            Obx  (()=>


                            // controller.bookingResponseModel.value.data
                            //     ?.bookingType ==
                            //     "Cancelled" ||
                            //     controller.bookingResponseModel
                            //         .value.data?.askToJoin ==
                            //         true ? controller.bookingResponseModel.value.data
                            //         ?.bookingType ==
                            //         "Cancelled" ||
                            //     controller.bookingResponseModel
                            //         .value.data?.askToJoin ==
                            //         true
                            //     ? SizedBox() :

                          controller.isCancel.value==false?  GestureDetector(
                                        onTap: () async {
                                          final score = controller
                                                  ?.bookingResponseModel
                                                  .value
                                                  .data
                                                  ?.score ??
                                              Score(
                                                set1: Set1(
                                                    team1: controller
                                                        ?.bookingResponseModel
                                                        .value
                                                        .data
                                                        ?.score
                                                        ?.set1
                                                        ?.team1,
                                                    team2: controller
                                                        ?.bookingResponseModel
                                                        .value
                                                        .data
                                                        ?.score
                                                        ?.set1
                                                        ?.team2),
                                                set2: Set1(
                                                    team1: controller
                                                        ?.bookingResponseModel
                                                        .value
                                                        .data
                                                        ?.score
                                                        ?.set2
                                                        ?.team1,
                                                    team2: controller
                                                        ?.bookingResponseModel
                                                        .value
                                                        .data
                                                        ?.score
                                                        ?.set2
                                                        ?.team2),
                                                set3: Set1(
                                                    team1: controller
                                                        ?.bookingResponseModel
                                                        .value
                                                        .data
                                                        ?.score
                                                        ?.set3
                                                        ?.team1,
                                                    team2: controller
                                                        ?.bookingResponseModel
                                                        .value
                                                        .data
                                                        ?.score
                                                        ?.set3
                                                        ?.team2),
                                                bookingId: controller
                                                    ?.bookingResponseModel
                                                    .value
                                                    .data
                                                    ?.sId, // Optional: Set bookingId if needed
                                              );
                                          await Get.toNamed("uploadScore",
                                              arguments: {
                                                "game": controller
                                                        ?.bookingResponseModel
                                                        .value
                                                        .data
                                                        ?.courtId
                                                        ?.games ??
                                                    "",
                                                "address": controller
                                                        ?.bookingResponseModel
                                                        .value
                                                        .data
                                                        ?.venueId
                                                        ?.address ??
                                                    "",
                                                "time": controller
                                                    ?.bookingResponseModel
                                                    .value
                                                    .data
                                                    ?.bookingSlots,
                                                "date": controller
                                                    ?.bookingResponseModel
                                                    .value
                                                    .data
                                                    ?.bookingDate,
                                                "id": controller
                                                    ?.bookingResponseModel
                                                    .value
                                                    .data
                                                    ?.sId,
                                                "score": score
                                              });

                                          controller.fetchBookingDetailApi(
                                              controller?.bookingResponseModel
                                                  .value.data?.sId);
                                        },
                                        child: Container(
                                          width: Get.width,
                                          height: 49,
                                          padding: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            color: AppColors.blue2,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Center(
                                            child: const Label(
                                              txt: "Upload Scores",
                                              type: TextTypes.f_14_600,
                                              forceColor: AppColors.whiteColor,
                                            ),
                                          ),
                                        ),
                                      ).marginSymmetric(vertical: 10) : controller.bookingResponseModel.value.data
            ?.bookingType ==
            "Cancelled" ||
        controller.bookingResponseModel
            .value.data?.askToJoin ==
            true
        ? SizedBox() : GestureDetector(
                                            onTap: () async {
                                              // Show confirmation dialog
                                              Get.defaultDialog(
                                                title: "Confirm Cancellation",
                                                titleStyle: TextStyle(
                                                  fontSize: 18.sp,
                                                  fontWeight: FontWeight.w600,
                                                  color: AppColors.primaryColor,
                                                ),
                                                middleText:
                                                    "Are you sure you want to cancel this booking?",
                                                middleTextStyle:
                                                    TextStyle(fontSize: 16.sp),
                                                textConfirm: "Yes, Cancel",
                                                textCancel: "No",
                                                confirmTextColor:
                                                    AppColors.whiteColor,
                                                cancelTextColor:
                                                    AppColors.primaryColor,
                                                buttonColor:
                                                    AppColors.primaryColor,
                                                backgroundColor:
                                                    AppColors.background,
                                                radius: 10,
                                                onConfirm: () async {
                                                  Get.closeAllSnackbars();
                                                  controller.CancleBooking(
                                                      controller
                                                              .bookingResponseModel
                                                              .value
                                                              .data
                                                              ?.sId ??
                                                          "");
                                                },
                                                onCancel: () {
                                                  // // Close the dialog without action
                                                  // Get.back();
                                                },
                                              );
                                            },
                                            child: Container(
                                              padding: const EdgeInsets.all(10),
                                              height: 49,
                                              width: Get.width,
                                              decoration: BoxDecoration(
                                                color: AppColors.whiteColor,
                                                border: Border.all(
                                                    color: AppColors.orange),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Center(
                                                child: Label(
                                                  txt: "Cancel",
                                                  type: TextTypes.f_14_600,
                                                  forceColor: AppColors.orange,
                                                ),
                                              ),
                                            ),
                                          ).marginSymmetric(vertical: 10)),
                                controller.bookingResponseModel.value.data
                                    ?.bookingType ==
                                    "Cancelled"? Label(
                                  txt:
                                  "Booking Status Canceled",
                                  type: TextTypes
                                      .f_14_600,
                                  forceColor:
                                  AppColors
                                      .red,
                                ):SizedBox()
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  )),
          ],
        ),
      ),
    );
  }

  Widget _buildSkeletonUI() {
    return WidgetGlobalMargin(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            padVertical(20),
            Row(
              children: [
                SkeletonAvatar(
                  style: SkeletonAvatarStyle(
                    width: 38.w,
                    height: 29.h,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                padHorizontal(10),
                SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 18.h,
                    width: 100.w,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ],
            ),
            padVertical(15),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8.h),
              padding: EdgeInsets.all(15.w),
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  padVertical(5),
                  SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                      width: double.infinity,
                      height: 112.h,
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  padVertical(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 18.h,
                              width: 100.w,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          padVertical(5),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 12.h,
                              width: Get.width * 0.7,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      ),
                      SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                          width: 27.w,
                          height: 27.h,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  padVertical(6),
                  Row(
                    children: [
                      Row(
                        children: [
                          SkeletonAvatar(
                            style: SkeletonAvatarStyle(
                              width: 15.w,
                              height: 15.h,
                              shape: BoxShape.circle,
                            ),
                          ),
                          padHorizontal(5),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 12.h,
                              width: 80.w,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      ),
                      padHorizontal(20),
                      Row(
                        children: [
                          SkeletonAvatar(
                            style: SkeletonAvatarStyle(
                              width: 15.w,
                              height: 15.h,
                              shape: BoxShape.circle,
                            ),
                          ),
                          padHorizontal(5),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              height: 12.h,
                              width: 80.w,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  padVertical(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 14.h,
                          width: 120.w,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      SkeletonLine(
                        style: SkeletonLineStyle(
                          height: 18.h,
                          width: 60.w,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
