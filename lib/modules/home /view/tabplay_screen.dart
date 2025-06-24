// lib/pages/pg_tabplay.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:get/get.dart';

import 'package:badminton/Pages/Notification/pg_notification.dart';
import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/components/label.dart';
import 'package:badminton/app_settings/components/widget_global_margin.dart';
import 'package:badminton/app_settings/constants/app_dim.dart';
import 'package:google_maps_places_autocomplete_widgets/widgets/address_autocomplete_textfield.dart';
import 'package:intl/intl.dart';

import '../../../repository/endpoint.dart';
import '../../creategames/model/AllBookingsResponseModel.dart';
import '../controller/dashboard_controller.dart';
import '../controller/tab_home_controller.dart';
import '../controller/tabplay_controller.dart';

class PgTabplay extends GetView<PlayController> {
   PgTabplay({super.key});


  final double playerSlotSize = Get.width * 0.1; // 10% of screen width for each slot
  final double spacing = Get.width * 0.02;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(context),
            padVertical(15),
            Expanded(child:  _buildBody(context)),
          ],
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

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      color: AppColors.whiteColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLocationSelector(context),
          Row(children: [
            GestureDetector( onTap: () => Get.toNamed('/messages'),child: Image.asset(AppAssets.chat, width: 40, height: 40)),
            padHorizontal(5),
            GestureDetector(
              // onTap: () => Get.to(() => const PgNotification()),
              onTap: () => Get.toNamed('/notification'),
              child: Image.asset(AppAssets.bell, width: 40, height: 40),
            ),
            padHorizontal(5),
          Obx(()=>   GestureDetector(
            onTap: (){
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
          ))
          ])
        ],
      ),
    );
  }
  Widget _buildLocationSelector(BuildContext context) {
    return GestureDetector(
      onTap: () => _showLocationBottomSheet(context),
      child: Row(
        children: [
          Image.asset(AppAssets.location, width: 25, height: 20),
          padHorizontal(5),
          SizedBox(
            width: Get.width * 0.4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: const [
                    Label(txt: "Nearby", type: TextTypes.f_12_700),
                    Icon(Icons.keyboard_arrow_down_outlined, size: 20),
                  ],
                ),
                Obx(
                      () => Label(
                    txt: controller.location.value.isEmpty
                        ? "Select Location"
                        : controller.location.value,
                    type: TextTypes.f_12_500,
                    forceColor: AppColors.smalltxt,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showLocationBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        height: MediaQuery.of(context).size.height * 0.95,
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.location_on),
                const SizedBox(width: 8),
                const Text(
                  "Search Location",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: Get.back,
                ),
              ],
            ),
            const SizedBox(height: 10),
            AddressAutocompleteTextField(
              // Replace with environment variable or config
              mapsApiKey:'AIzaSyCDZoRf-BZL2yR_ZyXpzht_a63hMgLCTis',
              componentCountry: 'in',
              language: 'en',
              decoration: InputDecoration(
                hintText: 'Search for location',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSuggestionClick: (suggestion) {
                var controller1 =Get.put(TabHomeController());
                controller.location.value = suggestion.formattedAddress ?? "";
                controller.latitude.value = suggestion.lat ?? controller.latitude.value;
                controller.longitude.value = suggestion.lng ?? controller.longitude.value;
                controller1.location.value = suggestion.formattedAddress ?? "";
                controller1.latitude.value = suggestion.lat ?? controller.latitude.value;
                controller1.longitude.value = suggestion.lng ?? controller.longitude.value;
                Get.back();
              },
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }
  Widget _buildBody(BuildContext context) {
    return WidgetGlobalMargin(
      child: RefreshIndicator(
        onRefresh: () async {
          // Call the refresh method from your PlayController
          await controller.getBookingList(); // Ensure this method exists in PlayController
        },
        child: SingleChildScrollView(
          child: Obx(()=>Skeleton(
              isLoading: controller.loading.value,
              skeleton: _buildSkeletonUI(),

            child: Column(
              children: [
                _buildFilters(context),
                padVertical(20),
                // _buildSectionTitle("Open Matches"),

                Obx(()=>(controller.bookList.value.data?.length)!=0?ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.bookList.value.data?.length??0,
                  itemBuilder: (context, index) {
                    final match =controller.bookList.value.data?[index];
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                Row(
                                  children: [
                                    Label(
                                      txt: "•  ${match?.court?.games}",
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
                                  txt: match?.isCompetitive==true?"Competitive Match":"Friendly Match"?? "",
                                  type: TextTypes.f_10_600,
                                  forceColor: AppColors.smalltxt,
                                ).marginSymmetric(horizontal: spacing * 2),
                              ]
                          ).marginSymmetric(vertical: 10),
                          SizedBox(height: spacing),
                          // Responsive player slots


                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Left side: Two player slots
                              SizedBox(
                                height: 80,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal, // Horizontal scrolling
                                  itemCount: match?.team1?.length ?? 0, // Number of players in team1
                                  itemBuilder: (context, index) {
                                    final player = match?.team1?[index]; // Access player at index
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: spacing), // Spacing between items
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            alignment: Alignment.bottomCenter,
                                            children: [
                                              // Circular image or placeholder
                                              player?.player?.image == null
                                                  ?  GestureDetector(
                                                onTap: (){
                                                  Get.toNamed('/userprofiledetail',
                                                      arguments: {"id": player?.player?.sId ?? "", "isAdmin": false});
                                                },
                                                    child: Container(
                                                                                                height: 50,
                                                                                                width: 50,
                                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),   color: AppColors.lightGrey,border: Border.all(color: AppColors.primaryColor)),
                                                                                                child: Icon(
                                                    Icons.person, // Placeholder icon
                                                    size: 40.sp,
                                                    color: AppColors.grey,
                                                                                                    ),
                                                                                                  ),
                                                  )
                                                  : GestureDetector(
                                                onTap: (){
                                                  Get.toNamed('/userprofiledetail',
                                                      arguments: {"id": player?.player?.sId ?? "", "isAdmin": false});
                                                },

                                                    child: ClipRRect(
                                                                                                borderRadius: BorderRadius.circular(50),
                                                                                                child: Image.network(
                                                    "${imageBaseUrl}${player?.player?.image}",
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
                                        ),
                                        Label(txt: player?.player?.name??"", type: TextTypes.f_8_400).marginOnly(top: 10)

                                      ],
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
                                height: 80,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal, // Horizontal scrolling
                                  itemCount: match?.team2?.length ?? 0, // Number of players in team1
                                  itemBuilder: (context, index) {
                                    final player = match?.team2?[index]; // Access player at index
                                    return Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(right: spacing), // Spacing between items
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            alignment: Alignment.bottomCenter,
                                            children: [
                                              // Circular image or placeholder
                                              player?.player?.image == null
                                                  ? GestureDetector(
                                                onTap: (){
                                                  Get.toNamed('/userprofiledetail',
                                                      arguments: {"id": player?.player?.sId ?? "", "isAdmin": false});
                                                },
                                                    child: Container(
                                                                                                height: 50,
                                                                                                width: 50,
                                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),   color: AppColors.lightGrey,border: Border.all(color: AppColors.primaryColor)),
                                                                                                child: Icon(
                                                    Icons.person, // Placeholder icon
                                                    size: 40.sp,
                                                    color: AppColors.grey,
                                                                                                ),
                                                                                              ),
                                                  )
                                                  :  GestureDetector(
                                                onTap: (){
                                                  Get.toNamed('/userprofiledetail',
                                                      arguments: {"id": player?.player?.sId ?? "", "isAdmin": false});
                                                },
                                                    child: ClipRRect(
                                                                                                borderRadius: BorderRadius.circular(50),
                                                                                                child: Image.network(
                                                    "${imageBaseUrl}${player?.player?.image}",
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
                                        ),
                                        Label(txt: player?.player?.name??"", type: TextTypes.f_8_400).marginOnly(top: 10)
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ).marginSymmetric(horizontal: spacing * 2),
                          SizedBox(height: spacing),
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
                                        txt: match?.venue?.address?? "",
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
                                                ? DateFormat('EEE, MMM d, yyyy').format(
                                              DateTime.parse(match?.bookingDate??"").toLocal(),
                                            )
                                                : "Unknown Date",
                                            type: TextTypes.f_10_400,
                                            forceColor: AppColors.smalltxt,
                                          ),
                                          Label(
                                            txt: match?.bookingSlots != null
                                                ? (() {
                                              try {
                                                // Parse time-only string (e.g., "21:00")
                                                final timeFormat = DateFormat('HH:mm');
                                                final parsedTime = timeFormat.parse(match?.bookingSlots?.first??"");
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
                              ).marginSymmetric(vertical: 10),
                              match?.team1?.length==2&& match?.team2?.length==2 ?SizedBox():GestureDetector(
                                onTap: () {

                                  // );
                                  Get.toNamed('/join_game_detail',arguments: {"id":match?.sId,});

                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColors.blue2,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child:  Label(
                                    txt: "Join Now",
                                    type: TextTypes.f_10_600,
                                    forceColor: AppColors.whiteColor,
                                  ),
                                ),
                              ),
                            ],
                          ).marginSymmetric(horizontal: spacing * 2),
                        ],
                      ),
                    );
                  },
                ):Container(height: Get.height*0.3,child: Center(child: Label(txt: "Data Not Found", type: TextTypes.f_14_500)))),

              ],
            ),
          ),
        )),
      ),
    );
  }

  Widget _buildFilters(BuildContext context) {
    final filters = ["Paddle", "Club", "Mon-Thu", "Distance"];
    return       Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Label(
          txt: "Open Matches",
          type: TextTypes.f_16_600,
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
    );
  }




}
