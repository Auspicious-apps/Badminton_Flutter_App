import 'package:badminton/app_settings/components/label.dart';
import 'package:badminton/app_settings/components/widget_global_margin.dart';
import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/constants/app_dim.dart';
import 'package:badminton/modules/cart/controller/my_order_detail_controller.dart';
import 'package:badminton/repository/endpoint.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';

class Myorderdetailpage extends GetView<myOrderDetailController> {
  const Myorderdetailpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
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
                      txt: "Order Summary",
                      type: TextTypes.f_18_600,
                    ),
                  ],
                ),
                padVertical(20),
                Obx(
                  () => controller.myOrderDetail.value.data == null
                      ? Column(
                          children: [
                            // Skeleton for order items
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 2, // Show 2 skeleton items for loading
                              itemBuilder: (context, index) {
                                return Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColors.lightGrey,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: SkeletonItem(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            SkeletonAvatar(
                                              style: SkeletonAvatarStyle(
                                                width: 50,
                                                height: 50,
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                            ),
                                            padHorizontal(10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SkeletonLine(
                                                  style: SkeletonLineStyle(
                                                    height: 16,
                                                    width: Get.width * 0.5,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                                padVertical(5),
                                                SkeletonLine(
                                                  style: SkeletonLineStyle(
                                                    height: 12,
                                                    width: 80,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                        SkeletonLine(
                                          style: SkeletonLineStyle(
                                            height: 20,
                                            width: 40,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                            padVertical(8),
                            // Skeleton for delivery address, contact, order status, and total bill
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.lightGrey,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: SkeletonItem(
                                child: Column(
                                  children: [
                                    // Delivery Address
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SkeletonLine(
                                                style: SkeletonLineStyle(
                                                  height: 12,
                                                  width: 100,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              padVertical(4),
                                              SkeletonLine(
                                                style: SkeletonLineStyle(
                                                  height: 14,
                                                  width: Get.width * 0.7,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SkeletonLine(
                                      style: SkeletonLineStyle(
                                        height: 1,
                                        width: double.infinity,
                                        borderRadius: BorderRadius.zero,
                                      ),
                                    ),
                                    // Contact
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SkeletonLine(
                                                style: SkeletonLineStyle(
                                                  height: 12,
                                                  width: 80,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              padVertical(4),
                                              SkeletonLine(
                                                style: SkeletonLineStyle(
                                                  height: 14,
                                                  width: 120,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SkeletonLine(
                                      style: SkeletonLineStyle(
                                        height: 1,
                                        width: double.infinity,
                                        borderRadius: BorderRadius.zero,
                                      ),
                                    ),
                                    // Order Status
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SkeletonLine(
                                                style: SkeletonLineStyle(
                                                  height: 12,
                                                  width: 90,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              padVertical(4),
                                              SkeletonLine(
                                                style: SkeletonLineStyle(
                                                  height: 14,
                                                  width: 100,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SkeletonLine(
                                      style: SkeletonLineStyle(
                                        height: 1,
                                        width: double.infinity,
                                        borderRadius: BorderRadius.zero,
                                      ),
                                    ),
                                    // Total Bill Amount
                                    Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SkeletonLine(
                                                style: SkeletonLineStyle(
                                                  height: 12,
                                                  width: 110,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                              padVertical(4),
                                              SkeletonLine(
                                                style: SkeletonLineStyle(
                                                  height: 14,
                                                  width: 150,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SkeletonAvatar(
                                            style: SkeletonAvatarStyle(
                                              width: 20,
                                              height: 20,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )
                      : ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: controller
                                  .myOrderDetail.value.data?.items?.length ??
                              0,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
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
                                      Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            child: Image.network(
                                              "${imageBaseUrl}${controller.myOrderDetail.value.data?.items?[index].image ?? ""}",
                                              height: 80,
                                              width: 80,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                  AppAssets.rackettt,
                                                  height: 80,
                                                  width: 80,
                                                  fit: BoxFit.cover,
                                                );
                                              },
                                            ),
                                          ),
                                          padHorizontal(10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                width: Get.width * 0.5,
                                                child: Label(
                                                  maxLines: 4,
                                                  txt: controller
                                                          .myOrderDetail
                                                          .value
                                                          .data
                                                          ?.items?[index]
                                                          ?.name ??
                                                      "",
                                                  type: TextTypes.f_14_600,
                                                ),
                                              ),
                                              Label(
                                                txt:
                                                    "₹${controller.myOrderDetail.value.data?.items?[index]?.price}",
                                                type: TextTypes.f_12_700,
                                                forceColor: AppColors.smalltxt,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      padHorizontal(10),
                                      Row(
                                        children: [
                                          padHorizontal(10),
                                          Label(
                                            txt:
                                                "${controller.myOrderDetail.value.data?.items?[index]?.quantity}",
                                            type: TextTypes.f_20_600,
                                            forceColor: AppColors.blue2,
                                          ),
                                          padHorizontal(10),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
                padVertical(8),
                Obx(() => controller.myOrderDetail.value.data != null
                    ? Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.lightGrey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Label(
                                            txt: "Delivery Address",
                                            type: TextTypes.f_12_700,
                                            forceColor: AppColors.smalltxt,
                                          ),
                                          Obx(
                                            () => Label(
                                              txt:
                                                  "${controller.myOrderDetail.value.data?.address?.nameOfRecipient ?? ""},${controller.myOrderDetail.value.data?.address?.street ?? ""},${controller.myOrderDetail.value.data?.address?.city ?? ""} ${controller.myOrderDetail.value.data?.address?.state ?? ""} ${controller.myOrderDetail.value.data?.address?.pinCode ?? ""}",
                                              type: TextTypes.f_14_600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  padHorizontal(10),
                                ],
                              ),
                            ),
                            const Divider(),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Label(
                                            txt: "Contact",
                                            type: TextTypes.f_12_700,
                                            forceColor: AppColors.smalltxt,
                                          ),
                                          Obx(
                                            () => Label(
                                              txt:
                                                  "+91 ${controller.myOrderDetail.value.data?.address?.phoneNumber}",
                                              type: TextTypes.f_14_600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Divider(),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Label(
                                            txt: "Order Status",
                                            type: TextTypes.f_12_700,
                                            forceColor: AppColors.smalltxt,
                                          ),
                                          Obx(
                                            () => Label(
                                              txt:
                                                  " ${controller.myOrderDetail.value.data?.orderStatus?.toUpperCase() ?? ""}",
                                              type: TextTypes.f_14_600,
                                            ),
                                          ).marginOnly(top: 4),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Divider(),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Label(
                                            txt: "Total Bill Amount",
                                            type: TextTypes.f_12_700,
                                            forceColor: AppColors.smalltxt,
                                          ),
                                          Obx(
                                            () => Label(
                                              txt:
                                                  "Inclusive of all taxes: ₹${(controller.myOrderDetail.value.data?.totalAmount ?? 0)?.toStringAsFixed(2)}",
                                              type: TextTypes.f_14_600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  padHorizontal(10),
                                  const Icon(
                                    Icons.arrow_forward_ios,
                                    color: AppColors.blue,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    : SizedBox()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
