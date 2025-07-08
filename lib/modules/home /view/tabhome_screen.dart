import 'package:badminton/app_settings/components/label.dart';
import 'package:badminton/app_settings/components/widget_global_margin.dart';
import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/constants/app_const.dart';
import 'package:badminton/app_settings/constants/app_dim.dart';
import 'package:badminton/modules/home%20/controller/dashboard_controller.dart';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:get/get.dart';
import 'package:google_maps_places_autocomplete_widgets/widgets/address_autocomplete_textfield.dart';
import 'package:intl/intl.dart';

import '../../../repository/endpoint.dart';
import '../controller/tab_home_controller.dart';
import '../controller/tabplay_controller.dart';

class PgTabhome extends GetView<TabHomeController> {
  PgTabhome({super.key});

  final List<Map<String, String>> banners = [
    {"image": AppAssets.ban1, "title": "Tennis"},
    {"image": AppAssets.ban2, "title": "Badminton"},
    {"image": AppAssets.ban3, "title": "Swimming"},
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Skeleton(
        isLoading: controller.loading.value,
        skeleton: _buildSkeletonUI(),
        child: Scaffold(
          backgroundColor: AppColors.whiteColor,
          body: _buildBody(context),
          floatingActionButton: _buildFloatingActionButton(),
        ),
      ),
    );
  }

  Widget _buildSkeletonUI() {
    return SingleChildScrollView(
      child: WidgetGlobalMargin(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Skeleton
            Container(
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(color: AppColors.whiteColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                          width: 25,
                          height: 20,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                      padHorizontal(5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              width: Get.width * 0.2,
                              height: 12,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const SizedBox(height: 8),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              width: Get.width * 0.3,
                              height: 12,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                          width: 40,
                          height: 40,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      padHorizontal(5),
                      SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                          width: 40,
                          height: 40,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      padHorizontal(5),
                      SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                          width: 34,
                          height: 34,
                          borderRadius: BorderRadius.circular(17),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Content Skeleton
            const SizedBox(height: 20),
            // Banner Carousel Skeleton
            SkeletonItem(
              child: Container(
                height: 150,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Activities Section Title Skeleton
            Row(
              children: [
                const Expanded(
                  child: SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 1,
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                ),
                padHorizontal(5),
                SkeletonLine(
                  style: SkeletonLineStyle(
                    width: 80,
                    height: 12,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                padHorizontal(10),
                const Expanded(
                  child: SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 1,
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                ),
              ],
            ),
            padVertical(20),
            // Activity Cards Skeleton
            Row(
              children: [
                Expanded(
                  child: SkeletonItem(
                    child: Container(
                      height: 150,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              width: 80,
                              height: 8,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          padVertical(5),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              width: 120,
                              height: 14,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          padVertical(5),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              width: 150,
                              height: 10,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          const Spacer(),
                          Align(
                            alignment: Alignment.center,
                            child: SkeletonLine(
                              style: SkeletonLineStyle(
                                width: 100,
                                height: 36,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: SkeletonItem(
                    child: Container(
                      height: 150,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              width: 120,
                              height: 14,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          padVertical(5),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              width: 150,
                              height: 8,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          padVertical(5),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              width: 150,
                              height: 8,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            padVertical(15),
            // Loyalty and Actions Skeleton
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: SkeletonItem(
                    child: Container(
                      height: 135,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              width: 80,
                              height: 8,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          padVertical(5),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              width: 120,
                              height: 14,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          padVertical(5),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              width: 150,
                              height: 8,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          padVertical(15),
                          SkeletonLine(
                            style: SkeletonLineStyle(
                              width: 100,
                              height: 8,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          padVertical(10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(
                                5,
                                (index) => SkeletonLine(
                                      style: SkeletonLineStyle(
                                        width: (Get.width * 0.3) / 4,
                                        height: 4,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                    )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                padHorizontal(5),
                Expanded(
                  child: Column(
                    children: [
                      SkeletonItem(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              SkeletonAvatar(
                                style: SkeletonAvatarStyle(
                                  width: 44,
                                  height: 44,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              padHorizontal(5),
                              SkeletonLine(
                                style: SkeletonLineStyle(
                                  width: 100,
                                  height: 14,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      padVertical(5),
                      SkeletonItem(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              SkeletonAvatar(
                                style: SkeletonAvatarStyle(
                                  width: 44,
                                  height: 44,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              padHorizontal(5),
                              SkeletonLine(
                                style: SkeletonLineStyle(
                                  width: 100,
                                  height: 14,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            padVertical(15),
            // Venues Near You Title Skeleton
            SkeletonLine(
              style: SkeletonLineStyle(
                width: 150,
                height: 14,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            // Venue List Skeleton
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 3, // Show 3 placeholder cards
              itemBuilder: (context, index) => SkeletonItem(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SkeletonAvatar(
                            style: SkeletonAvatarStyle(
                              width: 50,
                              height: 50,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          padHorizontal(8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SkeletonLine(
                                style: SkeletonLineStyle(
                                  width: 120,
                                  height: 12,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                              padVertical(5),
                              SkeletonLine(
                                style: SkeletonLineStyle(
                                  width: 100,
                                  height: 10,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Column(
                            children: [
                              SkeletonAvatar(
                                style: SkeletonAvatarStyle(
                                  width: 35,
                                  height: 35,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              padVertical(5),
                              SkeletonLine(
                                style: SkeletonLineStyle(
                                  width: 60,
                                  height: 10,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          ),
                          padHorizontal(10),
                          Column(
                            children: [
                              SkeletonAvatar(
                                style: SkeletonAvatarStyle(
                                  width: 23,
                                  height: 23,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ).marginOnly(top: 10),
                              padVertical(5),
                              SkeletonLine(
                                style: SkeletonLineStyle(
                                  width: 40,
                                  height: 10,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ).marginSymmetric(vertical: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          await controller.getCurrentLocation();
          await controller.getProfile();
        },
        color: AppColors.primaryColor,
        backgroundColor: AppColors.whiteColor,
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(child: _buildContent(context)),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(color: AppColors.whiteColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildLocationSelector(context),
          _buildHeaderActions(),
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
              mapsApiKey: 'AIzaSyCDZoRf-BZL2yR_ZyXpzht_a63hMgLCTis',
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
                var controller1 = Get.put(PlayController());
                controller.location.value = suggestion.formattedAddress ?? "";
                controller.latitude.value =
                    suggestion.lat ?? controller.latitude.value;
                controller.longitude.value =
                    suggestion.lng ?? controller.longitude.value;
                controller1.location.value = suggestion.formattedAddress ?? "";
                controller1.latitude.value =
                    suggestion.lat ?? controller.latitude.value;
                controller1.longitude.value =
                    suggestion.lng ?? controller.longitude.value;
                controller.getData();
                Get.back();
              },
            ),
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Widget _buildHeaderActions() {
    return Row(
      children: [
        GestureDetector(
          onTap: () async {
            await Get.toNamed('/messages');
            controller.getProfile();
          },
          child: Stack(
            children: [
              Image.asset(AppAssets.chat, width: 40, height: 40),
              Obx(() => controller.ProfileData.value.data?.unreadChats == 0
                  ? const SizedBox()
                  : Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        height: 17,
                        width: 17,
                        child: Center(
                          child: Text(
                            "${controller.ProfileData.value.data?.unreadChats}",
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ).paddingSymmetric(horizontal: 4),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(15)),
                      )))
            ],
          ),
        ),
        padHorizontal(5),
        GestureDetector(
          onTap: () async {
            await Get.toNamed('/notification');
            controller.getProfile();
          },
          child: Stack(
            children: [
              Image.asset(AppAssets.bell, width: 40, height: 40),
              Obx(() => controller
                          .ProfileData.value.data?.unreadNotifications ==
                      0
                  ? const SizedBox()
                  : Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        height: 17,
                        width: 17,
                        child: Center(
                          child: Text(
                            "${controller.ProfileData.value.data?.unreadNotifications}",
                            style: TextStyle(color: Colors.white, fontSize: 10),
                          ),
                        ).paddingSymmetric(horizontal: 4),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(15)),
                      )))
            ],
          ),
        ),
        padHorizontal(5),
        GestureDetector(
          onTap: () {
            // final dashboard=Get.find<DashboardController>();
            // dashboard.onTabSelected(3);
            Get.toNamed('/userprofiledetail', arguments: {
              "id": controller.ProfileData.value.data?.sId ?? "",
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
                      controller
                              .ProfileData.value.data!.profilePic?.isNotEmpty ==
                          true)
                  ? Image.network(
                      controller.ProfileData.value.data!.profilePic!
                              .startsWith('http')
                          ? controller.ProfileData.value.data?.profilePic ?? ""
                          : "${imageBaseUrl}${controller.ProfileData.value.data!.profilePic}",
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
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return WidgetGlobalMargin(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            _buildBannerCarousel(),
            const SizedBox(height: 20),
            _buildSectionTitle("Activities"),
            padVertical(20),
            _buildActivityCards(),
            padVertical(15),
            _buildLoyaltyAndActions(),
            padVertical(15),
            const Label(
              txt: "Venues Near You",
              type: TextTypes.f_14_700,
              forceColor: AppColors.blackColor,
            ),
            _buildVenueList(),
          ],
        ),
      ),
    );
  }

  Widget _buildBannerCarousel() {
    return CarouselSlider.builder(
      itemCount: controller.responseModel.value.data?.banners?.length,
      itemBuilder: (context, index, realIndex) => Container(
        width: Get.width,
        height: Get.height * 0.2,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: NetworkImage(
                "${imageBaseUrl}${controller.responseModel.value.data?.banners?[index] ?? " "}"),
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
      ).marginSymmetric(horizontal: 10),
      options: CarouselOptions(
        height: 150,
        autoPlay: true,
        enlargeCenterPage: false, // Disable center enlargement
        viewportFraction: 1.0, // Full width per slide
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        const Expanded(
          child: Divider(color: AppColors.border, thickness: 1, endIndent: 10),
        ),
        padHorizontal(5),
        Label(txt: title, type: TextTypes.f_12_700),
        padHorizontal(10),
        const Expanded(
          child: Divider(color: AppColors.border, thickness: 1, endIndent: 8),
        ),
      ],
    );
  }

  Widget _buildActivityCards() {
    return LayoutBuilder(
      builder: (context, constraints) {
        const double cardHeight = 150;
        const double spacing = 8;
        return Row(
          children: [
            Expanded(
              child: Container(
                child: controller.responseModel.value.data?.upcomingMatches
                            ?.length ==
                        0
                    ? Container(
                        height: cardHeight,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.lightGrey,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Label(
                            txt: "No Match Found",
                            type: TextTypes.f_14_400,
                            forceColor: AppColors.grey,
                          ),
                        ),
                      )
                    : CarouselSlider.builder(
                        itemCount: controller.responseModel.value.data
                                ?.upcomingMatches?.length ??
                            0,
                        itemBuilder: (context, index, realIndex) => Container(
                          height: cardHeight,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4),
                                child: Label(
                                  txt: "Upcoming",
                                  type: TextTypes.f_8_400,
                                  forceColor: AppColors.whiteColor,
                                ),
                              ),
                              padVertical(5),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 4),
                                child: Label(
                                  txt:
                                      "${controller.responseModel.value.data?.upcomingMatches?[index]?.askToJoin == true ? "Open Match" : "Private"}",
                                  type: TextTypes.f_16_600,
                                  forceColor: AppColors.whiteColor,
                                ),
                              ),
                              padVertical(5),
                              Row(
                                children: [
                                  Image.asset(AppAssets.calender2,
                                      width: 15, height: 15),
                                  padHorizontal(5),
                                  Expanded(
                                    child: Label(
                                      txt:
                                          "${controller.responseModel.value.data?.upcomingMatches?[index]?.bookingDate != null ? DateFormat('yyyy-MM-dd').format(DateTime.parse(controller.responseModel.value.data?.upcomingMatches?[index]?.bookingDate ?? "")) : ""} ${() {
                                        try {
                                          final dateTime = DateFormat('HH:mm')
                                              .parse(controller
                                                      .responseModel
                                                      .value
                                                      .data
                                                      ?.upcomingMatches?[index]
                                                      .bookingSlots ??
                                                  "");
                                          return DateFormat('h:mm a')
                                              .format(dateTime);
                                        } catch (e) {
                                          return controller
                                              .responseModel
                                              .value
                                              .data
                                              ?.upcomingMatches?[index]
                                              .bookingSlots; // Fallback to original string
                                        }
                                      }()}",
                                      type: TextTypes.f_10_400,
                                      forceColor: AppColors.whiteColor,
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(),
                              Align(
                                alignment: Alignment.center,
                                child: GestureDetector(
                                  onTap: () {
                                    print(">>>>>>>>>>>>hellooooo>>>>>>");
                                    Get.toNamed("/booking_detail", arguments: {
                                      "id": controller.responseModel.value.data
                                          ?.upcomingMatches?[index].sId,
                                      "isCancel": true
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: AppColors.whiteColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Label(
                                        txt:
                                            "${controller.responseModel.value.data?.upcomingMatches?[index]?.bookingDate != null ? DateFormat('dd MMM, EEE').format(DateTime.parse(controller.responseModel.value.data?.upcomingMatches?[index]?.bookingDate ?? "")) : ""}",
                                        // txt: "14 Oct, Wed",,
                                        type: TextTypes.f_14_700,
                                        forceColor: AppColors.primaryColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        options: CarouselOptions(
                          height: 150,
                          autoPlay: true,
                          enlargeCenterPage: true, // Disable center enlargement
                          viewportFraction: 1.0, // Full width per slide
                        ),
                      ),
              ),
            ),
            const SizedBox(width: spacing),
            Expanded(
              child: Container(
                height: cardHeight,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Label(
                        txt: "Player Rankings",
                        type: TextTypes.f_14_700,
                        forceColor: AppColors.blackColor,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Label(
                        txt: "Play more games to get your",
                        type: TextTypes.f_8_400,
                        forceColor: AppColors.grey,
                        forceAlignment: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 4),
                      child: Label(
                        txt: "profile summary ranking.",
                        type: TextTypes.f_8_400,
                        forceColor: AppColors.grey,
                        forceAlignment: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLoyaltyAndActions() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(child: _buildLoyaltyCard()),
        padHorizontal(5),
        Expanded(child: _buildActionButtons()),
      ],
    );
  }

  Widget _buildLoyaltyCard() {
    return Container(
      height: 135,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Label(
                    txt: "Loyalty Points",
                    type: TextTypes.f_10_600,
                    forceColor: AppColors.blackColor,
                  ),
                  padVertical(5),
                  Obx(() => Label(
                      txt:
                          "${controller.responseModel.value.data?.loyaltyPoints?.points.toString()}",
                      type: TextTypes.f_16_600)),
                ],
              ),
              Column(
                children: [
                  const Label(
                    txt: "Free Games",
                    type: TextTypes.f_10_600,
                    forceColor: AppColors.blackColor,
                  ),
                  padVertical(5),
                  Obx(() => Label(
                      txt:
                          "${controller.responseModel.value.data?.loyaltyPoints?.freeGames.toString() ?? "0"}",
                      type: TextTypes.f_16_600,
                      forceColor: Colors.green)),
                ],
              ),
            ],
          ).marginSymmetric(horizontal: 8),
          padVertical(5),
          const SizedBox(
            width: 130,
            child: Label(
              maxLines: 3,
              txt: "Collect 2000 more and win an assured reward.",
              type: TextTypes.f_8_400,
              forceColor: AppColors.smalltxt,
            ),
          ),
          padVertical(15),
          SizedBox(
            width: Get.width * 0.4,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Label(
                    txt: "0 points",
                    type: TextTypes.f_8_400,
                    forceColor: AppColors.smalltxt),
                Label(
                    txt: "2000 points",
                    type: TextTypes.f_8_400,
                    forceColor: AppColors.smalltxt),
              ],
            ),
          ),
          padVertical(10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(5, (index) {
              bool isCompleted = index <
                  ((controller.responseModel.value.data?.loyaltyPoints?.level ??
                              0) /
                          2)
                      .toInt();
              return Container(
                width: (Get.width * 0.3) / 4,
                height: 4,
                decoration: BoxDecoration(
                  color: isCompleted ? AppColors.orange : Colors.grey,
                  borderRadius: BorderRadius.circular(4),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        GestureDetector(
          onTap: () => Get.toNamed('/tournaments'),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Image.asset(AppAssets.tournament, width: 44, height: 44),
                padHorizontal(5),
                const Label(
                  txt: "Tournaments",
                  type: TextTypes.f_14_700,
                  forceColor: AppColors.blackColor,
                ),
              ],
            ),
          ),
        ),
        padVertical(5),
        GestureDetector(
          onTap: () => Get.toNamed('/merchandise'),
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Image.asset(AppAssets.racket, width: 44, height: 44),
                padHorizontal(5),
                const Label(
                  txt: "Merchandise",
                  type: TextTypes.f_14_700,
                  forceColor: AppColors.blackColor,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVenueList() {
    return Obx(() {
      final venues = controller.responseModel.value.data?.venueNearby ?? [];
      if (venues.isEmpty) {
        return const Center(child: Text("No Data Found"))
            .marginSymmetric(vertical: 40);
      }
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: venues.length,
        itemBuilder: (context, index) {
          final venue = venues[index];
          return GestureDetector(
            onTap: () => Get.toNamed('/courtdetail',
                arguments: {"id": venue.sId, "distance": venue.distance}),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 4),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 50,
                        padding: const EdgeInsets.all(2),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: Image.network(
                              "${imageBaseUrl}${venue.image}",
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Image.asset(AppAssets.court,
                                    width: 50, height: 50);
                              },
                            )),
                      ),
                      padHorizontal(8),
                      SizedBox(
                        width: Get.width * 0.34,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Label(
                                maxLines: 2,
                                txt: venue.name ?? "",
                                type: TextTypes.f_12_700),
                            Label(
                              maxLines: 3,
                              txt: "${venue.city ?? ""}, ${venue.state ?? ""}",
                              type: TextTypes.f_10_400,
                              forceColor: AppColors.smalltxt,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Column(
                        children: [
                          (venue.weather?.icon ?? "").isEmpty
                              ? Icon(
                                  Icons.wb_sunny_outlined,
                                  size: 25,
                                )
                              : Image.network(
                                  "https:${venue.weather?.icon ?? ""}",
                                  height: 35,
                                ),
                          SizedBox(
                            width: 40,
                            child: Label(
                              maxLines: 2,
                              txt: venue.weather?.status ?? "sunny",
                              type: TextTypes.f_10_400,
                              forceColor: AppColors.smalltxt,
                            ),
                          ),
                        ],
                      ),
                      padHorizontal(10),
                      Column(
                        children: [
                          const Icon(Icons.location_on_outlined,
                                  size: 23, color: AppColors.blue)
                              .marginOnly(top: 10),
                          Label(
                            txt:
                                "${venue.distance?.toStringAsFixed(2) ?? "0.0"} km",
                            type: TextTypes.f_10_400,
                            forceColor: AppColors.smalltxt,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    }).marginSymmetric(vertical: 20);
  }

  Widget _buildFloatingActionButton() {
    return SpeedDial(
      icon: Icons.add,
      iconTheme: const IconThemeData(size: 30),
      activeIcon: Icons.close,
      backgroundColor: AppColors.primaryColor,
      overlayOpacity: 0.4,
      overlayColor: Colors.black,
      foregroundColor: Colors.white,
      spaceBetweenChildren: 10,
      children: [
        SpeedDialChild(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          child: ClipOval(
            child: Container(
              color: AppColors.whiteColor,
              height: 50,
              width: 50,
              child: Center(
                child: Image.asset(AppAssets.newgame, height: 20, width: 20),
              ),
            ),
          ),
          label: 'Create New Game',
          labelStyle: const TextStyle(
            fontSize: 14,
            fontFamily: AppConst.fontFamily,
            fontWeight: FontWeight.w400,
            color: AppColors.blackColor,
          ),
          onTap: () async {
            await Get.toNamed('/creategame', arguments: {
              "location": controller.location.value,
              "lat": controller.latitude.value,
              "lng": controller.longitude.value
            });
            controller.getData();
          },
        ),
        SpeedDialChild(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          child: ClipOval(
            child: Container(
              color: AppColors.whiteColor,
              height: 50,
              width: 50,
              child: Center(
                child: Image.asset(AppAssets.rackett, height: 20, width: 20),
              ),
            ),
          ),
          label: 'My Bookings',
          labelStyle: const TextStyle(
            fontSize: 14,
            fontFamily: AppConst.fontFamily,
            fontWeight: FontWeight.w400,
            color: AppColors.blackColor,
          ),
          onTap: () => Get.toNamed('/mybookings'),
        ),
        SpeedDialChild(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.transparent,
          child: ClipOval(
            child: Container(
              color: AppColors.whiteColor,
              height: 50,
              width: 50,
              child: Center(
                child: Image.asset(AppAssets.score, height: 20, width: 20),
              ),
            ),
          ),
          label: 'Upload Score',
          labelStyle: const TextStyle(
            fontSize: 14,
            fontFamily: AppConst.fontFamily,
            fontWeight: FontWeight.w400,
            color: AppColors.blackColor,
          ),
          onTap: () => Get.toNamed('/allbookings'),
        ),
      ],
    );
  }
}
