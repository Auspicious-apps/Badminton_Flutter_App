import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:get/get.dart';
import 'package:google_maps_places_autocomplete_widgets/widgets/address_autocomplete_textfield.dart';

import '../../../app_settings/components/label.dart';
import '../../../app_settings/components/widget_global_margin.dart';
import '../../../app_settings/constants/app_assets.dart';
import '../../../app_settings/constants/app_colors.dart';
import '../../../app_settings/constants/app_dim.dart';
import '../../../repository/endpoint.dart';
import '../../home /controller/dashboard_controller.dart';
import '../../home /controller/tab_home_controller.dart';
import '../controller/create_game_controller.dart';


class PgVenues extends GetView<VenueController> {
  const PgVenues({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body:Obx(()=> Skeleton(
        isLoading: controller.loading.value,
        skeleton: _buildSkeletonUI(),
        child: SafeArea(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      padding: const EdgeInsets.all(15),
                      decoration:
                      const BoxDecoration(color: AppColors.whiteColor),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.bottomSheet(
                                Container(
                                  height: MediaQuery.of(Get.context!).size.height*0.95,
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.location_on),
                                          SizedBox(width: 8),
                                          Text(
                                            "Search Location",
                                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                          ),
                                          Spacer(),
                                          IconButton(
                                            icon: Icon(Icons.close),
                                            onPressed: () => Get.back(),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      AddressAutocompleteTextField(
                                        mapsApiKey: 'AIzaSyCDZoRf-BZL2yR_ZyXpzht_a63hMgLCTis',
                                        // mapsApiKey: 'AIzaSyDTXEE75mRavQZdBr1gCeiDouoGxAP45P8',
                                        componentCountry: 'in', // Change to 'us' or your target
                                        language: 'en',
                                        decoration: InputDecoration(
                                          hintText: 'Search for location',
                                          prefixIcon: Icon(Icons.search),
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                        ),
                                        onSuggestionClick: (suggestion) {
                                          // Handle selected suggestion
                                          print(">>>>>>>>>suggestion${suggestion.lat}");
                                          print('Selected: ${suggestion.formattedAddress}');
                                          controller.location.value=suggestion.formattedAddress??"";
                                          controller.latitude.value=suggestion.lat??controller.latitude.value;
                                          controller.longitude.value=suggestion.lng??controller.longitude.value;
                                          controller.latitude.refresh();
                                          controller.longitude.refresh();
                                          controller.location.refresh();
                                          final TabHomeController homeController = Get.find<TabHomeController>();


                                          homeController.location.value = suggestion.formattedAddress ?? "";
                                          homeController.latitude.value = suggestion.lat ?? homeController.latitude.value;
                                          homeController.longitude.value = suggestion.lng ?? homeController.longitude.value;


                                          homeController.location.refresh();
                                          homeController.latitude.refresh();
                                          homeController.longitude.refresh();
                                          // homeController.getData();


                                          controller.getVenueData();

                                          Get.back(); // Close bottom sheet if needed

                                        },
                                      ),
                                      // Add other widgets below if needed
                                    ],
                                  ),
                                ),
                                isScrollControlled: true,
                              );
                            },

                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  AppAssets.location,
                                  fit: BoxFit.contain,
                                  width: 25,
                                  height: 20,
                                ),
                                padHorizontal(5),
                                SizedBox(
                                  width: Get.width*0.4,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          const Label(
                                            txt: "Nearby",
                                            type: TextTypes.f_12_700,
                                          ),
                                          const Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                            size: 20,
                                          ),
                                        ],
                                      ),
                                      Obx(
                                            () => Label(
                                          txt: controller.location.value,
                                          type: TextTypes.f_12_500,
                                          forceColor: AppColors.smalltxt,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                          ),


                          Row(children: [
                            GestureDetector(
                              onTap: () => Get.toNamed('/messages'),
                              child: Image.asset(
                                AppAssets.chat,
                                fit: BoxFit.contain,
                                width: 40,
                                height: 40,
                              ),
                            ),
                            padHorizontal(5),
                            GestureDetector(
                                onTap: () => Get.toNamed('/notification'),
                                child: Image.asset(
                                  AppAssets.bell,
                                  fit: BoxFit.contain,
                                  width: 40,
                                  height: 40,
                                )),
                            padHorizontal(5),
                            GestureDetector(
                              onTap: (){
                                // final dashboard=Get.find<DashboardController>();
                                // dashboard.onTabSelected(3);
                                Get.toNamed(
                                    '/userprofiledetail',
                                    arguments: {
                                      "id": controller
                                          .ProfileData
                                          .value
                                          .data
                                          ?.sId ??
                                          "",
                                      "isAdmin": true
                                    });
                              },
                              child: Container(
                                height: 34,
                                width: 34,
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: AppColors.lightGrey,
                                  borderRadius: BorderRadius.circular(45),
                                  border: Border.all(
                                    width: 2,
                                    color: AppColors.blue,
                                  ),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(45),
                                  child: (controller.ProfileData.value.data?.profilePic != null &&
                                      controller.ProfileData.value.data!.profilePic?.isNotEmpty ==
                                          true)
                                      ? Image.network(


                                    controller.ProfileData.value.data!.profilePic!.startsWith('http')?controller.ProfileData.value.data?.profilePic??"":
                                    "${imageBaseUrl}${controller.ProfileData.value.data!.profilePic}",
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: AppColors.lightGrey,
                                        child: Icon(
                                          Icons.broken_image, // Error image/icon
                                          size: 60.sp,
                                          color: AppColors.grey,
                                        ),
                                      );
                                    },
                                  )
                                      : Container(
                                    color: AppColors.lightGrey,
                                    child: Icon(
                                      Icons.person, // Default icon when no image
                                      size: 20.sp,
                                      color: AppColors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ])
                        ],
                      )),
                  Expanded(
                      child: WidgetGlobalMargin(
                          child: SingleChildScrollView(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                    // Row(
                                    //   children: [
                                    //     Image.asset(
                                    //       AppAssets.more,
                                    //       fit: BoxFit.contain,
                                    //       width: 25,
                                    //       height: 25,
                                    //       color: AppColors.darkprimary,
                                    //     ),
                                    //     Expanded(
                                    //       child: SingleChildScrollView(
                                    //         scrollDirection: Axis.horizontal,
                                    //         child: ConstrainedBox(
                                    //           constraints: BoxConstraints(
                                    //               minWidth:
                                    //               MediaQuery.of(context).size.width),
                                    //           child: Row(
                                    //             children: [
                                    //               padHorizontal(8),
                                    //               Container(
                                    //                 padding: const EdgeInsets.symmetric(
                                    //                     horizontal: 10),
                                    //                 decoration: BoxDecoration(
                                    //                   color: AppColors.primaryColor,
                                    //                   borderRadius: BorderRadius.circular(5),
                                    //                 ),
                                    //                 child: const Row(
                                    //                   children: [
                                    //                     Label(
                                    //                       txt: "Paddle",
                                    //                       type: TextTypes.f_10_400,
                                    //                       forceColor: AppColors.whiteColor,
                                    //                     ),
                                    //                     Icon(
                                    //                       Icons.arrow_drop_down_outlined,
                                    //                       color: AppColors.whiteColor,
                                    //                     )
                                    //                   ],
                                    //                 ),
                                    //               ),
                                    //               padHorizontal(8),
                                    //               Container(
                                    //                 padding: const EdgeInsets.symmetric(
                                    //                     horizontal: 10),
                                    //                 decoration: BoxDecoration(
                                    //                   color: AppColors.primaryColor,
                                    //                   borderRadius: BorderRadius.circular(5),
                                    //                 ),
                                    //                 child: const Row(
                                    //                   children: [
                                    //                     Label(
                                    //                       txt: "Club",
                                    //                       type: TextTypes.f_10_400,
                                    //                       forceColor: AppColors.whiteColor,
                                    //                     ),
                                    //                     Icon(
                                    //                       Icons.arrow_drop_down_outlined,
                                    //                       color: AppColors.whiteColor,
                                    //                     )
                                    //                   ],
                                    //                 ),
                                    //               ),
                                    //               padHorizontal(8),
                                    //               Container(
                                    //                 padding: const EdgeInsets.symmetric(
                                    //                     horizontal: 10),
                                    //                 decoration: BoxDecoration(
                                    //                   color: AppColors.primaryColor,
                                    //                   borderRadius: BorderRadius.circular(5),
                                    //                 ),
                                    //                 child: const Row(
                                    //                   children: [
                                    //                     Label(
                                    //                       txt: "Mon-Thu",
                                    //                       type: TextTypes.f_10_400,
                                    //                       forceColor: AppColors.whiteColor,
                                    //                     ),
                                    //                     Icon(
                                    //                       Icons.arrow_drop_down_outlined,
                                    //                       color: AppColors.whiteColor,
                                    //                     )
                                    //                   ],
                                    //                 ),
                                    //               ),
                                    //               padHorizontal(8),
                                    //               Container(
                                    //                 padding: const EdgeInsets.symmetric(
                                    //                     horizontal: 10),
                                    //                 decoration: BoxDecoration(
                                    //                   color: AppColors.primaryColor,
                                    //                   borderRadius: BorderRadius.circular(5),
                                    //                 ),
                                    //                 child: const Row(
                                    //                   children: [
                                    //                     Label(
                                    //                       txt: "Distance",
                                    //                       type: TextTypes.f_10_400,
                                    //                       forceColor: AppColors.whiteColor,
                                    //                     ),
                                    //                     Icon(
                                    //                       Icons.arrow_drop_down_outlined,
                                    //                       color: AppColors.whiteColor,
                                    //                     )
                                    //                   ],
                                    //                 ),
                                    //               ),
                                    //             ],
                                    //           ),
                                    //         ),
                                    //       ),
                                    //     ),
                                    //   ],
                                    // ),
                                    padVertical(20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                            const Label(
                                              txt: "Venues Near You",
                                              type: TextTypes.f_16_600,
                                            ).marginOnly(left: 20),
                                          ],
                                        ),
                                            GestureDetector(
                                              onTap: () => controller.showCalendarBottomSheet(
                                                context),
                                              child: Image.asset(
                                                AppAssets.more,
                                                fit: BoxFit.contain,
                                                width: 25,
                                                height: 25,
                                                color: AppColors.darkprimary,
                                              ),
                                            ),
                                      ],
                                    ),
                                    padVertical(15),
                       Obx (()=>controller.venueresponseModel.value.data?.length==0?Container(height: Get.height*0.5,child: Center(child: Text("Data Not Found"),))  :ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount:controller.venueresponseModel.value.data?.length??0,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                onTap: () {

                                  Get.toNamed('/courtdetail', arguments: {"id":controller.venueresponseModel.value.data?[index].sId,"distance":controller.venueresponseModel.value.data?[index].distance});
                                },
                                child: Container(
                                  margin: const EdgeInsets.symmetric(vertical: 8),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColors.lightGrey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(children: [
                                            Container(
                                              height: 50,
                                              width: 50,
                                              padding: const EdgeInsets.all(2),

                                              child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(4),
                                                  child: Image.network(
                                                    "${imageBaseUrl}${controller.venueresponseModel.value.data?[index].image}",
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context, error, stackTrace) {
                                                      return  Image.asset(AppAssets.court, width: 50, height: 50);
                                                    },
                                                  )

                                              ),
                                            ),
                                            padHorizontal(8),
                                             SizedBox(
                                               width: Get.width*0.34,
                                               child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Label(
                                                      maxLines: 2,
                                                        txt: controller.venueresponseModel.value.data?[index].name??"",
                                                        type: TextTypes.f_12_700),
                                                    Label(
                                                      maxLines: 4,
                                                      txt:
                                                     "${controller.venueresponseModel.value.data?[index].city ?? ""}, ${controller.venueresponseModel.value.data?[index].state ?? ""}",
                                                      type: TextTypes.f_10_400,
                                                      forceColor:
                                                      AppColors.smalltxt,
                                                    )
                                                  ]),
                                             )
                                          ]),
                                          Row(children: [
                                            Column(
                                              children: [
                                               ( controller.venueresponseModel
                                                    .value.data?[index].weather?.icon??"").isEmpty? Icon(Icons.wb_sunny_outlined,size: 25,):  Image.network("https:${
                                                    controller.venueresponseModel
                                                        .value.data?[index].weather?.icon ??
                                                        ""
                                                }",height: 35,),
                                                SizedBox(
                                                  width: 40,
                                                  child: Label(
                                                    maxLines: 2,
                                                    txt:
                                                    controller.venueresponseModel
                                                        .value.data?[index].weather?.status ??
                                                        "sunny"
                                                    ,
                                                    type: TextTypes.f_10_400,
                                                    forceColor: AppColors.smalltxt,
                                                  ),
                                                )
                                              ],
                                            ),
                                            padHorizontal(10),

                                            Column(
                                              children: [
                                                Icon(
                                                  Icons.location_on_outlined,
                                                  size: 23,
                                                  color: AppColors.blue,
                                                ).marginOnly(top: 10),
                                                Label(
                                                  txt: "${ controller.venueresponseModel
                                                      .value.data?[index].distance?.toStringAsFixed(2)} km" ?? "0.0",
                                                  type: TextTypes.f_10_400,
                                                  forceColor: AppColors.smalltxt,
                                                ),
                                              ],
                                            )

                                            // )
                                          ])
                                        ],
                                      ),

                                      const Divider(),
                                      const Align(
                                        alignment: Alignment.topLeft,
                                        child: Label(
                                          txt: "Slots available today",
                                          type: TextTypes.f_12_700,
                                          forceColor: AppColors.primaryColor,
                                        ),
                                      ),
                                      padVertical(10),

                                      Obx(() {
                                        final courtsList = controller.venueresponseModel
                                            .value.data?[index].courts;
                                        if (courtsList!.isEmpty) {
                                          return const Label(
                                            txt: "No courts available",
                                            type: TextTypes.f_12_500,
                                            forceColor: AppColors.smalltxt,
                                          );
                                        }

                                        final isExpanded = controller.expandedItems[index] ?? false;
                                        final displayCourts = isExpanded ? courtsList : [courtsList.first];

                                        final courtWidgets = displayCourts.map((court) {

                                          final slots = court.availableSlots;

                                          // Chunk slots into rows of 4
                                          final slotRows = <Widget>[];
                                          for (int i = 0; i < slots!.length; i += 4) {
                                            final chunk = slots.skip(i).take(4).toList();
                                            slotRows.add(
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: chunk.map((slot) {
                                                  return Padding(
                                                    padding: const EdgeInsets.all(5.0),
                                                    child: SizedBox(
                                                    width: (Get.width-90)/4, // Fixed width
                                                    height: 40, // Fixed height
                                                    child: Container(
                                                      padding: const EdgeInsets.all(10),
                                                      decoration: BoxDecoration(
                                                        color: AppColors.whiteColor,
                                                        borderRadius: BorderRadius.circular(5),
                                                      ),
                                                      child: Center( // center the text
                                                        child: Label(
                                                          txt: controller.formatTime(slot.time ?? ""),
                                                          type: TextTypes.f_10_600,
                                                          forceColor: AppColors.smalltxt,
                                                        ),
                                                      ),
                                                    ),
                                                                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            );
                                          }

                                          return Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Label(
                                                txt: court.name??"",
                                                type: TextTypes.f_12_700,
                                              ),
                                              const SizedBox(height: 6),
                                              ...slotRows,
                                              const SizedBox(height: 10),
                                            ],
                                          );
                                        }).toList();

                                        // Add View More / View Less button
                                              courtWidgets.add(
                                                Column(
                                            crossAxisAlignment: CrossAxisAlignment.end,

                                            children: [(controller.venueresponseModel.value.data![index].courts?.length ?? 0) > 1?GestureDetector(
                                              onTap: () => controller.toggleExpanded(index),
                                              child: Row(
                                                crossAxisAlignment:CrossAxisAlignment.center ,
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [

                                                  Label(
                                                    txt: isExpanded ? "View less" : "View more",
                                                    type: TextTypes.f_12_500,
                                                    forceColor: AppColors.primaryColor,
                                                  ),
                                                  Icon( isExpanded ?Icons.keyboard_arrow_up:Icons.keyboard_arrow_down)
                                                ],
                                              ),
                                            ):SizedBox()],
                                          ),
                                        );

                                        return AnimatedSwitcher(
                                          duration: const Duration(milliseconds: 300),
                                          child: Column(
                                            key: ValueKey(isExpanded),
                                            children: courtWidgets,
                                          ),
                                        );
                                      }),


                                    ],
                                  ),
                                ),
                              );
                            },
                          ))

                          ])))),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
  Widget _buildSkeletonUI() {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            decoration: const BoxDecoration(color: AppColors.whiteColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SkeletonItem(
                      child: Container(
                        width: 25,
                        height: 20,
                        color: Colors.grey[300],
                      ),
                    ),
                    padHorizontal(5),
                    SizedBox(
                      width: Get.width * 0.4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SkeletonItem(
                            child: Container(
                              width: 80,
                              height: 16,
                              color: Colors.grey[300],
                            ),
                          ),
                          const SizedBox(height: 4),
                          SkeletonItem(
                            child: Container(
                              width: 120,
                              height: 12,
                              color: Colors.grey[300],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SkeletonItem(
                      child: Container(
                        width: 40,
                        height: 40,
                        color: Colors.grey[300],
                      ),
                    ),
                    padHorizontal(5),
                    SkeletonItem(
                      child: Container(
                        width: 40,
                        height: 40,
                        color: Colors.grey[300],
                      ),
                    ),
                    padHorizontal(5),
                    SkeletonItem(
                      child: Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[300],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SkeletonItem(
                          child: Container(
                            width: 25,
                            height: 25,
                            color: Colors.grey[300],
                          ),
                        ),
                        padHorizontal(8),
                        Expanded(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                4,
                                    (index) => Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 4),
                                  child: SkeletonItem(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Container(
                                        width: 60,
                                        height: 12,
                                        color: Colors.grey[300],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    padVertical(20),
                    SkeletonItem(
                      child: Container(
                        width: 150,
                        height: 18,
                        color: Colors.grey[300],
                      ),
                    ),
                    padVertical(15),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3, // Show 3 skeleton cards
                      itemBuilder: (context, index) {
                        return SkeletonItem(
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.lightGrey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 50,
                                          height: 50,
                                          color: Colors.grey[300],
                                        ),
                                        padHorizontal(8),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              width: 100,
                                              height: 14,
                                              color: Colors.grey[300],
                                            ),
                                            const SizedBox(height: 4),
                                            Container(
                                              width: 80,
                                              height: 12,
                                              color: Colors.grey[300],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            Container(
                                              width: 35,
                                              height: 35,
                                              color: Colors.grey[300],
                                            ),
                                            const SizedBox(height: 4),
                                            Container(
                                              width: 50,
                                              height: 12,
                                              color: Colors.grey[300],
                                            ),
                                          ],
                                        ),
                                        padHorizontal(10),
                                        Column(
                                          children: [
                                            Container(
                                              width: 23,
                                              height: 23,
                                              color: Colors.grey[300],
                                            ).marginOnly(top: 10),
                                            const SizedBox(height: 4),
                                            Container(
                                              width: 40,
                                              height: 12,
                                              color: Colors.grey[300],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Divider(),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Container(
                                    width: 120,
                                    height: 14,
                                    color: Colors.grey[300],
                                  ),
                                ),
                                padVertical(10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 80,
                                      height: 14,
                                      color: Colors.grey[300],
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: List.generate(
                                        4,
                                            (index) => Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: SizedBox(
                                            width: (Get.width - 90) / 4,
                                            height: 40,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Container(
                                    width: 80,
                                    height: 14,
                                    color: Colors.grey[300],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
