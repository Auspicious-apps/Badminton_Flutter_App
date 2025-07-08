import 'package:badminton/app_settings/components/label.dart';
import 'package:badminton/app_settings/components/widget_global_margin.dart';
import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/constants/app_dim.dart';
import 'package:badminton/app_settings/constants/common_button.dart';
import 'package:badminton/modules/courtscreens/models/booking_request_model.dart';
import 'package:badminton/repository/endpoint.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:linear_calender/linear_calender.dart';
import 'package:super_tooltip/super_tooltip.dart';

import '../controller/court_detail_controller.dart';
import 'customCalender.dart';

class PgCourtdetail extends GetView<PgCourtdetailController> {
  const PgCourtdetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Obx(
        () => Skeleton(
          isLoading: controller.loading.value,
          skeleton: _buildSkeletonUI(),
          child: SafeArea(
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: WidgetGlobalMargin(
                        child: RefreshIndicator(
                          onRefresh: () async {
                            await controller.getCourtDetail();
                          },
                          color: AppColors.primaryColor,
                          backgroundColor: AppColors.whiteColor,
                          child: SingleChildScrollView(
                            physics: const AlwaysScrollableScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                padVertical(20),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Get.back();
                                      },
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
                                      txt: 'Courts',
                                      type: TextTypes.f_18_600,
                                    ),
                                  ],
                                ),
                                padVertical(20),
                                Label(
                                  txt:
                                      "${controller.userdata.value.data?.name ?? ""}",
                                  type: TextTypes.f_20_600,
                                ),
                                Label(
                                  maxLines: 2,
                                  txt:
                                      '${controller.userdata.value.data?.address ?? ""},${controller.userdata.value.data?.city ?? ""},${controller.userdata.value.data?.state ?? ""}',
                                  type: TextTypes.f_12_500,
                                  forceColor: AppColors.grey,
                                ),
                                padVertical(15),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: AppColors.lightGrey,
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.location_on_outlined,
                                            size: 16,
                                            color: AppColors.primaryColor,
                                          ),
                                          Label(
                                            txt:
                                                '${controller.distance?.value ?? "0.0"}',
                                            type: TextTypes.f_10_600,
                                            forceColor: AppColors.primaryColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                    padHorizontal(10),
                                    Container(
                                      padding: const EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                        color: AppColors.lightGrey,
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      child: Row(
                                        children: [
                                          (controller.userdata.value.data
                                                          ?.weather?.icon ??
                                                      "")
                                                  .isEmpty
                                              ? Icon(
                                                  Icons.wb_sunny_outlined,
                                                  size: 25,
                                                )
                                              : Image.network(
                                                  "https:${controller.userdata.value.data?.weather?.icon ?? ""}",
                                                  height: 20,
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return Icon(
                                                      Icons.wb_sunny_outlined,
                                                      size: 25,
                                                    );
                                                  },
                                                ),
                                          padHorizontal(5),
                                          Label(
                                            txt:
                                                '${controller.userdata.value.data?.weather?.status ?? "sunny"}',
                                            type: TextTypes.f_10_600,
                                            forceColor: AppColors.primaryColor,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                padVertical(30),
                                Row(
                                  children: [
                                    Obx(
                                      () => GestureDetector(
                                        onTap: () =>
                                            controller.setSelectedButton(0),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 15,
                                            vertical: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            color: controller
                                                        .selectedButton.value ==
                                                    0
                                                ? AppColors.blue2
                                                : AppColors.background,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              width: controller.selectedButton
                                                          .value ==
                                                      0
                                                  ? 0
                                                  : 1,
                                              color: AppColors.smalltxt,
                                            ),
                                          ),
                                          child: Label(
                                            txt: 'Information',
                                            type: TextTypes.f_10_600,
                                            forceColor: controller
                                                        .selectedButton.value ==
                                                    0
                                                ? AppColors.whiteColor
                                                : AppColors.smalltxt,
                                          ),
                                        ),
                                      ),
                                    ),
                                    padHorizontal(10),
                                    Obx(
                                      () => GestureDetector(
                                        onTap: () =>
                                            controller.setSelectedButton(1),
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 15,
                                            vertical: 10,
                                          ),
                                          decoration: BoxDecoration(
                                            color: controller
                                                        .selectedButton.value ==
                                                    1
                                                ? AppColors.blue2
                                                : AppColors.background,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                              width: 1,
                                              color: AppColors.smalltxt,
                                            ),
                                          ),
                                          child: Label(
                                            txt: 'Book Court',
                                            type: TextTypes.f_10_600,
                                            forceColor: controller
                                                        .selectedButton.value ==
                                                    1
                                                ? AppColors.whiteColor
                                                : AppColors.smalltxt,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                padVertical(20),
                                controller.selectedButton.value == 1
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Label(
                                            txt: 'Select Game',
                                            type: TextTypes.f_14_700,
                                          ),
                                          Row(
                                            children: [
                                              Obx(
                                                () => Expanded(
                                                  child: GestureDetector(
                                                    onTap: () => {
                                                      controller.selectedgame
                                                          .value = 'Padel',
                                                      controller.selectedgame
                                                          .refresh(),
                                                      controller
                                                          .getCourtDetail()
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 15,
                                                        vertical: 10,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: controller
                                                                    .selectedgame
                                                                    .value ==
                                                                'Padel'
                                                            ? Color.fromRGBO(
                                                                16, 55, 92, 1)
                                                            : AppColors.grey
                                                                .withOpacity(
                                                                    0.15),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: Center(
                                                        child: Label(
                                                          txt: 'Padel',
                                                          type: TextTypes
                                                              .f_12_500,
                                                          forceColor: controller
                                                                      .selectedgame
                                                                      .value ==
                                                                  'Padel'
                                                              ? AppColors
                                                                  .whiteColor
                                                              : AppColors
                                                                  .smalltxt,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              padHorizontal(10),
                                              Obx(
                                                () => Expanded(
                                                  child: GestureDetector(
                                                    onTap: () => {
                                                      controller.selectedgame
                                                          .value = "Pickleball",
                                                      controller.selectedgame
                                                          .refresh(),
                                                      controller
                                                          .getCourtDetail()
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal: 15,
                                                        vertical: 10,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: controller
                                                                    .selectedgame
                                                                    .value ==
                                                                "Pickleball"
                                                            ? Color.fromRGBO(
                                                                16, 55, 92, 1)
                                                            : AppColors.grey
                                                                .withOpacity(
                                                                    0.15),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                      ),
                                                      child: Center(
                                                        child: Label(
                                                          txt: "Pickleball",
                                                          type: TextTypes
                                                              .f_12_500,
                                                          forceColor: controller
                                                                      .selectedgame
                                                                      .value ==
                                                                  "Pickleball"
                                                              ? AppColors
                                                                  .whiteColor
                                                              : AppColors
                                                                  .smalltxt,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ).marginSymmetric(vertical: 10),
                                        ],
                                      )
                                    : SizedBox(),
                                Obx(
                                  () => controller.selectedButton.value == 0
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Label(
                                              txt: 'Court Information',
                                              type: TextTypes.f_14_700,
                                            ),
                                            padVertical(5),
                                            Label(
                                              maxLines: 10,
                                              txt: controller.userdata.value
                                                      .data?.venueInfo ??
                                                  "",
                                              type: TextTypes.f_12_500,
                                              forceColor: AppColors.grey,
                                            ),
                                            padVertical(15),
                                            const Label(
                                              txt: 'Opening Hours',
                                              type: TextTypes.f_14_700,
                                            ),
                                            padVertical(5),
                                            Obx(
                                              () => (controller
                                                              .userdata
                                                              .value
                                                              .data
                                                              ?.openingHours ??
                                                          [])
                                                      .isEmpty
                                                  ? Container(
                                                      height: 50,
                                                      child: Center(
                                                          child: Label(
                                                              txt:
                                                                  "Slots Not Available",
                                                              type: TextTypes
                                                                  .f_12_400)))
                                                  : ListView.builder(
                                                      shrinkWrap: true,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemCount: controller
                                                              .userdata
                                                              .value
                                                              .data
                                                              ?.openingHours
                                                              ?.length ??
                                                          0,
                                                      itemBuilder:
                                                          (context, index) {
                                                        final openingHour =
                                                            controller
                                                                    .userdata
                                                                    .value
                                                                    .data
                                                                    ?.openingHours?[
                                                                index];
                                                        return Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Label(
                                                              txt: openingHour
                                                                      ?.day ??
                                                                  'Unknown',
                                                              type: TextTypes
                                                                  .f_12_700,
                                                              forceColor:
                                                                  AppColors
                                                                      .grey,
                                                            ),
                                                            Label(
                                                              txt: controller.formatTimeRange(
                                                                  openingHour
                                                                          ?.hours
                                                                      as List<
                                                                          String>?),
                                                              type: TextTypes
                                                                  .f_12_500,
                                                              forceColor:
                                                                  AppColors
                                                                      .grey,
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    ),
                                            ),
                                            padVertical(15),
                                            const Label(
                                              txt: 'Facilities',
                                              type: TextTypes.f_14_700,
                                            ),
                                            padVertical(15),
                                            Obx(
                                              () => SingleChildScrollView(
                                                scrollDirection:
                                                    Axis.horizontal,
                                                child: Row(
                                                  children: controller
                                                          .userdata
                                                          .value
                                                          .data
                                                          ?.facilities
                                                          ?.asMap()
                                                          .entries
                                                          .where((entry) =>
                                                              entry.value
                                                                  .isActive ==
                                                              true)
                                                          .map(
                                                            (entry) {
                                                              final facility =
                                                                  entry.value;
                                                              return [
                                                                Container(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          10),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: AppColors
                                                                        .lightGrey,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            18),
                                                                  ),
                                                                  child: Row(
                                                                    children: [
                                                                      Icon(
                                                                        controller.getFacilityIcon(facility.name ??
                                                                            ''),
                                                                        size:
                                                                            16,
                                                                        color: AppColors
                                                                            .grey,
                                                                      ),
                                                                      padHorizontal(
                                                                          5),
                                                                      Label(
                                                                        txt: facility.name ??
                                                                            'Unknown',
                                                                        type: TextTypes
                                                                            .f_10_600,
                                                                        forceColor:
                                                                            AppColors.grey,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                padHorizontal(
                                                                    10),
                                                              ];
                                                            },
                                                          )
                                                          .expand((element) =>
                                                              element)
                                                          .toList() ??
                                                      [],
                                                ),
                                              ),
                                            ),
                                            padVertical(20),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    controller.openMap(
                                                        controller
                                                            .userdata
                                                            .value
                                                            .data
                                                            ?.location
                                                            ?.coordinates?[1],
                                                        controller
                                                            .userdata
                                                            .value
                                                            .data
                                                            ?.location
                                                            ?.coordinates?[0]);
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      right: 30,
                                                      top: 8,
                                                      bottom: 8,
                                                      left: 10,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          AppColors.lightGrey,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppColors
                                                                .primaryColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          child: Image.asset(
                                                            AppAssets.direction,
                                                            height: 15,
                                                            width: 15,
                                                          ),
                                                        ),
                                                        padHorizontal(10),
                                                        const Label(
                                                          txt: 'Directions',
                                                          type: TextTypes
                                                              .f_12_500,
                                                          forceColor:
                                                              AppColors.grey,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                padHorizontal(15),
                                                GestureDetector(
                                                  onTap: () {
                                                    controller.makePhoneCall(
                                                        '${controller.userdata.value.data?.contactInfo ?? ""}');
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.only(
                                                      right: 30,
                                                      top: 8,
                                                      bottom: 8,
                                                      left: 10,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          AppColors.lightGrey,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Row(
                                                      children: [
                                                        Container(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(10),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppColors
                                                                .primaryColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          child: Image.asset(
                                                            AppAssets.call,
                                                            height: 15,
                                                            width: 15,
                                                          ),
                                                        ),
                                                        padHorizontal(10),
                                                        const Label(
                                                          txt: 'Call Now',
                                                          type: TextTypes
                                                              .f_12_500,
                                                          forceColor:
                                                              AppColors.grey,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8),
                                              padding: const EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                color: AppColors.lightGrey,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Label(
                                                        txt: 'Date',
                                                        type:
                                                            TextTypes.f_14_700,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () => controller
                                                            .pickFutureDate(
                                                                context),
                                                        child: const Label(
                                                          txt: 'More',
                                                          type: TextTypes
                                                              .f_12_400,
                                                          forceColor:
                                                              AppColors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  CustomLinearCalendar(
                                                    itemWidth: Get.width / 9.2,
                                                    height: 80,
                                                    selectedBorderColor:
                                                        Colors.blue,
                                                    selectedColor: Colors.blue,
                                                    borderWidth: 5,
                                                    monthVisibility: true,
                                                    onChanged:
                                                        (DateTime newDate) {
                                                      controller.courtSelections
                                                          .value = {};
                                                      controller.updatedSlots
                                                          .clear();
                                                      controller.selectedCourtId
                                                          .value = '';
                                                      controller
                                                          .onCalendarDateChanged(
                                                              newDate);
                                                    },
                                                    startDate: controller
                                                        .startDate, // Use Rx<DateTime>
                                                    unselectedTextStyle:
                                                        TextStyle(fontSize: 10),
                                                    selectedTextStyle:
                                                        TextStyle(
                                                            fontSize: 10,
                                                            color:
                                                                Colors.white),
                                                    controllerSelectedDate:
                                                        controller.selectedDate,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            padVertical(10),
                                            const Label(
                                              txt: 'Select a court',
                                              type: TextTypes.f_20_600,
                                            ),
                                            Label(
                                              txt:
                                                  '${controller.userdata.value.data?.address ?? ""},${controller.userdata.value.data?.city ?? ""},${controller.userdata.value.data?.state ?? ""}',
                                              type: TextTypes.f_12_500,
                                              forceColor: AppColors.grey,
                                            ),
                                            padVertical(10),
                                            Obx(
                                                () =>
                                                    controller
                                                                .userdata
                                                                .value
                                                                .data
                                                                ?.courts
                                                                ?.length ==
                                                            0
                                                        ? SizedBox(
                                                            height: 100,
                                                            child: Center(
                                                              child: Label(
                                                                  txt:
                                                                      "No Court Available",
                                                                  type: TextTypes
                                                                      .f_14_500),
                                                            ),
                                                          )
                                                        : ListView.builder(
                                                            shrinkWrap: true,
                                                            physics:
                                                                const NeverScrollableScrollPhysics(),
                                                            itemCount: controller
                                                                    .userdata
                                                                    .value
                                                                    .data
                                                                    ?.courts
                                                                    ?.length ??
                                                                0,
                                                            itemBuilder:
                                                                (context,
                                                                    index) {
                                                              final court = controller
                                                                      .userdata
                                                                      .value
                                                                      .data
                                                                      ?.courts?[
                                                                  index];
                                                              final courtId =
                                                                  court?.sId ??
                                                                      "";
                                                              final hourlyRate =
                                                                  court?.hourlyRate ??
                                                                      0;
                                                              final name =
                                                                  court?.name ??
                                                                      "";
                                                              final game = court
                                                                      ?.games ??
                                                                  "Padel";

                                                              // Filter morning and evening slots
                                                              final allTimeSlots =
                                                                  court?.availableSlots ??
                                                                      [];
                                                              final morningSlots =
                                                                  allTimeSlots
                                                                      .where(
                                                                          (slot) {
                                                                if (slot.time ==
                                                                    null)
                                                                  return false;
                                                                final hour = int
                                                                    .parse(slot
                                                                        .time!
                                                                        .split(
                                                                            ':')[0]);
                                                                return hour >=
                                                                        6 &&
                                                                    hour <= 12;
                                                              }).toList();

                                                              final eveningSlots =
                                                                  allTimeSlots
                                                                      .where(
                                                                          (slot) {
                                                                if (slot.time ==
                                                                    null)
                                                                  return false;
                                                                final hour = int
                                                                    .parse(slot
                                                                        .time!
                                                                        .split(
                                                                            ':')[0]);
                                                                return hour >=
                                                                        13 &&
                                                                    hour <= 24;
                                                              }).toList();

                                                              // Function to format time to AM/PM
                                                              String
                                                                  formatTimeToAmPm(
                                                                      String
                                                                          time) {
                                                                try {
                                                                  final dateTime =
                                                                      DateFormat(
                                                                              'HH:mm')
                                                                          .parse(
                                                                              time);
                                                                  return DateFormat(
                                                                          'h:mm a')
                                                                      .format(
                                                                          dateTime);
                                                                } catch (e) {
                                                                  return time; // Return original time if parsing fails
                                                                }
                                                              }

                                                              return Obx(() {
                                                                final currentSelection =
                                                                    controller
                                                                        .courtSelections
                                                                        .value[courtId];
                                                                final selectedSlots =
                                                                    currentSelection
                                                                            ?.timeSlots ??
                                                                        [];

                                                                return Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    Container(
                                                                      margin: const EdgeInsets
                                                                          .symmetric(
                                                                          vertical:
                                                                              8),
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          15),
                                                                      width: double
                                                                          .infinity,
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: AppColors
                                                                            .lightGrey,
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                      ),
                                                                      child:
                                                                          Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.start,
                                                                        children: [
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () {
                                                                              if (controller.selectedCourtId.value != courtId) {
                                                                                controller.courtSelections.value = {};
                                                                                controller.updatedSlots.clear();
                                                                                controller.selectedCourtId.value = '';
                                                                              }
                                                                              controller.updateCourtSelection(
                                                                                courtId,
                                                                                game: game,
                                                                              );
                                                                            },
                                                                            child:
                                                                                Label(
                                                                              txt: name,
                                                                              type: TextTypes.f_14_700,
                                                                              forceColor: controller.selectedCourtId.value == courtId ? AppColors.primaryColor : AppColors.blackColor,
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                              height: 10),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            children: [
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  controller.updateCourtSelection(
                                                                                    courtId,
                                                                                    rate: "60 Mins",
                                                                                    game: game,
                                                                                  );
                                                                                },
                                                                                child: Container(
                                                                                  padding: const EdgeInsets.symmetric(
                                                                                    horizontal: 20,
                                                                                    vertical: 10,
                                                                                  ),
                                                                                  decoration: BoxDecoration(
                                                                                    color: currentSelection?.rate == "60 Mins" ? AppColors.primaryColor : AppColors.lightGrey,
                                                                                    borderRadius: BorderRadius.circular(8),
                                                                                    border: Border.all(
                                                                                      color: currentSelection?.rate == "60 Mins" ? AppColors.primaryColor : AppColors.grey,
                                                                                      width: currentSelection?.rate == "60 Mins" ? 2 : 1,
                                                                                    ),
                                                                                  ),
                                                                                  child: Column(
                                                                                    children: [
                                                                                      Label(
                                                                                        txt: '60 Mins',
                                                                                        type: TextTypes.f_12_500,
                                                                                        forceColor: currentSelection?.rate == "60 Mins" ? AppColors.whiteColor : AppColors.grey,
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              padHorizontal(10),
                                                                              GestureDetector(
                                                                                onTap: () {
                                                                                  controller.updateCourtSelection(
                                                                                    courtId,
                                                                                    rate: "120 Mins",
                                                                                    game: game,
                                                                                  );
                                                                                },
                                                                                child: Container(
                                                                                  padding: const EdgeInsets.symmetric(
                                                                                    horizontal: 20,
                                                                                    vertical: 10,
                                                                                  ),
                                                                                  decoration: BoxDecoration(
                                                                                    color: currentSelection?.rate == "120 Mins" ? AppColors.primaryColor : AppColors.lightGrey,
                                                                                    borderRadius: BorderRadius.circular(8),
                                                                                    border: Border.all(
                                                                                      color: currentSelection?.rate == "120 Mins" ? AppColors.primaryColor : AppColors.grey,
                                                                                      width: currentSelection?.rate == "120 Mins" ? 2 : 1,
                                                                                    ),
                                                                                  ),
                                                                                  child: Column(
                                                                                    children: [
                                                                                      Label(
                                                                                        txt: '120 Mins',
                                                                                        type: TextTypes.f_12_500,
                                                                                        forceColor: currentSelection?.rate == "120 Mins" ? AppColors.whiteColor : AppColors.grey,
                                                                                      ),
                                                                                    ],
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    if (controller
                                                                            .selectedCourtId
                                                                            .value ==
                                                                        courtId) ...[
                                                                      if (morningSlots
                                                                          .isNotEmpty) ...[
                                                                        Container(
                                                                          margin: const EdgeInsets
                                                                              .symmetric(
                                                                              vertical: 8),
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              15),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                AppColors.lightGrey,
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                          ),
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              const Row(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                children: [
                                                                                  Label(
                                                                                    txt: 'Morning',
                                                                                    type: TextTypes.f_14_700,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              padVertical(10),
                                                                              Wrap(
                                                                                spacing: 10,
                                                                                runSpacing: 10,
                                                                                children: morningSlots.map((slot) {
                                                                                  final isSelected = selectedSlots.any((s) => s.time == slot.time);
                                                                                  final isAvailable = slot.isAvailable == true;

                                                                                  return GestureDetector(
                                                                                    onTap: isAvailable
                                                                                        ? () {
                                                                                            controller.updateCourtSelection(
                                                                                              courtId,
                                                                                              timeSlot: slot,
                                                                                              game: game,
                                                                                            );
                                                                                          }
                                                                                        : null,
                                                                                    child: Container(
                                                                                      width: (Get.width - 100) / 3,
                                                                                      padding: const EdgeInsets.all(10),
                                                                                      decoration: BoxDecoration(
                                                                                        color: isSelected ? AppColors.primaryColor : (isAvailable ? AppColors.whiteColor : Colors.orange),
                                                                                        borderRadius: BorderRadius.circular(5),
                                                                                        border: Border.all(
                                                                                          color: isSelected ? AppColors.primaryColor : (isAvailable ? AppColors.grey : Colors.white),
                                                                                          width: isSelected ? 2 : 1,
                                                                                        ),
                                                                                      ),
                                                                                      child: Column(
                                                                                        children: [
                                                                                          Label(
                                                                                            txt: formatTimeToAmPm(slot.time ?? ""),
                                                                                            type: TextTypes.f_10_400,
                                                                                            forceColor: isSelected ? Colors.white : (isAvailable ? AppColors.smalltxt : Colors.white),
                                                                                          ),
                                                                                          Label(
                                                                                            txt: "₹ ${slot.price.toString()}",
                                                                                            type: TextTypes.f_10_400,
                                                                                            forceColor: isSelected ? Colors.white : (isAvailable ? AppColors.smalltxt : Colors.white),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                }).toList(),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                      if (eveningSlots
                                                                          .isNotEmpty) ...[
                                                                        Container(
                                                                          margin: const EdgeInsets
                                                                              .symmetric(
                                                                              vertical: 8),
                                                                          padding: const EdgeInsets
                                                                              .all(
                                                                              15),
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                AppColors.lightGrey,
                                                                            borderRadius:
                                                                                BorderRadius.circular(10),
                                                                          ),
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.start,
                                                                            crossAxisAlignment:
                                                                                CrossAxisAlignment.start,
                                                                            children: [
                                                                              const Row(
                                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                                children: [
                                                                                  Label(
                                                                                    txt: 'Afternoon',
                                                                                    type: TextTypes.f_14_700,
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                              padVertical(10),
                                                                              Wrap(
                                                                                spacing: 10,
                                                                                runSpacing: 10,
                                                                                children: eveningSlots.map((slot) {
                                                                                  final isSelected = selectedSlots.any((s) => s.time == slot.time);
                                                                                  final isAvailable = slot.isAvailable == true;

                                                                                  return GestureDetector(
                                                                                    onTap: isAvailable
                                                                                        ? () {
                                                                                            controller.updateCourtSelection(
                                                                                              courtId,
                                                                                              timeSlot: slot,
                                                                                              game: game,
                                                                                            );
                                                                                          }
                                                                                        : null,
                                                                                    child: Container(
                                                                                      width: (Get.width - 100) / 3,
                                                                                      padding: const EdgeInsets.all(10),
                                                                                      decoration: BoxDecoration(
                                                                                        color: isSelected ? AppColors.primaryColor : (isAvailable ? AppColors.whiteColor : Colors.orange),
                                                                                        borderRadius: BorderRadius.circular(5),
                                                                                        border: Border.all(
                                                                                          color: isSelected ? AppColors.primaryColor : (isAvailable ? AppColors.grey : Colors.white),
                                                                                          width: isSelected ? 2 : 1,
                                                                                        ),
                                                                                      ),
                                                                                      child: Column(
                                                                                        children: [
                                                                                          Label(
                                                                                            txt: formatTimeToAmPm(slot.time ?? ""),
                                                                                            type: TextTypes.f_10_400,
                                                                                            forceColor: isSelected ? Colors.white : (isAvailable ? AppColors.smalltxt : Colors.white),
                                                                                          ),
                                                                                          Label(
                                                                                            txt: "₹ ${slot.price.toString()}",
                                                                                            type: TextTypes.f_10_400,
                                                                                            forceColor: isSelected ? Colors.white : (isAvailable ? AppColors.smalltxt : Colors.white),
                                                                                          ),
                                                                                        ],
                                                                                      ),
                                                                                    ),
                                                                                  );
                                                                                }).toList(),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ],
                                                                  ],
                                                                );
                                                              });
                                                            },
                                                          )),
                                            Container(
                                              width: double.infinity,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8),
                                              padding: const EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                color: AppColors.lightGrey,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Label(
                                                        txt: 'Game Type',
                                                        type:
                                                            TextTypes.f_14_700,
                                                      ),
                                                      GestureDetector(
                                                          onTap: () async {
                                                            await controller
                                                                .tooltipcontroller
                                                                .showTooltip();
                                                          },
                                                          child: SuperTooltip(
                                                              showBarrier: true,
                                                              controller: controller
                                                                  .tooltipcontroller,
                                                              content:
                                                                  const Text(
                                                                "Lorem ipsum dolor sit amet, consetetur sadipscing elitr,",
                                                                softWrap: true,
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                              child: Icon(
                                                                Icons
                                                                    .info_outline,
                                                                size: 17,
                                                              ))),
                                                    ],
                                                  ),
                                                  padVertical(5),
                                                  Container(
                                                    width: double.infinity,
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 8,
                                                    ),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 10,
                                                      vertical: 5,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          AppColors.whiteColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Obx(
                                                            () =>
                                                                GestureDetector(
                                                              onTap: () => {
                                                                controller
                                                                    .setAskJoin(
                                                                        true),
                                                              },
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            12),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: controller
                                                                              .askJoin
                                                                              .value ==
                                                                          true
                                                                      ? AppColors
                                                                          .blue2
                                                                      : AppColors
                                                                          .whiteColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  boxShadow:
                                                                      controller.askJoin.value ==
                                                                              true
                                                                          ? [
                                                                              const BoxShadow(color: Colors.black12, blurRadius: 2)
                                                                            ]
                                                                          : null,
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .public,
                                                                      size: 13,
                                                                      color: controller.askJoin.value ==
                                                                              true
                                                                          ? AppColors
                                                                              .whiteColor
                                                                          : AppColors
                                                                              .grey,
                                                                    ),
                                                                    padHorizontal(
                                                                        5),
                                                                    Label(
                                                                      txt:
                                                                          'Public',
                                                                      forceColor: controller.askJoin.value ==
                                                                              true
                                                                          ? AppColors
                                                                              .whiteColor
                                                                          : AppColors
                                                                              .grey,
                                                                      type: TextTypes
                                                                          .f_12_500,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        Expanded(
                                                          child: Obx(
                                                            () =>
                                                                GestureDetector(
                                                              onTap: () =>
                                                                  controller
                                                                      .setAskJoin(
                                                                          false),
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            12),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: controller
                                                                              .askJoin
                                                                              .value ==
                                                                          false
                                                                      ? AppColors
                                                                          .blue2
                                                                      : AppColors
                                                                          .whiteColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  boxShadow: controller
                                                                              .askJoin
                                                                              .value ==
                                                                          false
                                                                      ? [
                                                                          const BoxShadow(
                                                                              color: Colors.black12,
                                                                              blurRadius: 2)
                                                                        ]
                                                                      : null,
                                                                ),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Icon(
                                                                      Icons
                                                                          .lock_outline,
                                                                      size: 13,
                                                                      color: controller.askJoin.value ==
                                                                              false
                                                                          ? AppColors
                                                                              .whiteColor
                                                                          : AppColors
                                                                              .grey,
                                                                    ),
                                                                    padHorizontal(
                                                                        5),
                                                                    Label(
                                                                      txt:
                                                                          'Private',
                                                                      forceColor: controller.askJoin.value ==
                                                                              false
                                                                          ? AppColors
                                                                              .whiteColor
                                                                          : AppColors
                                                                              .grey,
                                                                      type: TextTypes
                                                                          .f_12_500,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  padVertical(10),
                                                  const Divider(
                                                    color:
                                                        AppColors.lightpercen,
                                                  ),
                                                  padVertical(10),
                                                  Obx(
                                                    () => Row(
                                                      children: [
                                                        GestureDetector(
                                                          onTap: controller
                                                              .toggleCheckBox,
                                                          child: Icon(
                                                            controller.checkBox
                                                                    .value
                                                                ? Icons
                                                                    .check_box_outlined
                                                                : Icons
                                                                    .check_box_outline_blank_outlined,
                                                            size: 25,
                                                            color: controller
                                                                    .checkBox
                                                                    .value
                                                                ? AppColors
                                                                    .primaryColor
                                                                : AppColors
                                                                    .grey,
                                                          ),
                                                        ),
                                                        padHorizontal(5),
                                                        const Label(
                                                          txt:
                                                              'Add your friends',
                                                          type: TextTypes
                                                              .f_12_500,
                                                          forceColor:
                                                              AppColors.grey,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  padVertical(10),
                                                  controller.checkBox.value ==
                                                          true
                                                      ? SizedBox(
                                                          height: 80,
                                                          child: Row(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                            children: [
                                                              Expanded(
                                                                child: ListView
                                                                    .builder(
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  itemCount: 2,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    return Obx(
                                                                        () {
                                                                      final friendName = controller
                                                                          .selectedFriends[
                                                                              index]
                                                                          ?.fullName;
                                                                      return Padding(
                                                                        padding:
                                                                            EdgeInsets.symmetric(horizontal: 8),
                                                                        child:
                                                                            GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            if (friendName != null &&
                                                                                friendName.isNotEmpty &&
                                                                                index != 0) {
                                                                              controller.selectedFriends[index] = null;
                                                                              controller.selectedFriends.refresh();
                                                                            } else {
                                                                              controller.showFriendsBottomSheet(context, index);
                                                                            }
                                                                          },
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              friendName != null && friendName.isNotEmpty
                                                                                  ? ClipRRect(
                                                                                      borderRadius: BorderRadius.circular(50),
                                                                                      child: Image.network(
                                                                                        fit: BoxFit.cover,
                                                                                        height: 50,
                                                                                        width: 50,
                                                                                        "${imageBaseUrl}${index == 0 ? controller.userresponseModel.value.data?.profilePic : controller.selectedFriends[index]?.profilePic}",
                                                                                        errorBuilder: (context, error, stackTrace) {
                                                                                          return Container(
                                                                                            decoration: BoxDecoration(
                                                                                              color: AppColors.addbtn,
                                                                                              borderRadius: BorderRadius.circular(30),
                                                                                            ),
                                                                                            child: Icon(
                                                                                              Icons.person, // Error image/icon
                                                                                              size: 33.sp,
                                                                                              color: AppColors.grey,
                                                                                            ).paddingAll(10),
                                                                                          );
                                                                                        },
                                                                                      ))
                                                                                  : Container(
                                                                                      height: 50,
                                                                                      width: 50,
                                                                                      decoration: BoxDecoration(
                                                                                        color: AppColors.addbtn,
                                                                                        borderRadius: BorderRadius.circular(30),
                                                                                      ),
                                                                                      child: Icon(
                                                                                        Icons.add,
                                                                                      ),
                                                                                    ),
                                                                              SizedBox(
                                                                                  width: 50,
                                                                                  child: Label(
                                                                                    txt: friendName ?? "",
                                                                                    type: TextTypes.f_10_400,
                                                                                    forceColor: AppColors.primaryColor,
                                                                                  ))
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      );
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                              Container(
                                                                width: 1,
                                                                height: 70,
                                                                color: AppColors
                                                                    .whiteColor,
                                                              ),
                                                              Expanded(
                                                                child: ListView
                                                                    .builder(
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  itemCount: 2,
                                                                  itemBuilder:
                                                                      (context,
                                                                          index) {
                                                                    final slotIndex =
                                                                        index +
                                                                            2;
                                                                    return Obx(
                                                                        () {
                                                                      final friendName = controller
                                                                          .selectedFriends[
                                                                              slotIndex]
                                                                          ?.fullName;
                                                                      return Padding(
                                                                        padding:
                                                                            EdgeInsets.symmetric(horizontal: 10),
                                                                        child:
                                                                            GestureDetector(
                                                                          onTap:
                                                                              () {
                                                                            if (friendName != null &&
                                                                                friendName.isNotEmpty) {
                                                                              controller.selectedFriends[slotIndex] = null;
                                                                              controller.selectedFriends.refresh();
                                                                            } else {
                                                                              controller.showFriendsBottomSheet(context, slotIndex);
                                                                            }
                                                                          },
                                                                          child:
                                                                              Column(
                                                                            children: [
                                                                              friendName != null && friendName.isNotEmpty
                                                                                  ? ClipRRect(
                                                                                      borderRadius: BorderRadius.circular(50),
                                                                                      child: Image.network(fit: BoxFit.cover, height: 50, width: 50, "${imageBaseUrl}${controller.selectedFriends[index + 2]?.profilePic}", errorBuilder: (context, error, stackTrace) {
                                                                                        return Container(
                                                                                          decoration: BoxDecoration(
                                                                                            color: AppColors.addbtn,
                                                                                            borderRadius: BorderRadius.circular(30),
                                                                                          ),
                                                                                          child: Icon(
                                                                                            Icons.person, // Error image/icon
                                                                                            size: 33.sp,
                                                                                            color: AppColors.grey,
                                                                                          ).paddingAll(10),
                                                                                        );
                                                                                      }))
                                                                                  : Container(
                                                                                      height: 50,
                                                                                      width: 50,
                                                                                      decoration: BoxDecoration(
                                                                                        color: AppColors.addbtn,
                                                                                        borderRadius: BorderRadius.circular(30),
                                                                                      ),
                                                                                      child: Icon(
                                                                                        Icons.add,
                                                                                      ),
                                                                                    ),
                                                                              SizedBox(
                                                                                width: 50,
                                                                                child: Label(
                                                                                  txt: friendName ?? "",
                                                                                  type: TextTypes.f_10_400,
                                                                                  forceColor: AppColors.primaryColor,
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      );
                                                                    });
                                                                  },
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        )
                                                      : SizedBox(),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8),
                                              padding: const EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                color: AppColors.lightGrey,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Label(
                                                        txt: 'Match Type',
                                                        type:
                                                            TextTypes.f_14_700,
                                                      ),
                                                      GestureDetector(
                                                          onTap: () async {
                                                            await controller
                                                                .matchtooltipcontroller
                                                                .showTooltip();
                                                          },
                                                          child: SuperTooltip(
                                                              showBarrier: true,
                                                              controller: controller
                                                                  .matchtooltipcontroller,
                                                              content:
                                                                  const Text(
                                                                "Lorem ipsum dolor sit amet, consetetur sadipscing elitr,",
                                                                softWrap: true,
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                              child: Icon(
                                                                Icons
                                                                    .info_outline,
                                                                size: 17,
                                                              ))),
                                                    ],
                                                  ),
                                                  padVertical(5),
                                                  Container(
                                                    width: double.infinity,
                                                    margin: const EdgeInsets
                                                        .symmetric(
                                                      vertical: 8,
                                                    ),
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                      horizontal: 10,
                                                      vertical: 5,
                                                    ),
                                                    decoration: BoxDecoration(
                                                      color:
                                                          AppColors.whiteColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Expanded(
                                                          child: Obx(
                                                            () =>
                                                                GestureDetector(
                                                              onTap: () =>
                                                                  controller
                                                                      .setSelectedButton2(
                                                                          0),
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            12),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: controller
                                                                              .selectedButton2
                                                                              .value ==
                                                                          0
                                                                      ? AppColors
                                                                          .blue2
                                                                      : Colors
                                                                          .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  boxShadow:
                                                                      controller.selectedButton2.value ==
                                                                              0
                                                                          ? [
                                                                              const BoxShadow(color: Colors.black12, blurRadius: 2)
                                                                            ]
                                                                          : null,
                                                                ),
                                                                child: Center(
                                                                  child: Label(
                                                                    txt:
                                                                        'Friendly',
                                                                    forceColor: controller.selectedButton2.value ==
                                                                            0
                                                                        ? AppColors
                                                                            .whiteColor
                                                                        : AppColors
                                                                            .grey,
                                                                    type: TextTypes
                                                                        .f_12_500,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 10),
                                                        Expanded(
                                                          child: Obx(
                                                            () =>
                                                                GestureDetector(
                                                              onTap: () =>
                                                                  controller
                                                                      .setSelectedButton2(
                                                                          1),
                                                              child: Container(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                        vertical:
                                                                            12),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: controller
                                                                              .selectedButton2
                                                                              .value ==
                                                                          1
                                                                      ? AppColors
                                                                          .blue2
                                                                      : Colors
                                                                          .white,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5),
                                                                  boxShadow:
                                                                      controller.selectedButton2.value ==
                                                                              1
                                                                          ? [
                                                                              const BoxShadow(color: Colors.black12, blurRadius: 2)
                                                                            ]
                                                                          : null,
                                                                ),
                                                                child: Center(
                                                                  child: Label(
                                                                    txt:
                                                                        'Competitive',
                                                                    forceColor: controller.selectedButton2.value ==
                                                                            1
                                                                        ? AppColors
                                                                            .whiteColor
                                                                        : AppColors
                                                                            .grey,
                                                                    type: TextTypes
                                                                        .f_12_500,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: double.infinity,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8),
                                              padding: const EdgeInsets.all(15),
                                              decoration: BoxDecoration(
                                                color: AppColors.lightGrey,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Label(
                                                        txt: 'Skill Required',
                                                        type:
                                                            TextTypes.f_14_700,
                                                      ),
                                                      GestureDetector(
                                                          onTap: () async {
                                                            await controller
                                                                .skilltooltipcontroller
                                                                .showTooltip();
                                                          },
                                                          child: SuperTooltip(
                                                              showBarrier: true,
                                                              controller: controller
                                                                  .skilltooltipcontroller,
                                                              content:
                                                                  const Text(
                                                                "Lorem ipsum dolor sit amet, consetetur sadipscing elitr,",
                                                                softWrap: true,
                                                                style:
                                                                    TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                ),
                                                              ),
                                                              child: Icon(
                                                                Icons
                                                                    .info_outline,
                                                                size: 17,
                                                              ))),
                                                    ],
                                                  ),
                                                  padVertical(20),
                                                  Obx(
                                                    () => Row(
                                                      children: [
                                                        Expanded(
                                                          child: Container(
                                                            height: 15,
                                                            decoration:
                                                                const BoxDecoration(
                                                              color: AppColors
                                                                  .slidercon,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                topLeft: Radius
                                                                    .circular(
                                                                        10),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        10),
                                                              ),
                                                            ),
                                                            child: Slider(
                                                              value: controller
                                                                  .progressValue
                                                                  .value,
                                                              min: 0,
                                                              max: 100,
                                                              divisions: 100,
                                                              label:
                                                                  '${controller.progressValue.value.toInt()}%',
                                                              onChanged: (value) =>
                                                                  controller
                                                                      .setProgressValue(
                                                                          value),
                                                              activeColor: AppColors
                                                                  .primaryColor,
                                                              inactiveColor:
                                                                  AppColors
                                                                      .sliderin,
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          height: 45,
                                                          width: 45,
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5),
                                                          decoration:
                                                              BoxDecoration(
                                                            color: AppColors
                                                                .slidercon,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                          ),
                                                          child: Container(
                                                            height: 30,
                                                            width: 30,
                                                            decoration:
                                                                BoxDecoration(
                                                              color: AppColors
                                                                  .lightpercen,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          20),
                                                              boxShadow: const [
                                                                BoxShadow(
                                                                  color: Colors
                                                                      .black12,
                                                                  blurRadius: 2,
                                                                ),
                                                              ],
                                                            ),
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Label(
                                                                txt:
                                                                    '${controller.progressValue.value.toInt()}%',
                                                                type: TextTypes
                                                                    .f_10_600,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: double.infinity,
                                              child: commonButton(
                                                context: context,
                                                onPressed: () {
                                                  // Get the selected court's time slots
                                                  final selectedCourtId =
                                                      controller.selectedCourtId
                                                          .value;
                                                  final courtSelection =
                                                      controller
                                                              .courtSelections[
                                                          selectedCourtId];
                                                  final selectedSlots =
                                                      courtSelection
                                                              ?.timeSlots ??
                                                          [];

                                                  // Extract time strings from the selected slots
                                                  List<String> bookingSlots =
                                                      selectedSlots
                                                          .map((slot) =>
                                                              slot.time)
                                                          .whereType<String>()
                                                          .toList();

                                                  List<int> priceSlots =
                                                      selectedSlots
                                                          .map((slot) => slot
                                                              .price
                                                              ?.toInt())
                                                          .whereType<int>()
                                                          .toList();

                                                  int totalAmount = 0;
                                                  for (int num in priceSlots) {
                                                    totalAmount += num;
                                                  }
                                                  bookingSlots.sort();

                                                  Get.closeAllSnackbars();

                                                  // Check if court is selected
                                                  if (controller.selectedCourtId
                                                              .value ==
                                                          "" ||
                                                      controller.selectedCourtId
                                                              ?.value ==
                                                          null) {
                                                    Get.snackbar("Error",
                                                        "Please Select Court",
                                                        snackPosition:
                                                            SnackPosition.TOP);
                                                    return;
                                                  }

                                                  // Check if time slots are selected
                                                  if (bookingSlots.isEmpty) {
                                                    Get.snackbar("Error",
                                                        "Please Select Time Slots",
                                                        snackPosition:
                                                            SnackPosition.TOP);
                                                    return;
                                                  }

                                                  // Check if at least two players are selected
                                                  if (!controller
                                                      .hasMinimumPlayers()) {
                                                    Get.snackbar("Error",
                                                        "Please select at least two players",
                                                        snackPosition:
                                                            SnackPosition.TOP,
                                                        backgroundColor:
                                                            Colors.redAccent,
                                                        colorText:
                                                            Colors.white);
                                                    return;
                                                  }

                                                  Map<String, dynamic>
                                                      requestModel =
                                                      BookingRequestModel
                                                          .bookingRequestModel(
                                                    askToJoin: controller
                                                        .askJoin.value,
                                                    isCompetitive: controller
                                                                .selectedButton2
                                                                .value ==
                                                            0
                                                        ? false
                                                        : true,
                                                    skillRequired: controller
                                                        .progressValue.value,
                                                    team1: [
                                                      if (controller
                                                              .selectedFriends
                                                              .isNotEmpty &&
                                                          controller.selectedFriends[
                                                                  0] !=
                                                              null)
                                                        {
                                                          "playerId": controller
                                                                  .selectedFriends[
                                                                      0]
                                                                  ?.sId ??
                                                              "",
                                                          "playerType":
                                                              "player1",
                                                          "racketA": "",
                                                          "racketB": "",
                                                          "racketC": "",
                                                          "racketD": "",
                                                          "balls": "",
                                                        },
                                                      if (controller
                                                                  .selectedFriends
                                                                  .length >
                                                              1 &&
                                                          controller.selectedFriends[
                                                                  1] !=
                                                              null)
                                                        {
                                                          "playerId": controller
                                                                  .selectedFriends[
                                                                      1]
                                                                  ?.sId ??
                                                              "",
                                                          "playerType":
                                                              "player2",
                                                          "racketA": "",
                                                          "racketB": "",
                                                          "racketC": "",
                                                          "racketD": "",
                                                          "balls": "",
                                                        },
                                                    ],
                                                    team2: controller
                                                                .selectedFriends
                                                                .length <=
                                                            2
                                                        ? []
                                                        : [
                                                            if (controller
                                                                        .selectedFriends
                                                                        .length >
                                                                    2 &&
                                                                controller.selectedFriends[
                                                                        2] !=
                                                                    null)
                                                              {
                                                                "playerId": controller
                                                                        .selectedFriends[
                                                                            2]
                                                                        ?.sId ??
                                                                    "",
                                                                "playerType":
                                                                    "player3",
                                                                "racketA": "",
                                                                "racketB": "",
                                                                "racketC": "",
                                                                "racketD": "",
                                                                "balls": "",
                                                              },
                                                            if (controller
                                                                        .selectedFriends
                                                                        .length >
                                                                    3 &&
                                                                controller.selectedFriends[
                                                                        3] !=
                                                                    null)
                                                              {
                                                                "playerId": controller
                                                                        .selectedFriends[
                                                                            3]
                                                                        ?.sId ??
                                                                    "",
                                                                "playerType":
                                                                    "player4",
                                                                "racketA": "",
                                                                "racketB": "",
                                                                "racketC": "",
                                                                "racketD": "",
                                                                "balls": "",
                                                              },
                                                          ],
                                                    venueId: controller
                                                            .userdata
                                                            ?.value
                                                            ?.data
                                                            ?.sId ??
                                                        "",
                                                    courtId: controller
                                                            .selectedCourtId
                                                            ?.value ??
                                                        "",
                                                    bookingDate: controller
                                                            .selectedDate.value
                                                            ?.toString() ??
                                                        "",
                                                    bookingSlots: bookingSlots,
                                                    bookingType: "Booking",
                                                  );

                                                  Get.offNamed(
                                                    "/confirm_payment",
                                                    arguments: {
                                                      "selectedGame": controller
                                                          .selectedgame.value,
                                                      "address":
                                                          '${controller.userdata.value.data?.address ?? ""},${controller.userdata.value.data?.city ?? ""},${controller.userdata.value.data?.state ?? ""}',
                                                      "Rate":
                                                          controller.Rate.value,
                                                      "image": controller
                                                              .userdata
                                                              .value
                                                              .data
                                                              ?.image ??
                                                          "",
                                                      "requestModel":
                                                          requestModel,
                                                      "hourlyRate": totalAmount
                                                    },
                                                  );
                                                },
                                                txt: 'Continue',
                                              ),
                                            ),
                                            padVertical(10),
                                          ],
                                        ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
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
