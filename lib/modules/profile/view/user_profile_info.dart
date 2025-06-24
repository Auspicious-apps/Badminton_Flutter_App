import 'package:badminton/app_settings/components/label.dart';
import 'package:badminton/app_settings/components/widget_global_margin.dart';
import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/constants/app_dim.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../repository/endpoint.dart';
import '../../creategames/model/AllBookingsResponseModel.dart';
import '../controller/user_profile_info_controller.dart';

class PgProfileDetail extends GetView<PgProfileDetailController> {
  const PgProfileDetail({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double playerSlotSize = screenWidth * 0.1; // 10% of screen width for each slot
    final double spacing = screenWidth * 0.02;

    bool isMatchTimePassed(dynamic match) {
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
        final now = DateTime.now();

        // Extract current hour and minute
        final currentHour = now.hour;
        final currentMinute = now.minute;

        // Compare times: return true if current time is after match time
        if (currentHour > matchHour) {
          return true;
        } else if (currentHour == matchHour) {
          return currentMinute > matchMinute;
        }
        return false;
      } catch (e) {
        print('Error parsing time: $e');
        return false; // Default to false if parsing fails
      }
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: WidgetGlobalMargin(
            child: Obx(
                  () => controller.loading.value
                  ? _buildSkeletonUI()
                  : _buildProfileContent(context),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSkeletonUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        padVertical(10),
        SkeletonAvatar(
          style: SkeletonAvatarStyle(
            width: 38.w,
            height: 29.h,
            borderRadius: BorderRadius.circular(5),
          ),
        ),
        padVertical(20),
        Center(
          child: SkeletonAvatar(
            style: SkeletonAvatarStyle(
              shape: BoxShape.circle,
              width: 158.w,
              height: 158.h,
            ),
          ),
        ),
        padVertical(20),
        Center(
          child: SkeletonLine(
            style: SkeletonLineStyle(
              height: 20.h,
              width: 150.w,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        padVertical(10),
        Center(
          child: SkeletonLine(
            style: SkeletonLineStyle(
              height: 12.h,
              width: 200.w,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        padVertical(20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: SkeletonLine(
                style: SkeletonLineStyle(
                  height: 50.h,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
            padHorizontal(20),
            Expanded(
              child: SkeletonLine(
                style: SkeletonLineStyle(
                  height: 50.h,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ),
          ],
        ),
        padVertical(10),
        SkeletonLine(
          style: SkeletonLineStyle(
            height: 16.h,
            width: 100.w,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        padVertical(10),
        _buildSkeletonStatRow(),
        _buildSkeletonStatRow(),
        _buildSkeletonStatRow(),
        _buildSkeletonStatRow(),
        _buildSkeletonStatRow(),
        _buildSkeletonStatRow(),
        _buildSkeletonStatRow(),
        padVertical(20),
      ],
    );
  }

  Widget _buildSkeletonStatRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SkeletonLine(
            style: SkeletonLineStyle(
              height: 12.h,
              width: 120.w,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          SkeletonLine(
            style: SkeletonLineStyle(
              height: 12.h,
              width: 50.w,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileContent(context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double playerSlotSize = screenWidth * 0.1; // 10% of screen width for each slot
    final double spacing = screenWidth * 0.02;


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        padVertical(10),
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
        padVertical(20),
        Center(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 3, color: AppColors.blue2),
                  borderRadius: const BorderRadius.all(Radius.circular(90)),
                ),
                height: 158,
                width: 158,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child:controller.userdata.value.data?.profilePic!=null? Image.network(
                    "${imageBaseUrl}${controller.userdata.value.data?.profilePic}",
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.lightGrey,
                        child: Icon(
                          Icons.person, // Error image/icon
                          size: 100.sp,
                          color: AppColors.grey,
                        ),
                      );
                    },
                  ):Container(
                    color: AppColors.lightGrey,
                    child: Icon(
                      Icons.person, // Error image/icon
                      size: 100.sp,
                      color: AppColors.grey,
                    )),
                ),
              ),
            ],
          ),
        ),
        padVertical(20),
        Center(
          child: Label(
            txt: controller.userdata.value.data?.fullName ?? "",
            type: TextTypes.f_20_600,
          ),
        ),
        padVertical(10),
        Center(
          child: Label(
            txt: "Last played on ${controller.profile['lastPlayed']}",
            type: TextTypes.f_12_400,
          ),
        ),
        padVertical(20),
        controller.isAdmin==true?SizedBox():Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: (controller.userdata.value.data?.isFriend == true)
                  ? GestureDetector(
                onTap: controller.removeFriendRequest,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColors.blue2,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Center(
                    child: Label(
                      txt: "Remove Friend",
                      type: TextTypes.f_12_500,
                      forceColor: AppColors.whiteColor,
                    ),
                  ),
                ),
              )
                  : (controller.userdata.value.data?.friendshipStatus ==
                  "request_sent")
                  ?GestureDetector(
                onTap:controller.load==true?(){} :controller.addFriend,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: AppColors.primaryColor)
                  ),
                  child:  Center(
                    child:controller.load==true? SizedBox(height: 20,width: 20,child: CircularProgressIndicator()): Label(
                      txt: "Cancel Request",
                      type: TextTypes.f_12_500,
                      forceColor: AppColors.primaryColor,
                    ),
                  ),
                ),
              )
                  :(controller.userdata.value.data?.friendshipStatus ==
                  "request_received")
                  ? GestureDetector(
                onTap: controller.confirmFriendRequest,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColors.blue2,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Center(
                    child: Label(
                      txt: "Confirm",
                      type: TextTypes.f_12_500,
                      forceColor: AppColors.whiteColor,
                    ),
                  ),
                ),
              ): GestureDetector(
                onTap:controller.load==true?(){} :controller.addFriend,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColors.blue2,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child:  Center(
                    child:controller.load==true? SizedBox(height: 20,width: 20,child: CircularProgressIndicator(color: Colors.white,)): Label(
                      txt: "Add friend",
                      type: TextTypes.f_12_500,
                      forceColor: AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
            ),
            padHorizontal(20),
            Expanded(
              child: GestureDetector(
                onTap: controller.sendMessage,
                child: Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: AppColors.blue2,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: const Center(
                    child: Label(
                      txt: "Message",
                      type: TextTypes.f_12_500,
                      forceColor: AppColors.whiteColor,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        padVertical(10),
        const Label(
          txt: "Statistics",
          type: TextTypes.f_16_600,
        ),
        padVertical(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Label(
              txt: "Level",
              type: TextTypes.f_12_700,
            ),
            Label(
              txt: controller.userdata.value.data?.stats?.level?.toString() ?? "0",
              type: TextTypes.f_12_700,
              forceColor: AppColors.grey,
            ),
          ],
        ),
        padVertical(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Label(
              txt: "Last month level",
              type: TextTypes.f_12_700,
            ),
            Label(
              txt: controller.userdata.value.data?.stats?.lastMonthLevel?.toString() ?? "0",
              type: TextTypes.f_12_700,
              forceColor: AppColors.grey,
            ),
          ],
        ),
        padVertical(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Label(
              txt: "Level this month",
              type: TextTypes.f_12_700,
            ),
            Label(
              txt: controller.userdata.value.data?.stats?.level?.toString() ?? "0",
              type: TextTypes.f_12_700,
              forceColor: AppColors.grey,
            ),
          ],
        ),
        padVertical(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Label(
              txt: "Level 6 months ago",
              type: TextTypes.f_12_700,
            ),
            Label(
              txt: controller.userdata.value.data?.stats?.level6MonthsAgo?.toString() ?? "0",
              type: TextTypes.f_12_700,
              forceColor: AppColors.grey,
            ),
          ],
        ),
        padVertical(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Label(
              txt: "Level 12 months ago",
              type: TextTypes.f_12_700,
            ),
            Label(
              txt: controller.userdata.value.data?.stats?.level1YearAgo?.toString() ?? "0",
              type: TextTypes.f_12_700,
              forceColor: AppColors.grey,
            ),
          ],
        ),
        padVertical(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Label(
              txt: "Improvement",
              type: TextTypes.f_12_700,
            ),
            Label(
              txt: controller.userdata.value.data?.stats?.improvement?.toString() ?? "0",
              type: TextTypes.f_12_700,
              forceColor: AppColors.grey,
            ),
          ],
        ),
        padVertical(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Label(
              txt: "Confidence",
              type: TextTypes.f_12_700,
            ),
            Label(
              txt: controller.userdata.value.data?.stats?.confidence?.toString() ?? "0",
              type: TextTypes.f_12_700,
              forceColor: AppColors.grey,
            ),
          ],
        ),
        padVertical(20),

        Label(
          txt: 'Previous Games',
          type: TextTypes.f_16_600,
        ).marginSymmetric(vertical: 20),
       Obx(()=> controller.userdata.value.data?.previousMatches?.length!=0? ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount:
          controller.userdata.value.data?.previousMatches?.length ??
              0,
          itemBuilder: (context, index) {
            final match =
            controller.userdata.value.data?.previousMatches?[index];
            return Container(
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
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: (){
                            print("${controller.userdata.value.data?.previousMatches?[index].matchType}");
                          },
                          child: Row(
                            children: [
                              Label(
                                txt: "•  ${match?.matchType}",
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
                        ),
                        Label(
                          txt: match?.isCompetitive == true
                              ? "Competitive Match"
                              : "Friendly Match" ?? "",
                          type: TextTypes.f_10_600,
                          forceColor: AppColors.smalltxt,
                        ).marginSymmetric(horizontal: spacing * 2),
                      ]).marginSymmetric(vertical: 10),
                  SizedBox(height: spacing),
                  // Responsive player slots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Left side: Two player slots
                      SizedBox(
                        height: 50,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal, // Horizontal scrolling
                          itemCount: match?.team1?.length ?? 0, // Number of players in team1
                          itemBuilder: (context, index) {
                            final player = match?.team1?[index]; // Access player at index
                            return Padding(
                              padding: EdgeInsets.only(right: spacing), // Spacing between items
                              child: Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.bottomCenter,
                                children: [
                                  // Circular image or placeholder
                                  player?.playerData?.profilePic == null
                                      ? Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),   color: AppColors.lightGrey,border: Border.all(color: AppColors.primaryColor)),
                                    child: Icon(
                                      Icons.person, // Placeholder icon
                                      size: 40.sp,
                                      color: AppColors.grey,
                                    ),
                                  )
                                      : ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.network(
                                      "${imageBaseUrl}${player?.playerData?.profilePic}",
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),   color: AppColors.lightGrey,border: Border.all(color: AppColors.primaryColor)),
                                          child: Icon(
                                            Icons.person, // Error image/icon
                                            size: 30.sp,
                                            color: AppColors.grey,
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
                                    right: 7, // Slightly offset to overlap the image
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: AppColors.primaryColor,
                                        border: Border.all(color: Colors.white),
                                      ),
                                      height: 12,
                                      width: 35,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      // Center line
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: spacing),
                        child: Container(
                          width: 2,
                          height: playerSlotSize * 1.2, // Dynamic height
                          color: AppColors.whiteColor,
                        ),
                      ),
                      // Right side: Two player slots
                      SizedBox(
                        height: 50,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal, // Horizontal scrolling
                          itemCount: match?.team2?.length ?? 0, // Number of players in team1
                          itemBuilder: (context, index) {
                            final player = match?.team2?[index]; // Access player at index
                            return Padding(
                              padding: EdgeInsets.only(right: spacing), // Spacing between items
                              child: Stack(
                                clipBehavior: Clip.none,
                                alignment: Alignment.bottomCenter,
                                children: [
                                  // Circular image or placeholder
                                  player?.playerData?.profilePic == null
                                      ? Container(
                                    height: 50,
                                    width: 50,
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),   color: AppColors.lightGrey,border: Border.all(color: AppColors.primaryColor)),
                                    child: Icon(
                                      Icons.person, // Placeholder icon
                                      size: 40.sp,
                                      color: AppColors.grey,
                                    ),
                                  )
                                      : ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.network(
                                      "${imageBaseUrl}${player?.playerData?.profilePic}",
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),   color: AppColors.lightGrey,border: Border.all(color: AppColors.primaryColor)),

                                          child: Icon(
                                            Icons.person, // Error image/icon
                                            size: 30.sp,
                                            color: AppColors.grey,
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
                                    right: 7, // Slightly offset to overlap the image
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: AppColors.primaryColor,
                                        border: Border.all(color: Colors.white),
                                      ),
                                      height: 12,
                                      width: 35,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ).marginSymmetric(horizontal: spacing * 2),
                  SizedBox(height: spacing),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
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
                                txt: match?.venue?.address ?? "",
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
                                    txt: match?.date != null
                                        ? DateFormat(
                                        'EEE, MMM d, yyyy')
                                        .format(
                                      DateTime.parse(match
                                          ?.date ??
                                          "")
                                          .toLocal(),
                                    )
                                        : "Unknown Date",
                                    type: TextTypes.f_10_400,
                                    forceColor: AppColors.smalltxt,
                                  ),
                                  Label(
                                    txt: match?.time != null
                                        ? (() {
                                      try {
                                        // Parse time-only string (e.g., "21:00")
                                        final timeFormat =
                                        DateFormat(
                                            'HH:mm');
                                        final parsedTime =
                                        timeFormat.parse(
                                            match?.time ??
                                                "");
                                        // Combine with a default date (today)
                                        final today =
                                        DateTime.now();
                                        final dateTime =
                                        DateTime(
                                          today.year,
                                          today.month,
                                          today.day,
                                          parsedTime.hour,
                                          parsedTime.minute,
                                        );
                                        return DateFormat(
                                            'h:mm a')
                                            .format(dateTime);
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
                      ).marginSymmetric(vertical: 10,horizontal: 20),

                ],
              ),
              match?.score?.set1!=null? Column(
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
                                    txt: "${match?.score?.set1?.team1??"0"}",
                                    type: TextTypes.f_14_600,
                                    forceColor: AppColors.smalltxt,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 30,
                                child: Center(
                                  child: Label(
                                    txt: "${match?.score?.set2?.team1??"0"}",
                                    type: TextTypes.f_14_600,
                                    forceColor: AppColors.smalltxt,
                                  ),
                                ),
                              ).marginSymmetric(horizontal: 10),
                              SizedBox(
                                width: 30,
                                child: Center(
                                  child: Label(
                                    txt: "${match?.score?.set3?.team1??"0"}",
                                    type: TextTypes.f_14_600,
                                    forceColor: AppColors.smalltxt,
                                  ),
                                ),
                              ),
                            ],
                          ).marginOnly(left:100),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width:70,child: Divider()),
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
                                    txt: "${match?.score?.set1?.team2??"0"}",
                                    type: TextTypes.f_14_600,
                                    forceColor: AppColors.smalltxt,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 30,
                                child: Center(
                                  child: Label(
                                    txt: "${match?.score?.set2?.team2??"0"}",
                                    type: TextTypes.f_14_600,
                                    forceColor: AppColors.smalltxt,
                                  ),
                                ),
                              ).marginSymmetric(horizontal: 10),
                              SizedBox(
                                width: 30,
                                child: Center(
                                  child: Label(
                                    txt: "${match?.score?.set3?.team2??"0"}",
                                    type: TextTypes.f_14_600,
                                    forceColor: AppColors.smalltxt,
                                  ),
                                ),
                              ),
                            ],
                          ).marginOnly(left: 100),
                        ],
                      ),
                    ],).marginSymmetric(horizontal: 10):SizedBox(),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: ()async {
                        final score = match?.score ??
                            Score(
                              set1: Set1(
                                  team1:
                                  match?.score?.set1?.team1,
                                  team2:
                                  match?.score?.set1?.team2),
                              set2: Set1(
                                  team1:
                                  match?.score?.set2?.team1,
                                  team2:
                                  match?.score?.set2?.team2),
                              set3: Set1(
                                  team1:
                                  match?.score?.set3?.team1,
                                  team2:
                                  match?.score?.set3?.team2),
                              bookingId: match
                                  ?.score?.bookingId, // Optional: Set bookingId if needed
                            );
                        await Get.toNamed("uploadScore", arguments: {
                          "game": match?.court?.sId ?? "",
                          "address":
                          match?.venue?.address ?? "",
                          "time": match?.time,
                          "date": match?.date,
                          "id": match?.matchId,
                          "score": score
                        });
                        controller.friendGetById();

                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.blue2,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Label(
                          txt: "Upload",
                          type: TextTypes.f_10_600,
                          forceColor: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  ).marginSymmetric(vertical: 10,horizontal: 20),


              ]),
            );
          },
        ):SizedBox(height: Get.height*0.2,width: Get.width,child: Center(child: Label(
          txt: "No Booking Found",
          type: TextTypes.f_16_600,
          forceColor: AppColors.smalltxt,
        ) ,),) ),
      ],
    );
  }

}