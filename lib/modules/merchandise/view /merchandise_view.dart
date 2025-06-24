// lib/pages/merchandise/pg_merchandise.dart
import 'package:badminton/Pages/CartScreen/pg_cart_screen.dart';
import 'package:badminton/Pages/Merchandise/Widgets/card_list.dart';
import 'package:badminton/Pages/Merchandise/Widgets/filter_button.dart';
import 'package:badminton/app_settings/components/label.dart';
import 'package:badminton/app_settings/components/widget_global_margin.dart';
import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/constants/app_dim.dart';
import '../../../modules/cart/controller/cart_controller.dart';
import '../../../modules/cart/model/cart_item_model.dart';
import '../../../repository/endpoint.dart';

import 'package:flutter/material.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import 'package:get/get.dart';

import '../controller/merchandise_home.dart';

class PgMerchandise extends GetView<MerchandiseController> {
  const PgMerchandise({super.key});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.find<CartController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: WidgetGlobalMargin(
          child: Column(
            children: [
              padVertical(10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      const Label(
                        txt: "Merchandise",
                        type: TextTypes.f_18_600,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.search,
                        color: AppColors.smalltxt,
                      ),
                      padHorizontal(10),
                      GestureDetector(
                        onTap: () => Get.to(() => const PgCartScreen()),
                        child: Container(

                          child: Stack(
                            children: [
                              Container(
                                child: const Icon(
                                  Icons.shopping_cart,
                                  color: AppColors.smalltxt,
                                ).paddingSymmetric(horizontal: 2),
                              ),
                              Obx(() {
                                // Get the current product ID
                                // final productId = controller.allMerchandise.value.data?.sId ?? '';
                                // Get the quantity of this specific product in the cart
                                final quantity = cartController.totalItems;

                                return quantity > 0
                                    ? Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(2),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    constraints: const BoxConstraints(
                                      minWidth: 12,
                                      minHeight: 12,
                                    ),
                                    child: Text(
                                      '$quantity',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 8,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
                                    : const SizedBox();
                              }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              padVertical(10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Obx(
                        () => Row(
                          children: [
                            FilterButton(
                              width: (Get.width - 100) / 4,
                              label: "All",
                              isSelected: controller.selectedButton.value == 0,
                              onTap: () => controller.updateSelectedButton(0),
                            ),
                            FilterButton(
                              width: (Get.width - 100) / 4,
                              label: "Paddle",
                              isSelected: controller.selectedButton.value == 1,
                              onTap: () => controller.updateSelectedButton(1),
                            ),
                            FilterButton(
                              width: (Get.width - 30) / 4,
                              label: "Pickleball",
                              isSelected: controller.selectedButton.value == 2,
                              onTap: () => controller.updateSelectedButton(2),
                            ),
                            // FilterButton(
                            //   width: (Get.width - 100) / 4,
                            //   label: "Bags",
                            //   isSelected: controller.selectedButton.value == 3,
                            //   // onTap: () => controller.updateSelectedButton(3),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    // Image.asset(
                    //   AppAssets.more,
                    //   fit: BoxFit.contain,
                    //   width: 20,
                    //   height: 20,
                    //   color: AppColors.darkprimary,
                    // ),
                  ],
                ),
              ),
          Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 10.0,
                  ),
                  child: Obx(
                    () =>controller.loading.value?_buildSkeletonGrid(context) : GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 8,
                            childAspectRatio: 0.7,
                      ),
                      itemCount: controller.allMerchandise.value.data?.length,
                      itemBuilder: (context, index) {
                        final product = controller.allMerchandise.value.data?[index];
                        return Obx(()=> ProductCard(
                          onImageTap: () {
                            debugPrint(">>>>>>>Print>>>>>>>>>>>>${controller.allMerchandise.value.data?[index]?.sId}");
                            Get.toNamed("/productdetail", arguments: {"id": controller.allMerchandise.value.data?[index]?.sId});
                          },
                          onCartTap: () {
                            // Add to cart functionality
                            final product = controller.allMerchandise.value.data?[index];
                            if (product != null) {
                              cartController.addToCart(CartItem(
                                productId: product.sId ?? '',
                                productName: product.productName ?? 'Product',
                                imageUrl: product.primaryImage != null ?
                                  "$imageBaseUrl${product.primaryImage}" : AppAssets.rackettt,
                                price: product.actualPrice?.toDouble() ?? 0.0,
                                discountedPrice: product.discountedPrice?.toDouble() ?? 0.0,
                                quantity: 1
                              ));
                            }

                          },
                          image: product?.primaryImage ?? "",
                          name: product?.productName ?? "",
                          price: product?.actualPrice?.toString() ?? "",
                          oldPrice: product?.discountedPrice?.toString() ?? "",
                          quantity: cartController.getItemQuantity(product?.sId ?? ''),
                        ));
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSkeletonGrid(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 8,
        childAspectRatio: 0.7,
      ),
      itemCount: 6, // Number of skeleton items (adjust as needed)
      itemBuilder: (context, index) {
        return Skeleton(
          isLoading: true, // Always true for skeleton UI
          skeleton: SkeletonProductCard(),
          child: const SizedBox.shrink(), // Empty child when not loading
        );
      },
    );
  }
}

class SkeletonProductCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.background,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 2),
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(color: Colors.black12, blurRadius: 2)
              ],
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Stack(
              children: [
                // Image placeholder
                SkeletonLine(
                  style: SkeletonLineStyle(
                    height: 130, // Match ProductCard image height
                    width: double.infinity,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                // Cart icon placeholder
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 30, // Match cart icon size
                      width: 30,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8), // Match padVertical(8)
          // Name placeholder
          SkeletonLine(
            style: SkeletonLineStyle(
              height: 14, // Approximate height for TextTypes.f_14_600
              width: double.infinity,
              borderRadius: BorderRadius.circular(4),
              padding: const EdgeInsets.symmetric(horizontal: 8),
            ),
          ),
          const SizedBox(height: 5), // Match padVertical(5)
          // Price and old price row placeholder
          Row(
            children: [
              SkeletonLine(
                style: SkeletonLineStyle(
                  height: 10, // Match TextTypes.f_10_400
                  width: 60, // Approximate width for price
                  borderRadius: BorderRadius.circular(4),
                  padding: const EdgeInsets.only(left: 8),
                ),
              ),
              const SizedBox(width: 10), // Match padHorizontal(10)
              SkeletonLine(
                style: SkeletonLineStyle(
                  height: 12, // Match TextTypes.f_12_700
                  width: 50, // Approximate width for old price
                  borderRadius: BorderRadius.circular(4),
                  padding: const EdgeInsets.only(right: 8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

