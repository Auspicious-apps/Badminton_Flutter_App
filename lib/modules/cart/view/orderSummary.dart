import 'package:badminton/app_settings/components/label.dart';
import 'package:badminton/app_settings/components/widget_global_margin.dart';
import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/constants/app_dim.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:get/get.dart';

import '../../../app_settings/constants/common_button.dart';
import '../../../repository/endpoint.dart';
import '../controller/orderSummaryController.dart';


class PgOrderSummary extends GetView<PgOrderSummaryController> {
  const PgOrderSummary({super.key});


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
                      () => controller.isLoading.value
                      ?  SkeletonListView(itemCount: 3)
                      : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.orderItems.length,
                    itemBuilder: (context, index) {
                      final item = controller.orderItems[index];
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
                                    Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 2,
                                          )
                                        ],
                                        color: AppColors.whiteColor,
                                        borderRadius:
                                        BorderRadius.circular(5),
                                      ),
                                      child:  GestureDetector(
                                        onTap: (){
                                          print("${item['image']}");
                                        },
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(5),
                                            topRight: Radius.circular(5),
                                          ),
                                          child: item['image'].isNotEmpty
                                              ? Image.network(
                                            "${item['image']}",
                                            height: 50,

                                            width:  50,
                                            fit: BoxFit.contain,
                                            errorBuilder: (context, error, stackTrace) {
                                              return Image.asset(
                                                AppAssets.rackettt,
                                                height: 50,

                                                width:  50,
                                                fit: BoxFit.contain,
                                              );
                                            },
                                          )
                                              : Image.asset(
                                            AppAssets.rackettt,
                                            height: 130,
                                            width: double.infinity,
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                      // child: Image.asset(
                                      //   width: 50,
                                      //   height: 50,
                                      //   AppAssets.rankProfile,
                                      //   fit: BoxFit.contain,
                                      // ),
                                    ),
                                    padHorizontal(10),
                                    SizedBox(
                                      width: Get.width*0.4,
                                      child: Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,

                                        children: [
                                          Label(
                                            maxLines: 7,
                                            txt: item['name'],
                                            type: TextTypes.f_14_600,
                                          ),
                                          Row(
                                            children: [
                                              if (item['discountedPrice'] > 0 && item['discountedPrice'] < item['actualPrice'])
                                                Label(
                                                  txt: "₹${item['actualPrice'].toStringAsFixed(2)}",
                                                  type: TextTypes.f_12_400,
                                                  forceColor: AppColors.smalltxt,
                                                  // decoration: TextDecoration.lineThrough,
                                                ),
                                              SizedBox(width: 5),
                                              Label(
                                                txt: "₹${item['price'].toStringAsFixed(2)}",
                                                type: TextTypes.f_12_700,
                                                forceColor: AppColors.smalltxt,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                padHorizontal(10),
                                Label(
                                  txt: item['quantity'].toString(),
                                  type: TextTypes.f_20_600,
                                  forceColor: AppColors.blue2,
                                ).marginSymmetric(horizontal: 10),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                padVertical(8),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                       Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Label(
                                      txt: "Delivery Address ",
                                      type: TextTypes.f_12_700,
                                      forceColor: AppColors.smalltxt,
                                    ),
                                    SizedBox(
                                      width: Get.width*0.8,
                                      child: Label(
                                        maxLines: 7,
                                        txt: "${controller.recipientName.value}, ${controller.address.value}${controller.cityStatePin}",
                                        type: TextTypes.f_14_600,
                                      ),
                                    ).marginSymmetric(vertical: 10),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                       Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Label(
                                      txt: "Contact",
                                      type: TextTypes.f_12_700,
                                      forceColor: AppColors.smalltxt,
                                    ),
                                    Label(
                                      txt: "${controller.phoneNumber.value}",
                                      type: TextTypes.f_14_600,
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Label(
                                      txt: "Total Bill Amount",
                                      type: TextTypes.f_12_700,
                                      forceColor: AppColors.smalltxt,
                                    ),
                                    Obx(
                                          () => Label(
                                        txt:
                                        "Inclusive of all taxes: ₹${controller.totalAmount.value.toStringAsFixed(2)}",
                                        type: TextTypes.f_14_600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            // padHorizontal(10),
                            // const Icon(
                            //   Icons.arrow_forward_ios,
                            //   color: AppColors.blue,
                            //   size: 20,
                            // ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: Get.height*0.15,),

                Obx(() => controller.isFromOrderHistory.value
                  ? Container(
                      width: Get.width,
                      child: commonButton(
                        context: context,
                        onPressed: () => Get.back(),
                        txt: "Back to Orders"
                      ),
                    )
                  : Container(
                      width: Get.width,
                      child: Obx(
                        () => commonButton(
                          context: context,
                          onPressed: controller.isLoading.value 
                            ? null 
                            : () => controller.createOrder(),
                          txt: controller.isLoading.value ? "Processing..." : "Place Order"
                        ),
                      ),
                    )
                ).marginSymmetric( vertical: 10)

              ],
            ),
          ),
        ),
      ),
    );
  }
}
