import 'package:badminton/app_settings/components/label.dart';
import 'package:badminton/app_settings/components/widget_global_margin.dart';
import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/constants/app_dim.dart';
import 'package:badminton/app_settings/constants/common_button.dart';
import 'package:badminton/modules/cart/controller/cart_controller.dart';
import 'package:cart_button/cart_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../repository/endpoint.dart';

class PgCartScreen extends StatefulWidget {
  const PgCartScreen({super.key});

  @override
  State<PgCartScreen> createState() => _PgCartScreenState();
}

class _PgCartScreenState extends State<PgCartScreen> {
  final CartController cartController = Get.find<CartController>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: WidgetGlobalMargin(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                GestureDetector(
                  onTap: () => {Navigator.pop(context)},
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
                  )
                ),
                padHorizontal(10),
                const Label(
                  txt: "Cart",
                  type: TextTypes.f_18_600,
                ),
              ]),
              padVertical(20),
              Expanded(
                child: Obx(() => cartController.cartItems.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart_outlined,
                              size: 80,
                              color: Colors.grey.shade400,
                            ),
                            padVertical(20),
                            const Label(
                              txt: "Your cart is empty",
                              type: TextTypes.f_16_600,
                              forceColor: Colors.grey,
                            ),
                            padVertical(10),
                            GestureDetector(
                              onTap: () => Get.back(),
                              child: const Label(
                                txt: "Continue Shopping",
                                type: TextTypes.f_14_600,
                                forceColor: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        itemCount: cartController.cartItems.length,
                        itemBuilder: (context, index) {
                          final item = cartController.cartItems[index];
                          return Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.lightGrey,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: item.imageUrl.startsWith('http')
                                    ? Image.network(
                                        item.imageUrl,
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stackTrace) {
                                          return Image.asset(
                                            AppAssets.rackettt,
                                            width: 80,
                                            height: 80,
                                            fit: BoxFit.contain,
                                          );
                                        },
                                      )
                                    : Image.asset(
                                        AppAssets.rackettt,
                                        width: 80,
                                        height: 80,
                                        fit: BoxFit.contain,
                                      ),
                                ),
                                padHorizontal(10),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Label(
                                        txt: item.productName,
                                        type: TextTypes.f_16_600,
                                      ),
                                      padVertical(5),
                                      Label(
                                        txt: "₹${item.discountedPrice.toStringAsFixed(2)}",
                                        type: TextTypes.f_14_600,
                                        forceColor: AppColors.primaryColor,
                                      ),
                                    ],
                                  ),
                                ),
                                CartButtonInt(
                                  count: item.quantity,
                                  size: 25,
                                  style: CartButtonStyle(
                                    foregroundColor: Colors.black87,
                                    activeForegroundColor: Colors.black87,
                                    activeBackgroundColor: Colors.white,
                                    radius: const Radius.circular(8),
                                    border: Border.all(color: Colors.grey),
                                    elevation: 0,
                                    buttonAspectRatio: 1.5,
                                  ),
                                  onChanged: (count) {
                                    if (count <= 0) {
                                      // Show confirmation dialog before removing
                                      Get.dialog(
                                        AlertDialog(
                                          title: const Text('Remove Item'),
                                          content: Text('Remove ${item.productName} from cart?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Get.back(),
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                cartController.removeFromCart(item.productId);
                                                Get.back();
                                              },
                                              child: const Text('Remove'),
                                            ),
                                          ],
                                        ),
                                      );
                                    } else {
                                      // Update quantity
                                      cartController.updateQuantity(item.productId, count);
                                    }
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                  ),
              ),
              Obx(() => cartController.cartItems.isNotEmpty
                ? Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Label(
                              txt: "Total:",
                              type: TextTypes.f_16_600,
                            ),
                            Label(
                              txt: "₹${cartController.totalAmount.toStringAsFixed(2)}",
                              type: TextTypes.f_16_600,
                              forceColor: AppColors.primaryColor,
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                color: AppColors.whiteColor,
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  strokeAlign: 1,
                                  color: AppColors.primaryColor
                                )
                              ),
                              child: GestureDetector(
                                onTap: () => {
                                  Get.toNamed("/merchandise")
                                },
                                child: const Center(
                                  child: Label(
                                    txt: "Add More",
                                    type: TextTypes.f_16_600,
                                    forceColor: AppColors.primaryColor,
                                  )
                                ),
                              ),
                            )
                          ),
                          padHorizontal(10),
                          Expanded(
                            child: commonButton(
                              context: context,
                              onPressed: () {

                                Get.offNamed("/orderAddress");

                              },
                              txt: "Checkout"
                            )
                          ),
                        ],
                      ),
                    ],
                  )
                : const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
