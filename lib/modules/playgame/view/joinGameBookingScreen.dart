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
import '../controller/Join_Game_Booking_Controller.dart';



class PgJoinConfirmpayment extends GetView<JoinConfirmPaymentController> {
  const PgJoinConfirmpayment({super.key});

  @override
  Widget build(BuildContext context) {

    String getPaymentText(controller) {
      final paymentMethod = controller.PaymentMethod.value;
      final hourlyRate = int.parse(controller.bookingResponseModel?.value.data?.expectedPayment.toStringAsFixed(0) ?? "0")/4;
      final playCoins = controller.responseModel.value.data?.playCoins ?? 0;
      final isPayBooking = controller.PayBooking.value;

      // if (paymentMethod == "Play Coins") {
      //
      //   if(isPayBooking==true) {
      //     controller.PaymentMethod.value="Play Coins";
      //     return "${(hourlyRate / 2).toStringAsFixed(0)} Coins";
      //   }else{
      //     controller.PaymentMethod.value="Play Coins";
      //     return "$hourlyRate Coins";
      //   }
      // }
      if (paymentMethod == "Play Coins") {
        if(isPayBooking==true) {
          // controller.PaymentMethod.value="Play Coins";
          return "${(hourlyRate / 2).toStringAsFixed(1)} Coins";
        }else{
          // controller.PaymentMethod.value="Play Coins";
          return "${hourlyRate.toStringAsFixed(1)} Coins";
        }
      }else if(paymentMethod == "Razor Pay"){
        if(isPayBooking==true) {
          // controller.PaymentMethod.value="Razor Pay";
          return "₹ ${(hourlyRate / 2).toStringAsFixed(1)}";
        }else{
          // controller.PaymentMethod.value="Razor Pay";
          return "₹ ${hourlyRate.toStringAsFixed(1)}";
        }
      }else{
        if(isPayBooking==true) {
          if(playCoins>(hourlyRate/2)){
            // controller.PaymentMethod.value="Play Coins";
            return "${hourlyRate/2} Coins";
          }else{
            // controller.PaymentMethod.value="Both";
            return "₹ ${((hourlyRate / 2)-playCoins).toStringAsFixed(1)}";
          }

        }else{
          if(playCoins>(hourlyRate)){
            return "${hourlyRate.toStringAsFixed(1)} Coins";
          }else{
            return "₹ ${((hourlyRate)-playCoins).toStringAsFixed(1)}";
          }
        }


      }









    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            Obx(() => controller.loading.value
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
                              padHorizontal(10),
                              const Label(
                                txt: "Booking",
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
                                // const Label(
                                //   txt: "Booking Summary",
                                //   type: TextTypes.f_14_700,
                                // ),
                                // padVertical(5),
                                // const Divider(),
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
                                                  ""; // Fallback to original string
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

                                // Row(
                                //   mainAxisAlignment:
                                //   MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     Label(
                                //       txt: "Booking Amount",
                                //       type: TextTypes.f_14_600,
                                //       forceColor: AppColors.grey,
                                //     ),
                                //     Label(
                                //       txt:
                                //       "₹ ${((controller.bookingResponseModel.value.data?.expectedPayment??0)/4)?.toStringAsFixed(0)}",
                                //       type: TextTypes.f_18_600,
                                //     ),
                                //   ],
                                // ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: AppColors.lightGrey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Label(
                                      txt: "Add Equipment",
                                      type: TextTypes.f_14_700,
                                    ),
                                    Icon(
                                      Icons.info_outline,
                                      size: 17,
                                    ),
                                  ],
                                ),
                                padVertical(5),
                                const Divider(),
                                Container(
                                  width: double.infinity,
                                  margin:
                                  const EdgeInsets.symmetric(vertical: 8),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 5),
                                  decoration: BoxDecoration(
                                    color: AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Obx(
                                        () => Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              controller.selectedButton2.value =
                                              0;
                                            },
                                            child: Container(
                                              padding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 12),
                                              decoration: BoxDecoration(
                                                color: controller
                                                    .selectedButton2
                                                    .value ==
                                                    0
                                                    ? AppColors.blue2
                                                    : Colors.white,
                                                borderRadius:
                                                BorderRadius.circular(5),
                                                boxShadow: controller
                                                    .selectedButton2
                                                    .value ==
                                                    0
                                                    ? [
                                                  const BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 2,
                                                  ),
                                                ]
                                                    : null,
                                              ),
                                              child: Center(
                                                child: Label(
                                                  txt: "Rent",
                                                  forceColor: controller
                                                      .selectedButton2
                                                      .value ==
                                                      0
                                                      ? AppColors.whiteColor
                                                      : AppColors.grey,
                                                  type: TextTypes.f_12_500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: () {
                                              controller.selectedButton2.value =
                                              1;
                                            },
                                            child: Container(
                                              padding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 12),
                                              decoration: BoxDecoration(
                                                color: controller
                                                    .selectedButton2
                                                    .value ==
                                                    1
                                                    ? AppColors.blue2
                                                    : Colors.white,
                                                borderRadius:
                                                BorderRadius.circular(5),
                                                boxShadow: controller
                                                    .selectedButton2
                                                    .value ==
                                                    1
                                                    ? [
                                                  const BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 2,
                                                  ),
                                                ]
                                                    : null,
                                              ),
                                              child: Center(
                                                child: Label(
                                                  txt: "No, I’ll bring my own",
                                                  forceColor: controller
                                                      .selectedButton2
                                                      .value ==
                                                      1
                                                      ? AppColors.whiteColor
                                                      : AppColors.grey,
                                                  type: TextTypes.f_12_500,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                padVertical(6),
                                Obx(() => controller.selectedButton2.value == 0
                                    ? Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Obx(() => GestureDetector(
                                              onTap: () {
                                                controller
                                                    .selectedRacketA
                                                    .value =
                                                !controller
                                                    .selectedRacketA
                                                    .value;
                                              },
                                              child: controller
                                                  .selectedRacketA
                                                  .value ==
                                                  true
                                                  ? Icon(
                                                Icons
                                                    .check_box_outlined,
                                                color: AppColors
                                                    .grey,
                                                size: 17,
                                              )
                                                  : Icon(
                                                Icons
                                                    .check_box_outline_blank_outlined,
                                                color: AppColors
                                                    .grey,
                                                size: 17,
                                              ),
                                            )),
                                            padHorizontal(5),
                                            const Label(
                                              txt: "Rackets",
                                              type: TextTypes.f_14_500,
                                              forceColor: AppColors.grey,
                                            ),
                                          ],
                                        ).marginOnly(top: 10),
                                        padHorizontal(20),
                                        Obx(() => controller
                                            .selectedRacketA.value
                                            ? CartButtonInt(
                                          count: controller.RacketA
                                              .value, // Bind to RacketA
                                          size:
                                          25, // Adjust button size
                                          style: CartButtonStyle(
                                            foregroundColor:
                                            Colors.black87,
                                            activeForegroundColor:
                                            Colors.black87,
                                            activeBackgroundColor:
                                            Colors.white,
                                            radius: const Radius
                                                .circular(8),
                                            border: Border.all(
                                                color: Colors.grey),
                                            elevation: 0,
                                            buttonAspectRatio: 1.5,
                                          ),
                                          onChanged: (count) {
                                            controller
                                                .RacketA.value =
                                                count; // Update RacketA when count changes
                                          },
                                          // : Obx(() => Label(
                                          //   txt: controller.RacketA.value.toString(),
                                          //   type: TextTypes.f_16_600,
                                          // )), // Custom display of count
                                        ).marginSymmetric(
                                            vertical: 20)
                                            : SizedBox()),

                                      ],
                                    ),
                                  ],
                                )
                                    : SizedBox()),
                                // Obx(() => controller.selectedButton2.value == 0
                                //     ? Column(
                                //   children: [
                                //     Row(
                                //       mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //       children: [
                                //         Row(
                                //           children: [
                                //             Obx(() => GestureDetector(
                                //               onTap: () {
                                //                 controller
                                //                     .selectedRacketB
                                //                     .value =
                                //                 !controller
                                //                     .selectedRacketB
                                //                     .value;
                                //               },
                                //               child: controller
                                //                   .selectedRacketB
                                //                   .value ==
                                //                   true
                                //                   ? Icon(
                                //                 Icons
                                //                     .check_box_outlined,
                                //                 color: AppColors
                                //                     .grey,
                                //                 size: 17,
                                //               )
                                //                   : Icon(
                                //                 Icons
                                //                     .check_box_outline_blank_outlined,
                                //                 color: AppColors
                                //                     .grey,
                                //                 size: 17,
                                //               ),
                                //             )),
                                //             padHorizontal(5),
                                //             const Label(
                                //               txt: "Racket B",
                                //               type: TextTypes.f_14_500,
                                //               forceColor: AppColors.grey,
                                //             ),
                                //           ],
                                //         ),
                                //         padHorizontal(20),
                                //         Obx(() => controller
                                //             .selectedRacketB.value
                                //             ? CartButtonInt(
                                //           count: controller.RacketB
                                //               .value, // Bind to RacketA
                                //           size:
                                //           25, // Adjust button size
                                //           style: CartButtonStyle(
                                //             foregroundColor:
                                //             Colors.black87,
                                //             activeForegroundColor:
                                //             Colors.black87,
                                //             activeBackgroundColor:
                                //             Colors.white,
                                //             radius: const Radius
                                //                 .circular(8),
                                //             border: Border.all(
                                //                 color: Colors.grey),
                                //             elevation: 0,
                                //             buttonAspectRatio: 1.5,
                                //           ),
                                //           onChanged: (count) {
                                //             controller
                                //                 .RacketB.value =
                                //                 count; // Update RacketA when count changes
                                //           },
                                //           // : Obx(() => Label(
                                //           //   txt: controller.RacketA.value.toString(),
                                //           //   type: TextTypes.f_16_600,
                                //           // )), // Custom display of count
                                //         )
                                //             : SizedBox()),
                                //
                                //
                                //
                                //
                                //       ],
                                //     ),
                                //   ],
                                // )
                                //     : SizedBox()),
                                // Obx(() => controller.selectedButton2.value == 0
                                //     ? Column(
                                //   children: [
                                //     Row(
                                //       mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //       children: [
                                //         Row(
                                //           children: [
                                //             Obx(() => GestureDetector(
                                //               onTap: () {
                                //                 controller
                                //                     .selectedRacketC
                                //                     .value =
                                //                 !controller
                                //                     .selectedRacketC
                                //                     .value;
                                //               },
                                //               child: controller
                                //                   .selectedRacketC
                                //                   .value ==
                                //                   true
                                //                   ? Icon(
                                //                 Icons
                                //                     .check_box_outlined,
                                //                 color: AppColors
                                //                     .grey,
                                //                 size: 17,
                                //               )
                                //                   : Icon(
                                //                 Icons
                                //                     .check_box_outline_blank_outlined,
                                //                 color: AppColors
                                //                     .grey,
                                //                 size: 17,
                                //               ),
                                //             )),
                                //             padHorizontal(5),
                                //             const Label(
                                //               txt: "Racket C",
                                //               type: TextTypes.f_14_500,
                                //               forceColor: AppColors.grey,
                                //             ),
                                //           ],
                                //         ).marginSymmetric(vertical: 20),
                                //         padHorizontal(20),
                                //         Obx(() => controller
                                //             .selectedRacketC.value
                                //             ? CartButtonInt(
                                //           count: controller.RacketC
                                //               .value, // Bind to RacketA
                                //           size:
                                //           25, // Adjust button size
                                //           style: CartButtonStyle(
                                //             foregroundColor:
                                //             Colors.black87,
                                //             activeForegroundColor:
                                //             Colors.black87,
                                //             activeBackgroundColor:
                                //             Colors.white,
                                //             radius: const Radius
                                //                 .circular(8),
                                //             border: Border.all(
                                //                 color: Colors.grey),
                                //             elevation: 0,
                                //             buttonAspectRatio: 1.5,
                                //           ),
                                //           onChanged: (count) {
                                //             controller
                                //                 .RacketC.value =
                                //                 count; // Update RacketA when count changes
                                //           },
                                //           // : Obx(() => Label(
                                //           //   txt: controller.RacketA.value.toString(),
                                //           //   type: TextTypes.f_16_600,
                                //           // )), // Custom display of count
                                //         ).marginSymmetric(
                                //             vertical: 20)
                                //             : SizedBox()),
                                //
                                //       ],
                                //     ),
                                //   ],
                                // )
                                //     : SizedBox()),
                                // Obx(() => controller.selectedButton2.value == 0
                                //     ? Column(
                                //   children: [
                                //     Row(
                                //       mainAxisAlignment:
                                //       MainAxisAlignment.spaceBetween,
                                //       children: [
                                //         Row(
                                //           children: [
                                //             Obx(() => GestureDetector(
                                //               onTap: () {
                                //                 controller
                                //                     .selectedRacketD
                                //                     .value =
                                //                 !controller
                                //                     .selectedRacketD
                                //                     .value;
                                //               },
                                //               child: controller
                                //                   .selectedRacketD
                                //                   .value ==
                                //                   true
                                //                   ? Icon(
                                //                 Icons
                                //                     .check_box_outlined,
                                //                 color: AppColors
                                //                     .grey,
                                //                 size: 17,
                                //               )
                                //                   : Icon(
                                //                 Icons
                                //                     .check_box_outline_blank_outlined,
                                //                 color: AppColors
                                //                     .grey,
                                //                 size: 17,
                                //               ),
                                //             )),
                                //             padHorizontal(5),
                                //             const Label(
                                //               txt: "Racket D",
                                //               type: TextTypes.f_14_500,
                                //               forceColor: AppColors.grey,
                                //             ),
                                //           ],
                                //         ),
                                //         padHorizontal(20),
                                //         Obx(() => controller
                                //             .selectedRacketD.value
                                //             ? CartButtonInt(
                                //           count: controller.RacketD
                                //               .value, // Bind to RacketA
                                //           size:
                                //           25, // Adjust button size
                                //           style: CartButtonStyle(
                                //             foregroundColor:
                                //             Colors.black87,
                                //             activeForegroundColor:
                                //             Colors.black87,
                                //             activeBackgroundColor:
                                //             Colors.white,
                                //             radius: const Radius
                                //                 .circular(8),
                                //             border: Border.all(
                                //                 color: Colors.grey),
                                //             elevation: 0,
                                //             buttonAspectRatio: 1.5,
                                //           ),
                                //           onChanged: (count) {
                                //             controller
                                //                 .RacketD.value =
                                //                 count; // Update RacketA when count changes
                                //           },
                                //           // : Obx(() => Label(
                                //           //   txt: controller.RacketA.value.toString(),
                                //           //   type: TextTypes.f_16_600,
                                //           // )), // Custom display of count
                                //         )
                                //             : SizedBox()),
                                //
                                //
                                //
                                //
                                //       ],
                                //     ),
                                //   ],
                                // )
                                //     : SizedBox()),
                                Obx(() => controller.selectedButton2.value == 0
                                    ? Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Obx(() => GestureDetector(
                                              onTap: () {
                                                controller
                                                    .selectedBalls
                                                    .value =
                                                !controller
                                                    .selectedBalls
                                                    .value;
                                              },
                                              child: controller
                                                  .selectedBalls
                                                  .value ==
                                                  true
                                                  ? Icon(
                                                Icons
                                                    .check_box_outlined,
                                                color: AppColors
                                                    .grey,
                                                size: 17,
                                              )
                                                  : Icon(
                                                Icons
                                                    .check_box_outline_blank_outlined,
                                                color: AppColors
                                                    .grey,
                                                size: 17,
                                              ),
                                            )),
                                            padHorizontal(5),
                                            const Label(
                                              txt: "Balls",
                                              type: TextTypes.f_14_500,
                                              forceColor: AppColors.grey,
                                            ),
                                          ],
                                        ).marginSymmetric(vertical: 20),
                                        padHorizontal(20),
                                        Obx(() => controller
                                            .selectedBalls.value
                                            ? CartButtonInt(
                                          count: controller.Balls
                                              .value, // Bind to RacketA
                                          size:
                                          25, // Adjust button size
                                          style: CartButtonStyle(
                                            foregroundColor:
                                            Colors.black87,
                                            activeForegroundColor:
                                            Colors.black87,
                                            activeBackgroundColor:
                                            Colors.white,
                                            radius: const Radius
                                                .circular(8),
                                            border: Border.all(
                                                color: Colors.grey),
                                            elevation: 0,
                                            buttonAspectRatio: 1.5,
                                          ),
                                          onChanged: (count) {
                                            controller
                                                .Balls.value =
                                                count; // Update RacketA when count changes
                                          },
                                          // : Obx(() => Label(
                                          //   txt: controller.RacketA.value.toString(),
                                          //   type: TextTypes.f_16_600,
                                          // )), // Custom display of count
                                        ).marginSymmetric(vertical: 20)
                                            : SizedBox()),




                                      ],
                                    ),
                                  ],
                                )
                                    : SizedBox()),
                              ],
                            ),
                          ),

                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: AppColors.lightGrey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Label(
                                      txt: "Select Payment Method",
                                      type: TextTypes.f_14_700,
                                    ),
                                    // GestureDetector(
                                    //     onTap: () async {
                                    //       await controller.tooltipcontroller.showTooltip();
                                    //     },
                                    //     child: SuperTooltip(
                                    //         showBarrier: true,
                                    //         controller: controller.tooltipcontroller,
                                    //         content: const Text(
                                    //           "Lorem ipsum dolor sit amet, consetetur sadipscing elitr,",
                                    //           softWrap: true,
                                    //           style: TextStyle(
                                    //             color: Colors.black,
                                    //           ),
                                    //         ),
                                    //         child: Icon(
                                    //           Icons.info_outline,
                                    //           size: 17,
                                    //         ))),
                                  ],
                                ),
                                padVertical(5),
                                const Divider(),
                                Container(height: 50,decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(40)),child: Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.spaceBetween,children: [Label(
                                  txt: "Available Play Coins",
                                  type: TextTypes.f_14_600,
                                ),
                                  Obx( ()=>  Label(
                                    txt: "${controller.responseModel.value.data?.playCoins??0} Coins",
                                    type: TextTypes.f_14_400,
                                  ))


                                ],).paddingSymmetric(horizontal: 20),).marginSymmetric(vertical: 10),
                                padVertical(5),
                                GestureDetector(
                                  onTap:(){
                                    controller.PaymentMethod.value="Play Coins";
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
                                            child:controller.PaymentMethod.value=="Play Coins"? Container(
                                              padding: const EdgeInsets.all(7),
                                              decoration: BoxDecoration(
                                                color: AppColors.primaryColor,
                                                borderRadius:
                                                BorderRadius.circular(15),
                                              ),
                                            ):SizedBox(),
                                          )),
                                          padHorizontal(15),
                                          Label(
                                            txt: "Play Coins",
                                            type: TextTypes.f_14_500,
                                          ),
                                        ],
                                      ),

                                      Image.asset(
                                        AppAssets.iconCoins,
                                        fit: BoxFit.contain,
                                        height:30,
                                        width:30,

                                      )

                                      // Label(
                                      //   txt:"₹${(int.parse(controller.Hourlyrate?.value??"0")/2).toStringAsFixed(0)}",
                                      //   type: TextTypes.f_14_700,
                                      // ),
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap:(){
                                    controller.PaymentMethod.value="Razor Pay";
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
                                            child:controller.PaymentMethod.value=="Razor Pay"? Container(
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
                                            txt: "UPI/Cards",
                                            type: TextTypes.f_14_500,
                                          ),
                                        ],
                                      ),
                                      Image.asset(
                                        AppAssets.iconRazorpay,
                                        fit: BoxFit.cover,
                                        height:30,
                                        width:50,

                                      )

                                    ],
                                  ),
                                ),
                               Obx(()=> ((int.parse(controller.bookingResponseModel.value.data?.expectedPayment.toString()?? "0")/4)<(controller.responseModel.value.data?.playCoins??0))|| ((int.parse(controller.bookingResponseModel.value.data?.expectedPayment.toString()?? "0")/4)==(controller.responseModel.value.data?.playCoins??0))?SizedBox():  GestureDetector(
                                  onTap:(){
                                    controller.PaymentMethod.value="Both";
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
                                            child:controller.PaymentMethod.value=="Both"? Container(
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
                                            txt: "Both",
                                            type: TextTypes.f_14_500,
                                          ),
                                        ],
                                      ),
                                      Image.asset(
                                        AppAssets.iconBoth,
                                        fit: BoxFit.cover,
                                        height:30,
                                        width:120,

                                      )
                                    ],
                                  ),
                                ),
)
                              ],
                            ),
                          ),






                          Obx(() => Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: AppColors.lightGrey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    controller.isCancellationExpanded.value = !controller.isCancellationExpanded.value;
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Label(
                                        txt: "Cancellation Policy",
                                        type: TextTypes.f_14_700,
                                      ),
                                      Icon(
                                        controller.isCancellationExpanded.value
                                            ? Icons.keyboard_arrow_up_rounded
                                            : Icons.keyboard_arrow_down_rounded,
                                        size: 25,
                                      ),
                                    ],
                                  ),
                                ),
                                if (controller.isCancellationExpanded.value) ...[
                                  const SizedBox(height: 10),
                                  const Label(
                                    maxLines: 10,
                                    txt:
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                                    type: TextTypes.f_14_400,
                                  ),
                                ],
                              ],
                            ),
                          )),

                          padVertical(10),
                          //   final hourlyRate = int.parse(controller.Hourlyrate?.value ?? "0");
                          // final playCoins = controller.responseModel.value.data?.playCoins ?? 0;
                          SizedBox(
                              width: double.infinity,
                              child:  Obx(()=>commonButton(
                                loading: controller.isLoading.value,
                                 forceColor:((int.parse(controller.bookingResponseModel.value.data?.expectedPayment.toString()?? "0")/4)<(controller.responseModel.value.data?.playCoins??0))||controller.PaymentMethod!="Play Coins"?AppColors.primaryColor :AppColors.grey.withOpacity(0.8),
                                 txt:((int.parse(controller.bookingResponseModel?.value.data?.expectedPayment.toString()??"0")/4)<(controller.responseModel.value.data?.playCoins??0))||controller.PaymentMethod!="Play Coins"?"Pay ${getPaymentText(controller)}":"Insufficient Play Coins",

                                onPressed: () {
                                  Get.closeAllSnackbars();
                                  if(((int.parse(controller.bookingResponseModel?.value.data?.expectedPayment.toString() ?? "0")/4)<(controller.responseModel.value.data?.playCoins??0))||controller.PaymentMethod!="Play Coins"){
                                    controller.isLoading.value=true;
                                    controller.BookingApi();
                                  }



                                },
                              ),
                              ).marginOnly(bottom: 30)),
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
