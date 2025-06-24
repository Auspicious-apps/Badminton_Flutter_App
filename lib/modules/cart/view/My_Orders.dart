import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import '../../../app_settings/components/label.dart';
import '../../../app_settings/constants/app_dim.dart';
import '../controller/My_Orders_controller.dart';

class PgMyOrders extends StatelessWidget {
  const PgMyOrders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PgMyOrderController());

    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Column(
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
                        padHorizontal(10),
                        Label(
                          txt: "My Orders",
                          type: TextTypes.f_18_600,
                        ),
                      ],
                    ),
                    padVertical(20),

                    // Loading state with skeleton UI
                    Obx(() => controller.loading.value
                        ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 3, // Show 3 skeleton items for loading
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.lightGrey,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: SkeletonItem(
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SkeletonAvatar(
                                      style: SkeletonAvatarStyle(
                                        width: 80,
                                        height: 80,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                    ),
                                    padHorizontal(10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SkeletonLine(
                                            style: SkeletonLineStyle(
                                              height: 16,
                                              width: 150,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                          padVertical(5),
                                          SkeletonLine(
                                            style: SkeletonLineStyle(
                                              height: 12,
                                              width: 100,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                          padVertical(5),
                                          SkeletonLine(
                                            style: SkeletonLineStyle(
                                              height: 12,
                                              width: 120,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ).marginSymmetric(vertical: 10),
                                const SkeletonLine(
                                  style: SkeletonLineStyle(
                                    height: 1,
                                    width: double.infinity,
                                    borderRadius: BorderRadius.zero,
                                  ),
                                ),
                                padVertical(5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SkeletonLine(
                                      style: SkeletonLineStyle(
                                        height: 14,
                                        width: 100,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                    SkeletonLine(
                                      style: SkeletonLineStyle(
                                        height: 14,
                                        width: 80,
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                    ),
                                  ],
                                ),
                                padVertical(5),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                        : Container()),

                    // Empty state
                    Obx(() => !controller.loading.value && controller.orders.isEmpty
                        ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          padVertical(50),
                          Image.asset(
                            AppAssets.cart,
                            height: 150,
                          ),
                          padVertical(20),
                          const Label(
                            txt: "No orders found",
                            type: TextTypes.f_16_600,
                          ),
                          padVertical(10),
                          Label(
                            txt: "You haven't placed any orders yet",
                            type: TextTypes.f_14_400,
                            // textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                        : Container()),

                    // Order list
                    Obx(() => !controller.loading.value && controller.orders.isNotEmpty
                        ? ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.orders.length,
                      itemBuilder: (context, index) {
                        final order = controller.orders[index];
                        return GestureDetector(
                          onTap: () => controller.onOrderTapped(context, index),
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.lightGrey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        order.imagePath,
                                        height: 80,
                                        width: 80,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
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
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Label(
                                            maxLines: 2,
                                            txt: order.title,
                                            type: TextTypes.f_14_600,
                                          ),
                                          padVertical(5),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.location_on,
                                                color: AppColors.smalltxt,
                                                size: 14,
                                              ),
                                              padHorizontal(5),
                                              Expanded(
                                                child: Label(
                                                  maxLines: 2,
                                                  txt: order.location,
                                                  type: TextTypes.f_12_400,
                                                  forceColor: AppColors.smalltxt,
                                                ),
                                              ),
                                            ],
                                          ),
                                          padVertical(5),
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.access_time,
                                                color: AppColors.smalltxt,
                                                size: 14,
                                              ),
                                              padHorizontal(5),
                                              Label(
                                                txt: order.dateTime,
                                                type: TextTypes.f_12_400,
                                                forceColor: AppColors.smalltxt,
                                              ),
                                            ],
                                          ),
                                          padVertical(5),
                                        ],
                                      ),
                                    ),
                                  ],
                                ).marginSymmetric(vertical: 10),
                                Divider(),
                                padVertical(5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Label(
                                      txt: "Total Order(${order.quantity}):",
                                      type: TextTypes.f_14_600,
                                    ),
                                    Label(
                                      txt: order.price,
                                      type: TextTypes.f_14_700,
                                      forceColor: AppColors.primaryColor,
                                    ),
                                  ],
                                ),
                                padVertical(5),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                        : Container()),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to get status color
  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return Colors.green;
      case 'shipped':
        return Colors.blue;
      case 'processing':
        return Colors.orange;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  // Helper method to get payment status color
  Color _getPaymentStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'paid':
        return Colors.green;
      case 'pending':
        return Colors.orange;
      case 'failed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}