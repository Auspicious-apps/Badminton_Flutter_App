import 'package:badminton/app_settings/components/label.dart';
import 'package:badminton/app_settings/components/widget_global_margin.dart';
import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/constants/app_dim.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';

import '../../../repository/endpoint.dart';
import '../controller/friend_request_controller.dart';

class PgFriends extends GetView<FriendsController> {
  const PgFriends({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: controller.getFriendRequest,
          color: AppColors.primaryColor,
          backgroundColor: AppColors.whiteColor,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: WidgetGlobalMargin(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  padVertical(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: controller.goBack,
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
                            txt: "All Friends",
                            type: TextTypes.f_18_600,
                          ),
                        ],
                      ),
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert,
                            color: AppColors.primaryColor),
                        onSelected: (String value) {
                          if (value == 'block_list') {
                            Get.toNamed("/block-list");
                          } else if (value == 'friend_requests') {
                            // Get.to(() => const FriendRequests());
                          }
                        },
                        itemBuilder: (BuildContext context) => [
                          const PopupMenuItem<String>(
                            value: 'block_list',
                            child: Text('Block List'),
                          ),
                        ],
                        color: AppColors.whiteColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        offset: const Offset(0, 40),
                      ),
                    ],
                  ),
                  padVertical(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Label(
                        txt: "Friend Requests",
                        type: TextTypes.f_14_600,
                      ),
                      GestureDetector(
                        onTap: controller.goToFriendRequests,
                        child: const Label(
                          txt: "View All",
                          type: TextTypes.f_10_600,
                        ),
                      ),
                    ],
                  ),
                  padVertical(15),
                  Obx(
                    () => controller.loading.value
                        ? _buildSkeletonFriendRequestList()
                        : (controller.userdata.value.data?.requests ?? [])
                                .isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller.userdata.value.data
                                        ?.requests?.length ??
                                    0,
                                itemBuilder: (context, index) {
                                  final request = controller
                                      .userdata.value.data?.requests?[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Get.toNamed('/userprofiledetail',
                                          arguments: {
                                            "id": request?.sId ?? "",
                                            "isAdmin": false
                                          });
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 34,
                                                      width: 34,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            AppColors.lightGrey,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(45),
                                                        border: Border.all(
                                                          width: 2,
                                                          color: AppColors.blue,
                                                        ),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(45),
                                                        child: (request?.profilePic !=
                                                                    null &&
                                                                request?.profilePic
                                                                        ?.isNotEmpty ==
                                                                    true)
                                                            ? Image.network(
                                                                "${imageBaseUrl}${request?.profilePic}",
                                                                fit: BoxFit
                                                                    .cover,
                                                                errorBuilder:
                                                                    (context,
                                                                        error,
                                                                        stackTrace) {
                                                                  return Container(
                                                                    color: AppColors
                                                                        .lightGrey,
                                                                    child: Icon(
                                                                      Icons
                                                                          .person, // Error image/icon
                                                                      size:
                                                                          20.sp,
                                                                      color: AppColors
                                                                          .grey,
                                                                    ),
                                                                  );
                                                                },
                                                              )
                                                            : Container(
                                                                color: AppColors
                                                                    .lightGrey,
                                                                child: Icon(
                                                                  Icons
                                                                      .person, // Default icon when no image
                                                                  size: 20.sp,
                                                                  color:
                                                                      AppColors
                                                                          .grey,
                                                                ),
                                                              ),
                                                      ),
                                                    ),
                                                    // ClipRRect(
                                                    //   borderRadius:
                                                    //   BorderRadius.circular(
                                                    //       30),
                                                    //   child: Image.asset(
                                                    //     AppAssets.racket,
                                                    //     fit: BoxFit.contain,
                                                    //     width: 35,
                                                    //     height: 35,
                                                    //   ),
                                                    // ),
                                                    padHorizontal(8),
                                                    Label(
                                                      txt: request?.fullName ??
                                                          "",
                                                      type: TextTypes.f_14_700,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () => controller
                                                          .cancelFriendRequest(
                                                              request?.relationshipId ??
                                                                  ""),
                                                      child: const Icon(
                                                        Icons.cancel_outlined,
                                                        color:
                                                            AppColors.smalltxt,
                                                      ),
                                                    ),
                                                    padHorizontal(10),
                                                    GestureDetector(
                                                      onTap: () => controller
                                                          .confirmFriendRequest(
                                                              request
                                                                  ?.relationshipId),
                                                      child: Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                          horizontal: 15,
                                                          vertical: 5,
                                                        ),
                                                        decoration:
                                                            BoxDecoration(
                                                          color:
                                                              AppColors.blue2,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(15),
                                                        ),
                                                        child: const Label(
                                                          txt: "Confirm",
                                                          type: TextTypes
                                                              .f_10_600,
                                                          forceColor: AppColors
                                                              .whiteColor,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          padVertical(8),
                                          index ==
                                                  ((controller
                                                              .userdata
                                                              .value
                                                              .data
                                                              ?.requests
                                                              ?.length ??
                                                          0) -
                                                      1)
                                              ? SizedBox()
                                              : const Divider(),
                                          padVertical(8),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Container(
                                height: Get.height * 0.2,
                                child: Center(child: Text("No Requests Found")),
                              ),
                  ),
                  padVertical(15),
                  const Label(
                    txt: "Friends",
                    type: TextTypes.f_14_600,
                  ),
                  padVertical(20),
                  Obx(
                    () => controller.loading.value
                        ? _buildSkeletonFriendsList()
                        : (controller.userdata.value.data?.friends ?? [])
                                .isNotEmpty
                            ? ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: controller
                                        .userdata.value.data?.friends?.length ??
                                    0,
                                itemBuilder: (context, index) {
                                  final friend = controller
                                      .userdata.value.data?.friends?[index];
                                  return GestureDetector(
                                    onTap: () {
                                      controller.sendMessage(controller.userdata
                                          .value.data?.friends?[index].sId);
                                      // Get.toNamed('/userprofiledetail',
                                      //     arguments: {
                                      //       "id": friend?.sId ?? "",
                                      //       "isAdmin": false
                                      //     });
                                    },
                                    child: Container(
                                      decoration: const BoxDecoration(),
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 15),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Container(
                                                      height: 34,
                                                      width: 34,
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            AppColors.lightGrey,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(45),
                                                        border: Border.all(
                                                          width: 2,
                                                          color: AppColors.blue,
                                                        ),
                                                      ),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(45),
                                                        child: (friend?.profilePic !=
                                                                    null &&
                                                                friend?.profilePic
                                                                        ?.isNotEmpty ==
                                                                    true)
                                                            ? Image.network(
                                                                "${imageBaseUrl}${friend?.profilePic}",
                                                                fit: BoxFit
                                                                    .cover,
                                                                errorBuilder:
                                                                    (context,
                                                                        error,
                                                                        stackTrace) {
                                                                  return Container(
                                                                    color: AppColors
                                                                        .lightGrey,
                                                                    child: Icon(
                                                                      Icons
                                                                          .person, // Error image/icon
                                                                      size:
                                                                          20.sp,
                                                                      color: AppColors
                                                                          .grey,
                                                                    ),
                                                                  );
                                                                },
                                                              )
                                                            : Container(
                                                                color: AppColors
                                                                    .lightGrey,
                                                                child: Icon(
                                                                  Icons
                                                                      .person, // Default icon when no image
                                                                  size: 20.sp,
                                                                  color:
                                                                      AppColors
                                                                          .grey,
                                                                ),
                                                              ),
                                                      ),
                                                    ),
                                                    padHorizontal(10),
                                                    Label(
                                                      txt: friend?.fullName ??
                                                          "",
                                                      type: TextTypes.f_14_700,
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Container(
                                                      width: 28,
                                                      height: 28,
                                                      decoration: BoxDecoration(
                                                        color: AppColors.blue2,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15),
                                                      ),
                                                      child: const Icon(
                                                        Icons
                                                            .messenger_outline_rounded,
                                                        color: AppColors
                                                            .whiteColor,
                                                        size: 12,
                                                      ),
                                                    ),
                                                    padHorizontal(10),
                                                    PopupMenuButton<String>(
                                                      icon: const Icon(
                                                          Icons.more_vert,
                                                          color: AppColors
                                                              .primaryColor),
                                                      onSelected:
                                                          (String value) {
                                                        if (value ==
                                                            'remove_friend') {
                                                          controller
                                                              .removeFriendRequest(
                                                                  friend
                                                                      ?.relationshipId);
                                                        } else if (value ==
                                                            'block_friend') {
                                                          controller
                                                              .blockFriend(
                                                                  friend?.sId);
                                                        }
                                                      },
                                                      itemBuilder: (BuildContext
                                                              context) =>
                                                          [
                                                        const PopupMenuItem<
                                                            String>(
                                                          value:
                                                              'remove_friend',
                                                          child: Text(
                                                              'Remove Friend'),
                                                        ),
                                                        const PopupMenuDivider(),
                                                        const PopupMenuItem<
                                                            String>(
                                                          value: 'block_friend',
                                                          child: Text('Block'),
                                                        ),
                                                      ],
                                                      color:
                                                          AppColors.whiteColor,
                                                      shape:
                                                          RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      offset:
                                                          const Offset(0, 40),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          padVertical(8),
                                          index ==
                                                  ((controller
                                                              .userdata
                                                              .value
                                                              .data
                                                              ?.friends
                                                              ?.length ??
                                                          0) -
                                                      1)
                                              ? SizedBox()
                                              : const Divider(),
                                          padVertical(8),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                              )
                            : Container(
                                height: Get.height * 0.2,
                                child: Center(child: Text("No Friend Found")),
                              ),
                  ),
                  padVertical(20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Skeleton view for Friend Requests
  Widget _buildSkeletonFriendRequestList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3, // Show 3 skeleton items as placeholders
      itemBuilder: (context, index) {
        return SkeletonItem(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            shape: BoxShape.circle,
                            width: 35,
                            height: 35,
                          ),
                        ),
                        padHorizontal(8),
                        SkeletonLine(
                          style: SkeletonLineStyle(
                            width: 100,
                            height: 14,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: 24,
                            height: 24,
                            shape: BoxShape.circle,
                          ),
                        ),
                        padHorizontal(10),
                        SkeletonLine(
                          style: SkeletonLineStyle(
                            width: 60,
                            height: 30,
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              padVertical(8),
              index == 2 ? SizedBox() : const Divider(),
              padVertical(8),
            ],
          ),
        );
      },
    );
  }

  // Skeleton view for Friends List
  Widget _buildSkeletonFriendsList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 3, // Show 3 skeleton items as placeholders
      itemBuilder: (context, index) {
        return SkeletonItem(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            shape: BoxShape.circle,
                            width: 35,
                            height: 35,
                          ),
                        ),
                        padHorizontal(10),
                        SkeletonLine(
                          style: SkeletonLineStyle(
                            width: 100,
                            height: 14,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: 28,
                            height: 28,
                            shape: BoxShape.circle,
                          ),
                        ),
                        padHorizontal(10),
                        SkeletonAvatar(
                          style: SkeletonAvatarStyle(
                            width: 24,
                            height: 24,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              padVertical(8),
              index == 2 ? SizedBox() : const Divider(),
              padVertical(8),
            ],
          ),
        );
      },
    );
  }
}
