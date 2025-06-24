import 'package:badminton/app_settings/components/label.dart';
import 'package:badminton/app_settings/components/widget_global_margin.dart';
import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/constants/app_dim.dart';
import 'package:badminton/app_settings/constants/common_button.dart';
import 'package:cart_button/cart_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:super_tooltip/super_tooltip.dart';

import '../../../repository/endpoint.dart';
import '../controller/join_game_detail_controller.dart';

class PgJoinGameDetail extends StatelessWidget {
  const PgJoinGameDetail({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize the controller
    final PgJoinGameDetailController controller =
    Get.find<PgJoinGameDetailController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            GetBuilder<PgJoinGameDetailController>(
              builder: (controller) {
                return Obx(() => controller.loading.value
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
                                    txt: "Book Game",
                                    type: TextTypes.f_18_600,
                                  ),
                                ],
                              ),
                              padVertical(15),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8),
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: AppColors.lightGrey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    padVertical(5),
                                    controller.bookingResponseModel.value.data?.venueId?.image!=null||controller.bookingResponseModel.value.data?.venueId?.image?.trim()!=""? Container(
                                      width: Get.width,
                                      height: Get.height*0.2,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        image: DecorationImage(
                                          image: NetworkImage("${imageBaseUrl}${controller.bookingResponseModel.value.data?.venueId?.image??""}"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      // child: Stack(
                                      //   children: [
                                      //     Positioned(
                                      //       bottom: 10,
                                      //       right: 10,
                                      //       child: Container(
                                      //         padding:
                                      //             const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                                      //         child: Label(
                                      //           txt: banners[index]["title"]!,
                                      //           type: TextTypes.f_16_600,
                                      //           forceColor: AppColors.whiteColor,
                                      //         ),
                                      //       ),
                                      //     ),
                                      //   ],
                                      // ),
                                    ):ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
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
                                              "${controller.bookingResponseModel.value.data?.courtId?.games} Game",
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
                                              Icons
                                                  .calendar_today_outlined,
                                              color: AppColors.grey,
                                              size: 15,
                                            ),
                                            padHorizontal(5),
                                            Label(
                                              txt: DateFormat(
                                                  'yyyy-MM-dd')
                                                  .format(DateTime.parse(
                                                  controller
                                                      .bookingResponseModel
                                                      .value
                                                      .data
                                                      ?.bookingDate ??
                                                      "0")),
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
                                                  ?.bookingSlots
                                                  ?.isNotEmpty ??
                                                  false
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
                                                      .format(
                                                      dateTime);
                                                } catch (e) {
                                                  return controller
                                                      .bookingResponseModel
                                                      .value
                                                      .data
                                                      ?.bookingSlots ??
                                                      "";
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
                                    padVertical(15),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Label(
                                          txt: "Booking Amount",
                                          type: TextTypes.f_14_600,
                                          forceColor: AppColors.grey,
                                        ),
                                        Label(
                                          txt:
                                          "₹ ${((controller.bookingResponseModel.value.data?.expectedPayment ?? 0) / 4)?.toStringAsFixed(1)}",
                                          type: TextTypes.f_18_600,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              padVertical(5),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8),
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
                                          type: TextTypes.f_14_600,
                                          forceColor: AppColors.grey,
                                        ),
                                        Label(
                                          txt:
                                          "${controller.bookingResponseModel.value.data?.askToJoin == true ? "Open Match" : "Private Match"}",
                                          type: TextTypes.f_14_600,
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Label(
                                          txt: "Court Booked",
                                          type: TextTypes.f_14_600,
                                          forceColor: AppColors.grey,
                                        ),
                                        Label(
                                          txt: "Yes",
                                          type: TextTypes.f_14_600,
                                        ),
                                      ],
                                    ).marginSymmetric(vertical: 10),
                                  ],
                                ),
                              ),
                              padVertical(5),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: 8),
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
                                          type: TextTypes.f_14_600,
                                          forceColor: AppColors.grey,
                                        ),
                                        Label(
                                          txt:
                                          "${controller.bookingResponseModel.value.data?.isCompetitive == true ? "Competitive Match" : "Friendly Match"}",
                                          type: TextTypes.f_14_600,
                                        ),
                                      ],
                                    ),
                                    Center(
                                      child: Label(
                                        txt:
                                        "The result of this match will contribute towards your level.",
                                        type: TextTypes.f_10_400,
                                      ).marginSymmetric(vertical: 10),
                                    ),
                                  ],
                                ),
                              ),
                              padVertical(5),
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                  color: AppColors.lightGrey,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Label(
                                      txt: "Players",
                                      type: TextTypes.f_14_600,
                                      forceColor: AppColors.grey,
                                    ),
                                    SizedBox(
                                      height: 80,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          // Team 1
                                          Expanded(
                                            child: Obx(() {
                                              final team1 = controller.bookingResponseModel.value.data?.team1 ?? [];
                                              return Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  // Wrap ListView.builder in Flexible to provide FlexParentData
                                                  Flexible(
                                                    child: team1.isEmpty
                                                        ? const Center(child: Label(txt: "No Team 1 Players", type: TextTypes.f_12_500))
                                                        : ListView.builder(
                                                      shrinkWrap: true,
                                                      scrollDirection: Axis.horizontal,
                                                      itemCount: team1.length,
                                                      itemBuilder: (context, index) {
                                                        final player = team1[index];
                                                        final playerData = player.playerData;
                                                        return Column(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: playerData?.sId != null
                                                                  ? () {
                                                                Get.toNamed('/userprofiledetail', arguments: {"id": playerData!.sId,"isAdmin":false});
                                                              }
                                                                  : null,
                                                              child: Stack(
                                                                clipBehavior: Clip.none,
                                                                children: [
                                                                  // Circular image or placeholder
                                                                  playerData?.image == null || playerData!.image?.isEmpty==true
                                                                      ? Container(
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
                                                                  )
                                                                      : ClipRRect(
                                                                    borderRadius: BorderRadius.circular(50),
                                                                    child: Image.network(
                                                                      "$imageBaseUrl${playerData!.image}",
                                                                      fit: BoxFit.cover,
                                                                      height: 50,
                                                                      width: 50,
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
                                                                    ),
                                                                  ),
                                                                  // Blue container overlay
                                                                  Positioned(
                                                                    bottom: -4,
                                                                    right: 7,
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
                                                            ).marginOnly(right: 10),
                                                            Container(
                                                              child: Label(
                                                                txt: playerData?.name ?? "Unknown",
                                                                type: TextTypes.f_8_400,
                                                                forceColor: Colors.black,
                                                              ),
                                                            ).marginOnly(top: 10),
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  // Show "add" button if team1 has fewer than 2 players
                                                  if (team1.length < 2)
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 10),
                                                      child: Column(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              controller.team2select.value = false;
                                                              controller.team1select.value = !controller.team1select.value;
                                                            },
                                                            child: Container(
                                                              height: 50,
                                                              width: 50,
                                                              padding: const EdgeInsets.all(10),
                                                              decoration: BoxDecoration(
                                                                color: AppColors.addbtn,
                                                                borderRadius: BorderRadius.circular(30),
                                                              ),
                                                              child: Center(
                                                                child: controller.team1select.value
                                                                    ? Label(
                                                                  txt: "pending",
                                                                  type: TextTypes.f_8_400,
                                                                  forceColor: AppColors.primaryColor,
                                                                )
                                                                    : const Icon(Icons.add),
                                                              ),
                                                            ),
                                                          ),
                                                          const Label(txt: "", type: TextTypes.f_8_400),
                                                        ],
                                                      ),
                                                    ),
                                                ],
                                              );
                                            }),
                                          ),
                                          // Divider
                                          Container(
                                            width: 1,
                                            height: 80,
                                            color: AppColors.whiteColor,
                                          ),
                                          // Team 2
                                          Expanded(
                                            child: Obx(() {
                                              final team2 = controller.bookingResponseModel.value.data?.team2 ?? [];
                                              return Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  // Wrap ListView.builder in Flexible to provide FlexParentData
                                                  Flexible(
                                                    child: team2.isEmpty
                                                        ?SizedBox()
                                                        : ListView.builder(
                                                      shrinkWrap: true,
                                                      scrollDirection: Axis.horizontal,
                                                      itemCount: team2.length,
                                                      itemBuilder: (context, index) {
                                                        final player = team2[index];
                                                        final playerData = player.playerData;
                                                        return Column(
                                                          children: [
                                                            GestureDetector(
                                                              onTap: playerData?.sId != null
                                                                  ? () {
                                                                Get.toNamed('/userprofiledetail', arguments: {"id": playerData!.sId,"isAdmin":false});
                                                              }
                                                                  : null,
                                                              child: Stack(
                                                                clipBehavior: Clip.none,
                                                                children: [
                                                                  // Circular image or placeholder
                                                                  playerData?.image == null || playerData!.image?.isEmpty==true
                                                                      ? Container(
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
                                                                  )
                                                                      : ClipRRect(
                                                                    borderRadius: BorderRadius.circular(50),
                                                                    child: Image.network(
                                                                      "$imageBaseUrl${playerData!.image}",
                                                                      fit: BoxFit.cover,
                                                                      height: 50,
                                                                      width: 50,
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
                                                                    ),
                                                                  ),
                                                                  // Blue container overlay
                                                                  Positioned(
                                                                    bottom: -4,
                                                                    right: 7,
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
                                                            ).marginOnly(right: 10),
                                                            Container(
                                                              child: Label(
                                                                txt: playerData?.name ?? "Unknown",
                                                                type: TextTypes.f_8_400,
                                                                forceColor: Colors.black,
                                                              ),
                                                            ).marginOnly(top: 10),
                                                          ],
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                  // Show "add" button if team2 has fewer than 2 players
                                                  if (team2.length < 2)
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 10),
                                                      child: Column(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              controller.team1select.value = false;
                                                              controller.team2select.value = !controller.team2select.value;
                                                            },
                                                            child: Container(
                                                              height: 50,
                                                              width: 50,
                                                              padding: const EdgeInsets.all(10),
                                                              decoration: BoxDecoration(
                                                                color: AppColors.addbtn,
                                                                borderRadius: BorderRadius.circular(30),
                                                              ),
                                                              child: Center(
                                                                child: controller.team2select.value
                                                                    ? Label(
                                                                  txt: "pending",
                                                                  type: TextTypes.f_8_400,
                                                                  forceColor: AppColors.primaryColor,
                                                                )
                                                                    : const Icon(Icons.add),
                                                              ),
                                                            ),
                                                          ),
                                                          const Label(txt: "", type: TextTypes.f_8_400),
                                                        ],
                                                      ),
                                                    ),
                                                ],
                                              );
                                            }),
                                          ),
                                        ],
                                      ),
                                    ).marginSymmetric(vertical: 20),
                                  ],
                                ),
                              ),
                              // Container(
                              //   margin: const EdgeInsets.symmetric(
                              //       vertical: 8),
                              //   padding: const EdgeInsets.all(15),
                              //   decoration: BoxDecoration(
                              //     color: AppColors.lightGrey,
                              //     borderRadius: BorderRadius.circular(10),
                              //   ),
                              //   child: Column(
                              //     crossAxisAlignment:
                              //     CrossAxisAlignment.start,
                              //     mainAxisAlignment:
                              //     MainAxisAlignment.start,
                              //     children: [
                              //       Label(
                              //         txt: "Players",
                              //         type: TextTypes.f_14_600,
                              //         forceColor: AppColors.grey,
                              //       ),
                              //       SizedBox(
                              //         height: 80,
                              //         child: Row(
                              //           mainAxisAlignment:
                              //           MainAxisAlignment.start,
                              //           crossAxisAlignment:
                              //           CrossAxisAlignment.start,
                              //           children: [
                              //             // Team 1
                              //             Expanded(
                              //               child: Row(
                              //                 mainAxisAlignment:
                              //                 MainAxisAlignment.start,
                              //                 children: [
                              //                   // Display Team 1 players
                              //                   ListView.builder(
                              //                     shrinkWrap: true,
                              //                     scrollDirection:
                              //                     Axis.horizontal,
                              //                     itemCount: controller
                              //                         .bookingResponseModel
                              //                         ?.value
                              //                         .data
                              //                         ?.team1
                              //                         ?.length ??
                              //                         0,
                              //                     itemBuilder:
                              //                         (context, index) {
                              //                       final player = controller
                              //                           .bookingResponseModel
                              //                           ?.value
                              //                           .data
                              //                           ?.team1?[index];
                              //                       return Column(
                              //                         children: [
                              //                           Stack(
                              //                             clipBehavior:
                              //                             Clip.none,
                              //                             children: [
                              //                               // Circular image or placeholder
                              //                               player?.playerData
                              //                                   ?.image ==
                              //                                   null
                              //                                   ?  GestureDetector(
                              //                                 onTap: (){
                              //                                   Get.toNamed('/userprofiledetail',
                              //                                       arguments: {"id": player?.playerData?.sId ?? ""});
                              //                                 },
                              //                                     child: Container(
                              //                                                                                               height: 50,
                              //                                                                                               width: 50,
                              //                                                                                               decoration:
                              //                                                                                               BoxDecoration(
                              //                                     borderRadius:
                              //                                     BorderRadius.circular(
                              //                                         50),
                              //                                     color: AppColors
                              //                                         .lightGrey,
                              //                                     border: Border.all(
                              //                                         color: AppColors
                              //                                             .primaryColor),
                              //                                                                                               ),
                              //                                                                                               child: Icon(
                              //                                     Icons
                              //                                         .person,
                              //                                     size:
                              //                                     40.sp,
                              //                                     color: AppColors
                              //                                         .grey,
                              //                                                                                               ),
                              //                                                                                             ),
                              //                                   )
                              //                                   :  GestureDetector(
                              //                                 onTap: (){
                              //                                   Get.toNamed('/userprofiledetail',
                              //                                       arguments: {"id": player?.playerData?.sId ?? ""});
                              //                                 },
                              //                                     child: ClipRRect(
                              //                                                                                               borderRadius:
                              //                                                                                               BorderRadius
                              //                                       .circular(50),
                              //                                                                                               child: Image
                              //                                       .network(
                              //                                     "${imageBaseUrl}${player?.playerData?.image??""}",
                              //                                     fit: BoxFit
                              //                                         .cover,
                              //                                     errorBuilder: (context,
                              //                                         error,
                              //                                         stackTrace) {
                              //                                       return Container(
                              //                                         height:
                              //                                         50,
                              //                                         width:
                              //                                         50,
                              //                                         decoration:
                              //                                         BoxDecoration(
                              //                                           borderRadius: BorderRadius.circular(50),
                              //                                           color: AppColors.lightGrey,
                              //                                           border: Border.all(color: AppColors.primaryColor),
                              //                                         ),
                              //                                         child:
                              //                                         Icon(
                              //                                           Icons.person,
                              //                                           size: 30.sp,
                              //                                           color: AppColors.grey,
                              //                                         ),
                              //                                       );
                              //                                     },
                              //                                     height: 50,
                              //                                     width: 50,
                              //                                                                                               ),
                              //                                                                                             ),
                              //                                   ),
                              //                               // Blue container overlay at the bottom
                              //                               Positioned(
                              //                                 bottom: -4,
                              //                                 right: 7,
                              //                                 child:
                              //                                 Container(
                              //                                   decoration:
                              //                                   BoxDecoration(
                              //                                     borderRadius:
                              //                                     BorderRadius
                              //                                         .circular(
                              //                                         4),
                              //                                     color: AppColors
                              //                                         .primaryColor,
                              //                                     border: Border
                              //                                         .all(
                              //                                         color:
                              //                                         Colors.white),
                              //                                   ),
                              //                                   height: 12,
                              //                                   width: 35,
                              //                                 ),
                              //                               ),
                              //                             ],
                              //                           ).marginOnly(
                              //                               right: 10),
                              //                           Container(child: Label(txt: player?.playerData?.name??"hello"??"", type:TextTypes.f_8_400,forceColor: Colors.black,)).marginOnly(top: 10)
                              //                         ],
                              //                       );
                              //                     },
                              //                   ),
                              //                   // Show "add" button if team1 has fewer than 2 players
                              //                   if ((controller
                              //                       .bookingResponseModel
                              //                       ?.value
                              //                       .data
                              //                       ?.team1
                              //                       ?.length ??
                              //                       0) <
                              //                       2)
                              //                     Obx(
                              //                           () => Column(
                              //                             children: [
                              //                               GestureDetector(
                              //                                                                                     onTap: () {
                              //                               controller
                              //                                   .team2select
                              //                                   .value = false;
                              //                               controller
                              //                                   .team1select
                              //                                   .value = !controller
                              //                                   .team1select
                              //                                   .value;
                              //                                                                                     },
                              //                                                                                     child: controller
                              //                                 .team1select
                              //                                 .value
                              //                                 ? Container(
                              //                               height: 50,
                              //                               width: 50,
                              //                               padding:
                              //                               const EdgeInsets
                              //                                   .all(
                              //                                   10),
                              //                               decoration:
                              //                               BoxDecoration(
                              //                                 color: AppColors
                              //                                     .addbtn,
                              //                                 borderRadius:
                              //                                 BorderRadius
                              //                                     .circular(
                              //                                     30),
                              //                               ),
                              //                               child:
                              //                               Center(
                              //                                 child: Label(
                              //                                   txt:
                              //                                   "pending",
                              //                                   type: TextTypes
                              //                                       .f_8_400,
                              //                                   forceColor:
                              //                                   AppColors.primaryColor,
                              //                                 ),
                              //                               ),
                              //                                                                                     )
                              //                                 : Container(
                              //                               height: 50,
                              //                               width: 50,
                              //                               padding:
                              //                               const EdgeInsets
                              //                                   .all(
                              //                                   10),
                              //                               decoration:
                              //                               BoxDecoration(
                              //                                 color: AppColors
                              //                                     .addbtn,
                              //                                 borderRadius:
                              //                                 BorderRadius
                              //                                     .circular(
                              //                                     30),
                              //                               ),
                              //                               child: Icon(
                              //                                   Icons
                              //                                       .add),
                              //                                                                                     ),
                              //                                                                                   ),
                              //                               Label(txt: "", type: TextTypes.f_8_400),
                              //                             ],
                              //                           ),
                              //                     ),
                              //                 ],
                              //               ),
                              //             ).marginSymmetric(
                              //                 horizontal: 10),
                              //             // Divider
                              //             Container(
                              //               width: 1,
                              //               height: 80,
                              //               color: AppColors.whiteColor,
                              //             ),
                              //             // Team 2
                              //             Expanded(
                              //               child: Row(
                              //                 mainAxisAlignment:
                              //                 MainAxisAlignment.start,
                              //                 children: [
                              //                   // Display Team 2 players
                              //                   ListView.builder(
                              //                     shrinkWrap: true,
                              //                     scrollDirection:
                              //                     Axis.horizontal,
                              //                     itemCount: controller
                              //                         .bookingResponseModel
                              //                         ?.value
                              //                         .data
                              //                         ?.team2
                              //                         ?.length ??
                              //                         0,
                              //                     itemBuilder:
                              //                         (context, index) {
                              //                       final player = controller
                              //                           .bookingResponseModel
                              //                           ?.value
                              //                           .data
                              //                           ?.team2?[index];
                              //                       return Column(
                              //                         children: [
                              //                           Stack(
                              //                             clipBehavior:
                              //                             Clip.none,
                              //                             children: [
                              //                               // Circular image or placeholder
                              //                               player?.playerData
                              //                                   ?.image ==
                              //                                   null
                              //                                   ? GestureDetector(
                              //                                 onTap: (){
                              //                                   Get.toNamed('/userprofiledetail',
                              //                                       arguments: {"id": player?.playerData?.sId ?? ""});
                              //                                 },
                              //                                     child: Container(
                              //                                                                                                   height: 50,
                              //                                                                                                   width: 50,
                              //                                                                                                   decoration:
                              //                                                                                                   BoxDecoration(
                              //                                     borderRadius:
                              //                                     BorderRadius.circular(
                              //                                         50),
                              //                                     color: AppColors
                              //                                         .lightGrey,
                              //                                     border: Border.all(
                              //                                         color: AppColors
                              //                                             .primaryColor),
                              //                                                                                                   ),
                              //                                                                                                   child: Icon(
                              //                                     Icons
                              //                                         .person,
                              //                                     size:
                              //                                     40.sp,
                              //                                     color: AppColors
                              //                                         .grey,
                              //                                                                                                   ),
                              //                                                                                                 ),
                              //                                   )
                              //                                   : GestureDetector(
                              //                                 onTap: (){
                              //                                   Get.toNamed('/userprofiledetail',
                              //                                       arguments: {"id": player?.playerData?.sId ?? ""});
                              //                                 },
                              //                                     child: ClipRRect(
                              //                                                                                                   borderRadius:
                              //                                                                                                   BorderRadius
                              //                                       .circular(50),
                              //                                                                                                   child: Image
                              //                                       .network(
                              //                                     "${imageBaseUrl}${player?.playerData?.image??""}",
                              //                                     fit: BoxFit
                              //                                         .cover,
                              //                                     errorBuilder: (context,
                              //                                         error,
                              //                                         stackTrace) {
                              //                                       return Container(
                              //                                         height:
                              //                                         50,
                              //                                         width:
                              //                                         50,
                              //                                         decoration:
                              //                                         BoxDecoration(
                              //                                           borderRadius: BorderRadius.circular(50),
                              //                                           color: AppColors.lightGrey,
                              //                                           border: Border.all(color: AppColors.primaryColor),
                              //                                         ),
                              //                                         child:
                              //                                         Icon(
                              //                                           Icons.person,
                              //                                           size: 30.sp,
                              //                                           color: AppColors.grey,
                              //                                         ),
                              //                                       );
                              //                                     },
                              //                                     height: 50,
                              //                                     width: 50,
                              //                                                                                                   ),
                              //                                                                                                 ),
                              //                                   ),
                              //                               // Blue container overlay at the bottom
                              //                               Positioned(
                              //                                 bottom: -4,
                              //                                 right: 7,
                              //                                 child:
                              //                                 Container(
                              //                                   decoration:
                              //                                   BoxDecoration(
                              //                                     borderRadius:
                              //                                     BorderRadius
                              //                                         .circular(
                              //                                         4),
                              //                                     color: AppColors
                              //                                         .primaryColor,
                              //                                     border: Border
                              //                                         .all(
                              //                                         color:
                              //                                         Colors.white),
                              //                                   ),
                              //                                   height: 12,
                              //                                   width: 35,
                              //                                 ),
                              //                               ),
                              //                             ],
                              //                           ).marginOnly(
                              //                               right: 10),
                              //                           Container(child: Label(txt: player?.playerData?.name??"", type:TextTypes.f_8_400,forceColor: Colors.black,)).marginOnly(top: 10)
                              //
                              //                         ],
                              //                       );
                              //                     },
                              //                   ),
                              //                   // Show "add" button if team2 has fewer than 2 players
                              //                   if ((controller
                              //                       .bookingResponseModel
                              //                       ?.value
                              //                       .data
                              //                       ?.team2
                              //                       ?.length ??
                              //                       0) <
                              //                       2)
                              //                     Obx(() => Column(
                              //                             children: [
                              //                               SizedBox(
                              //                                 child: GestureDetector(
                              //                                                                                       onTap: () {
                              //                                 controller
                              //                                     .team1select
                              //                                     .value = false;
                              //                                 controller
                              //                                     .team2select
                              //                                     .value = !controller
                              //                                     .team2select
                              //                                     .value;
                              //                                                                                       },
                              //                                                                                       child: controller
                              //                                   .team2select
                              //                                   .value
                              //                                   ? Container(
                              //                                 height: 50,
                              //                                 width: 50,
                              //                                 padding:
                              //                                 const EdgeInsets
                              //                                     .all(
                              //                                     10),
                              //                                 decoration:
                              //                                 BoxDecoration(
                              //                                   color: AppColors
                              //                                       .addbtn,
                              //                                   borderRadius:
                              //                                   BorderRadius
                              //                                       .circular(
                              //                                       30),
                              //                                 ),
                              //                                 child:
                              //                                 Center(
                              //                                   child: Label(
                              //                                     txt:
                              //                                     "pending",
                              //                                     type: TextTypes
                              //                                         .f_8_400,
                              //                                     forceColor:
                              //                                     AppColors.primaryColor,
                              //                                   ),
                              //                                 ),
                              //                                                                                       )
                              //                                   : Container(
                              //                                 height: 50,
                              //                                 width: 50,
                              //                                 padding:
                              //                                 const EdgeInsets
                              //                                     .all(
                              //                                     10),
                              //                                 decoration:
                              //                                 BoxDecoration(
                              //                                   color: AppColors
                              //                                       .addbtn,
                              //                                   borderRadius:
                              //                                   BorderRadius
                              //                                       .circular(
                              //                                       30),
                              //                                 ),
                              //                                 child: Icon(
                              //                                     Icons
                              //                                         .add),
                              //                                                                                       ),
                              //                                                                                     ),
                              //                               ),
                              //                               Label(txt: "", type: TextTypes.f_8_400),
                              //                             ],
                              //                           ),
                              //                     ),
                              //                 ],
                              //               ),
                              //             ).marginSymmetric(
                              //                 horizontal: 10),
                              //           ],
                              //         ),
                              //       ).marginSymmetric(vertical: 20),
                              //     ],
                              //   ),
                              // ),
                              SizedBox(
                                width: double.infinity,
                                child: commonButton(
                                  txt: "Book Now",
                                  onPressed: () {
                                    Get.closeAllSnackbars();
                                    if (!controller.team1select.value &&
                                        !controller.team2select.value) {
                                      Get.snackbar(
                                          "Error",
                                          "Please select a team to play",
                                          snackPosition:
                                          SnackPosition.TOP);
                                    } else {
                                      Get.offNamed("/joinGamePayment",
                                          arguments: {
                                            "responseModel": controller
                                                .bookingResponseModel,
                                            "player": controller
                                                .team1select.value
                                                ? "player2"
                                                : controller.bookingResponseModel.value.data?.team2?.length==0?"player3":controller.bookingResponseModel.value.data?.team2?[0]?.playerType=="player3"&&controller
                                                .team2select.value==true?"player4":"player3",
                                          });
                                    }
                                  },
                                ),
                              ).marginOnly(bottom: 30, top: 20),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ));
              },
            ),
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