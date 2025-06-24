import 'package:badminton/app_settings/components/label.dart';
import 'package:badminton/app_settings/components/widget_global_margin.dart';
import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/constants/app_dim.dart';
import 'package:badminton/app_settings/constants/common_button.dart';
import 'package:badminton/modules/creategames/controller/upload_score_controller.dart';
import 'package:cart_button/cart_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../app_settings/components/common_textfield.dart';

class UploadScoreById extends GetView<UploadScoreController> {
  const UploadScoreById({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
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
                                txt: "Upload Score",
                                type: TextTypes.f_18_600,
                              ),
                            ],
                          ),
                          padVertical(15),
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
                                const Label(
                                  txt: "Game Summary",
                                  type: TextTypes.f_14_700,
                                ),
                                padVertical(5),
                                const Divider(),
                                padVertical(5),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.asset(
                                    AppAssets.rankProfile,
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
                                              "${controller.selectedGame.value} Game",
                                          type: TextTypes.f_18_600,
                                        ),
                                        SizedBox(
                                          width: Get.width * 0.7,
                                          child: Label(
                                            maxLines: 2,
                                            txt: "${controller.address.value}",
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
                                          txt: controller.date.value != null
                                              ? controller?.date?.value.split("T").first??""
                                              : "Unknown Date",
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
                                          txt: controller?.time.value != null
                                              ?(() {
                                            try {
                                              // Parse time-only string (e.g., "21:00")
                                              final timeFormat = DateFormat('HH:mm');
                                              final parsedTime = timeFormat.parse(controller?.time.value??"");
                                              // Combine with a default date (today)
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
                                      txt: "Set 1",
                                      type: TextTypes.f_14_700,
                                    ),
                                    // GestureDetector(
                                    //     onTap: () {
                                    //       controller.showset2.value = false;
                                    //       controller.showset3.value = false;
                                    //       controller.showset1.value = true;
                                    //       controller.showset1.refresh();
                                    //       controller.showset2.refresh();
                                    //       controller.showset3.refresh();
                                    //     },
                                    //     child: Image.asset(
                                    //       "assets/icons/edit_score.png",
                                    //       height: 20,
                                    //       width: 20,
                                    //     )),
                                  ],
                                ),
                                padVertical(5),
                                const Divider(),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: Get.width *
                                          0.39, // Adjust the width as needed
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Label(
                                            txt: "Team 1",
                                            type: TextTypes.f_14_700,
                                            forceColor: Colors.grey,
                                          ).marginSymmetric(
                                              vertical: 10, horizontal: 5),
                                          commonTxtField(
                                            hTxt: "Team1",
                                            height: 45,
                                            controller: controller.SetP1,
                                            keyboardType: TextInputType.number,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.03,
                                    ),
                                    SizedBox(
                                      width: Get.width *
                                          0.39, // Adjust the width as needed
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Label(
                                            txt: "Team 2",
                                            forceColor: Colors.grey,
                                            type: TextTypes.f_14_700,
                                          ).marginSymmetric(
                                              vertical: 10, horizontal: 5),
                                          commonTxtField(
                                            height: 45,
                                            hTxt: "Team 2",
                                            controller: controller.SetP2,
                                            keyboardType: TextInputType.number,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                // Obx(() => controller.showset1.value == true
                                //     ? Row(
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.end,
                                //         children: [
                                //           GestureDetector(
                                //             onTap: () => {
                                //               controller.showset1.value = false,
                                //               controller.showset1.refresh()
                                //             },
                                //             child: Container(
                                //               padding: const EdgeInsets.all(10),
                                //               decoration: BoxDecoration(
                                //                 border: Border.all(
                                //                     color:
                                //                         AppColors.primaryColor),
                                //                 color: AppColors.whiteColor,
                                //                 borderRadius:
                                //                     BorderRadius.circular(5),
                                //               ),
                                //               child: Label(
                                //                 txt: "Cancel",
                                //                 type: TextTypes.f_10_600,
                                //                 forceColor:
                                //                     AppColors.primaryColor,
                                //               ),
                                //             ),
                                //           ).marginSymmetric(horizontal: 10),
                                //           GestureDetector(
                                //             onTap: () => {
                                //               controller.UploadScoreApi()},
                                //             child: Container(
                                //               padding: const EdgeInsets.all(10),
                                //               decoration: BoxDecoration(
                                //                 color: AppColors.blue2,
                                //                 borderRadius:
                                //                     BorderRadius.circular(5),
                                //               ),
                                //               child: Label(
                                //                 txt: "Upload",
                                //                 type: TextTypes.f_10_600,
                                //                 forceColor:
                                //                     AppColors.whiteColor,
                                //               ),
                                //             ),
                                //           ),
                                //         ],
                                //       ).marginSymmetric(vertical: 10)
                                //     : SizedBox())
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
                                      txt: "Set 2",
                                      type: TextTypes.f_14_700,
                                    ),
                                    // GestureDetector(
                                    //   onTap: (){
                                    //
                                    //     controller.showset3.value = false;
                                    //     controller.showset1.value = false;
                                    //     controller.showset1.refresh();
                                    //
                                    //     controller.showset3.refresh();
                                    //     controller.showset2.value=true;
                                    //     controller.showset2.refresh();
                                    //   },
                                    //   child: Image.asset(
                                    //     "assets/icons/edit_score.png",
                                    //     height: 20,
                                    //     width: 20,
                                    //   ),
                                    // ),
                                  ],
                                ),
                                padVertical(5),
                                const Divider(),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: Get.width *
                                          0.39, // Adjust the width as needed
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Label(
                                            txt: "Team 1",
                                            type: TextTypes.f_14_700,
                                            forceColor: Colors.grey,
                                          ).marginSymmetric(
                                              vertical: 10, horizontal: 5),
                                          commonTxtField(
                                            hTxt: "Team1",
                                            height: 45,
                                            controller: controller.SetP3,
                                            keyboardType: TextInputType.number,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.03,
                                    ),
                                    SizedBox(
                                      width: Get.width *
                                          0.39, // Adjust the width as needed
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Label(
                                            txt: "Team 2",
                                            forceColor: Colors.grey,
                                            type: TextTypes.f_14_700,
                                          ).marginSymmetric(
                                              vertical: 10, horizontal: 5),
                                          commonTxtField(
                                            height: 45,
                                            hTxt: "Team 2",
                                            controller: controller.SetP4,
                                            keyboardType: TextInputType.number,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                // Obx(() => controller.showset2.value == true
                                //     ? Row(
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.end,
                                //         children: [
                                //           GestureDetector(
                                //             onTap: (){
                                //               controller.showset2.value=false;
                                //               controller.showset2.refresh();
                                //             },
                                //             child: Container(
                                //               padding: const EdgeInsets.all(10),
                                //               decoration: BoxDecoration(
                                //                 border: Border.all(
                                //                     color:
                                //                         AppColors.primaryColor),
                                //                 color: AppColors.whiteColor,
                                //                 borderRadius:
                                //                     BorderRadius.circular(5),
                                //               ),
                                //               child: Label(
                                //                 txt: "Cancel",
                                //                 type: TextTypes.f_10_600,
                                //                 forceColor:
                                //                     AppColors.primaryColor,
                                //               ),
                                //             ),
                                //           ).marginSymmetric(horizontal: 10),
                                //           GestureDetector(
                                //             onTap: () => {controller.UploadScoreApi()},
                                //             child: Container(
                                //               padding: const EdgeInsets.all(10),
                                //               decoration: BoxDecoration(
                                //                 color: AppColors.blue2,
                                //                 borderRadius:
                                //                 BorderRadius.circular(5),
                                //               ),
                                //               child: Label(
                                //                 txt: "Upload",
                                //                 type: TextTypes.f_10_600,
                                //                 forceColor:
                                //                 AppColors.whiteColor,
                                //               ),
                                //             ),
                                //           ),
                                //         ],
                                //       ).marginSymmetric(vertical: 10)
                                //     : SizedBox())
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
                                      txt: "Set 3",
                                      type: TextTypes.f_14_700,
                                    ),
                                    // GestureDetector(
                                    //   onTap: (){
                                    //
                                    //     controller.showset1.value = false;
                                    //     controller.showset1.refresh();
                                    //
                                    //
                                    //     controller.showset2.value=false;
                                    //     controller.showset2.refresh();
                                    //     controller.showset3.value=true;
                                    //     controller.showset3.refresh();
                                    //   },
                                    //   child: Image.asset(
                                    //     "assets/icons/edit_score.png",
                                    //     height: 20,
                                    //     width: 20,
                                    //   ),
                                    // ),
                                  ],
                                ),
                                padVertical(5),
                                const Divider(),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: Get.width *
                                          0.39, // Adjust the width as needed
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Label(
                                            txt: "Team 1",
                                            type: TextTypes.f_14_700,
                                            forceColor: Colors.grey,
                                          ).marginSymmetric(
                                              vertical: 10, horizontal: 5),
                                          commonTxtField(
                                            hTxt: "Team1",
                                            height: 45,
                                            controller: controller.SetP5,
                                            keyboardType: TextInputType.number,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: Get.width * 0.03,
                                    ),
                                    SizedBox(
                                      width: Get.width *
                                          0.39, // Adjust the width as needed
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Label(
                                            txt: "Team 2",
                                            forceColor: Colors.grey,
                                            type: TextTypes.f_14_700,
                                          ).marginSymmetric(
                                              vertical: 10, horizontal: 5),
                                          commonTxtField(
                                            height: 45,
                                            hTxt: "Team 2",
                                            controller: controller.SetP6,
                                            keyboardType: TextInputType.number,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                // Obx(() => controller.showset3.value == true
                                //     ? Row(
                                //         mainAxisAlignment:
                                //             MainAxisAlignment.end,
                                //         children: [
                                //           GestureDetector(
                                //             onTap: (){
                                //               controller.showset3.value=false;
                                //               controller.showset3.refresh();
                                //             },
                                //             child: Container(
                                //               padding: const EdgeInsets.all(10),
                                //               decoration: BoxDecoration(
                                //                 border: Border.all(
                                //                     color:
                                //                         AppColors.primaryColor),
                                //                 color: AppColors.whiteColor,
                                //                 borderRadius:
                                //                     BorderRadius.circular(5),
                                //               ),
                                //               child: Label(
                                //                 txt: "Cancel",
                                //                 type: TextTypes.f_10_600,
                                //                 forceColor:
                                //                     AppColors.primaryColor,
                                //               ),
                                //             ),
                                //           ).marginSymmetric(horizontal: 10),
                                //           GestureDetector(
                                //             onTap: () => {controller.UploadScoreApi()},
                                //             child: Container(
                                //               padding: const EdgeInsets.all(10),
                                //               decoration: BoxDecoration(
                                //                 color: AppColors.blue2,
                                //                 borderRadius:
                                //                 BorderRadius.circular(5),
                                //               ),
                                //               child: Label(
                                //                 txt: "Upload",
                                //                 type: TextTypes.f_10_600,
                                //                 forceColor:
                                //                 AppColors.whiteColor,
                                //               ),
                                //             ),
                                //           ),
                                //         ],
                                //       ).marginSymmetric(vertical: 10)
                                //     : SizedBox())



                              ],
                            ),
                          ),
                          SizedBox(
                              width: double.infinity,
                              child:Obx(()=> commonButton(
                                loading: controller.loading.value,

                                forceColor:AppColors.primaryColor ,
                                txt:"Submit",

                                onPressed: () {
                                  Get.closeAllSnackbars();
                                  controller.UploadScoreApi();



                                },
                              ),
                              ).marginOnly(bottom: 30,top: 20))
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
