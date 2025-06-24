import 'package:badminton/Pages/CartScreen/pg_cart_screen.dart';
import 'package:badminton/Pages/Merchandise/Widgets/card_list.dart';
import 'package:badminton/app_settings/components/label.dart';
import 'package:badminton/app_settings/components/widget_global_margin.dart';
import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/constants/app_dim.dart';
import 'package:badminton/app_settings/constants/common_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_skeleton_ui/flutter_skeleton_ui.dart';
import '../../../repository/endpoint.dart';
import '../controller/product_detail_controller.dart';
import '../../../modules/cart/controller/cart_controller.dart';
import '../../../modules/cart/model/cart_item_model.dart';

class PgProductDetail extends GetView<PgProductDetailController> {
  const PgProductDetail({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PgProductDetailController());
    final cartController = Get.find<CartController>();
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: WidgetGlobalMargin(
          child: SingleChildScrollView(
            child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                                  final productId = controller.allMerchandise.value.data?.sId ?? '';
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
                padVertical(20),
                Skeleton(
                  isLoading: controller.loading.value,
                  skeleton: SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                      width: double.infinity,
                      height: 330,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 2),
                      ],
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: (controller.primaryImage.value != null &&
                        controller.primaryImage.value.isNotEmpty)
                        ? ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                                                width: double.infinity,
                                                height: 330,
                                                "${imageBaseUrl}${controller.primaryImage.value}",
                                                fit: BoxFit.fill,
                                                errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            AppAssets.rackettt,
                            width: double.infinity,
                            height: 330,
                            fit: BoxFit.contain,
                          );
                                                },
                                              ),
                        )
                        : Image.asset(
                      AppAssets.rackettt,
                      width: double.infinity,
                      height: 330,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                padVertical(20),
                Skeleton(
                  isLoading: controller.loading.value,
                  skeleton: SkeletonListView(
                    itemCount: 4,

                    item: SkeletonAvatar(
                      style: SkeletonAvatarStyle(
                        width: 70,
                        height: 70,
                        borderRadius: BorderRadius.circular(5),
                        padding: const EdgeInsets.only(right: 12.0),
                      ),
                    ),
                  ),
                  child: controller.allMerchandise.value.data?.thumbnails
                      ?.length ==
                      0
                      ? const SizedBox()
                      : SizedBox(
                    height: 90,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller
                          .allMerchandise.value.data?.thumbnails?.length ??
                          0,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.primaryImage.value =
                                      controller.allMerchandise.value.data
                                          ?.thumbnails?[index] ??
                                          "";
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 2,
                                      ),
                                    ],
                                    color: AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      width: 70,
                                      height: 70,
                                      "${imageBaseUrl}${controller.allMerchandise.value.data?.thumbnails?[index]}",
                                      fit: BoxFit.fill,
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Image.asset(
                                          AppAssets.rackettt,
                                          width: 70,
                                          height: 70,
                                          fit: BoxFit.fill,
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),
                padVertical(20),
                Skeleton(
                  isLoading: controller.loading.value,
                  skeleton: SkeletonLine(
                    style: SkeletonLineStyle(
                      width: MediaQuery.of(context).size.width / 1.2,
                      height: 20,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Label(
                      maxLines: 3,
                      txt: "${controller.allMerchandise.value.data?.productName}",
                      type: TextTypes.f_20_600,
                    ),
                  ),
                ),
                padVertical(5),
                Skeleton(
                  isLoading: controller.loading.value,
                  skeleton: SkeletonParagraph(
                    style: SkeletonParagraphStyle(
                      lines: 3,
                      lineStyle: SkeletonLineStyle(
                        height: 12,
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                  child: Label(
                    maxLines: 1500,
                    txt: "${controller.allMerchandise.value.data?.description}",
                    type: TextTypes.f_12_400,
                    forceColor: AppColors.grey,
                  ),
                ),
                padVertical(20),
                Skeleton(
                  isLoading: controller.loading.value,
                  skeleton: Row(
                    children: [
                      Expanded(
                        child: SkeletonLine(
                          style: SkeletonLineStyle(
                            height: 56,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      padHorizontal(10),
                      SkeletonAvatar(
                        style: SkeletonAvatarStyle(
                          width: 56,
                          height: 56,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
               Expanded(
                        child: commonButton(
                          context: context,
                          onPressed: () {
                            if( cartController.getItemQuantity(controller.allMerchandise.value.data?.sId??"") > 0){
                              Get.off(() => const PgCartScreen());
                            }else{
                              if (controller.allMerchandise.value.data != null) {
                                final product = controller.allMerchandise.value.data!;
                                cartController.addToCart(CartItem(
                                    productId: product.sId ?? '',
                                    productName: product.productName ?? 'Product',
                                    imageUrl: product.primaryImage != null ?
                                    "$imageBaseUrl${product.primaryImage}" : AppAssets.rackettt,
                                    price: product.actualPrice?.toDouble() ?? 0.0,
                                    quantity: 1
                                ));
                                Get.off(() => const PgCartScreen());
                              }
                            }


                          },
                          txt:cartController.getItemQuantity(controller.allMerchandise.value.data?.sId??"") > 0?"Go To Cart" :"Buy It Now",
                        ),
                      ),
                      padHorizontal(10),
                      GestureDetector(
                        onTap: () {

                          if (controller.allMerchandise.value.data != null) {
                            final product = controller.allMerchandise.value.data!;
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
                        child: Container(
                          height: 56,
                          width: 56,
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Stack(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Icon(
                                    Icons.add_shopping_cart,
                                    color: AppColors.whiteColor,
                                    size: 20,
                                  ),
                                ),
                                if (cartController.getItemQuantity(controller.allMerchandise.value.data?.sId??"") > 0)
                                  Positioned(
                                    right: 0,
                                    top: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                      constraints: const BoxConstraints(
                                        minWidth: 16,
                                        minHeight: 16,
                                      ),
                                      child: Text(
                                        '${cartController.getItemQuantity(controller.allMerchandise.value.data?.sId??"")}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                padVertical(20),
                Skeleton(
                  isLoading: controller.loading.value,
                  skeleton: SkeletonListTile(
                    hasSubtitle: true,
                    contentSpacing: 10,
                    titleStyle: SkeletonLineStyle(
                      height: 14,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    subtitleStyle: SkeletonLineStyle(
                      height: 10,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 2),
                      ],
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GetBuilder<PgProductDetailController>(
                          builder: (controller) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Obx(
                      ()=> GestureDetector(
                                  onTap: () => controller.updateSelectedIndex(0),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: controller.selectedIndex == 0
                                          ? AppColors.blue2
                                          : AppColors.whiteColor,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Label(
                                      txt: "Details",
                                      type: TextTypes.f_12_700,
                                      forceColor: controller.selectedIndex == 0
                                          ? AppColors.whiteColor
                                          : AppColors.smalltxt,
                                    ),
                                  ),
                                ),
                              ),
                              Obx(()=>GestureDetector(
                                onTap: () => controller.updateSelectedIndex(1),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: controller.selectedIndex == 1
                                        ? AppColors.blue2
                                        : AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Label(
                                    txt: "Specifications",
                                    type: TextTypes.f_12_700,
                                    forceColor: controller.selectedIndex == 1
                                        ? AppColors.whiteColor
                                        : AppColors.smalltxt,
                                  ),
                                ),
                              )),
                             Obx(()=> GestureDetector(
                                onTap: () => controller.updateSelectedIndex(2),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 15,
                                    vertical: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: controller.selectedIndex == 2
                                        ? AppColors.blue2
                                        : AppColors.whiteColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Label(
                                    txt: "Reviews",
                                    type: TextTypes.f_12_700,
                                    forceColor: controller.selectedIndex == 2
                                        ? AppColors.whiteColor
                                        : AppColors.smalltxt,
                                  ),
                                ),
                              )),
                            ],
                          ),
                        ),
                        padVertical(10),
                         Label(
                          txt: "${controller.allMerchandise.value.data?.productName}",
                          type: TextTypes.f_14_600,
                        ),
                        padVertical(5),
                        controller.selectedIndex.value==0? Label(
                          txt: "Description",
                          type: TextTypes.f_12_700,
                        ): controller.selectedIndex.value==1? Label(
                          txt: "Specifications",
                          type: TextTypes.f_12_700,
                        ):Label(
                          txt: "Reviews",
                          type: TextTypes.f_12_700,
                        ),
                        padVertical(10),
                        controller.selectedIndex.value==0? Label(
                          maxLines: 1500,
                          txt: "${controller.allMerchandise.value.data?.description}",
                          type: TextTypes.f_10_400,
                          forceColor: AppColors.smalltxt,
                        ): controller.selectedIndex.value==1?Label(
                          maxLines: 1500,
                          txt: "${controller.allMerchandise.value.data?.specification}",
                          type: TextTypes.f_10_400,
                          forceColor: AppColors.smalltxt,
                        ):SizedBox(height: 50,child: Center(child: Label(
                          txt: "no Reviews Yet",
                          type: TextTypes.f_12_700,
                        ),),),
                      ],
                    ),
                  ),
                ),
                padVertical(10),
                // padVertical(20),
                // Skeleton(
                //   isLoading: controller.loading.value,
                //   skeleton: SkeletonLine(
                //     style: SkeletonLineStyle(
                //       width: double.infinity,
                //       height: 56,
                //       borderRadius: BorderRadius.circular(10),
                //     ),
                //   ),
                //   child: Row(
                //     children: [
                //       Expanded(
                //         child: commonButton(
                //           context: context,
                //           onPressed: () {
                //             // Add to cart and go to checkout
                //             if (controller.allMerchandise.value.data != null) {
                //               final product = controller.allMerchandise.value.data!;
                //               cartController.addToCart(CartItem(
                //                 productId: product.sId ?? '',
                //                 productName: product.productName ?? 'Product',
                //                 imageUrl: product.primaryImage != null ?
                //                   "$imageBaseUrl${product.primaryImage}" : AppAssets.rackettt,
                //                 price: product.actualPrice?.toDouble() ?? 0.0,
                //                 quantity: 1
                //               ));
                //               Get.to(() => const PgCartScreen());
                //             }
                //           },
                //           txt: "Buy It Now",
                //         ),
                //       ),
                //       padHorizontal(10),
                //       Obx(() {
                //         final productId = controller.allMerchandise.value.data?.sId ?? '';
                //         final quantity = cartController.getItemQuantity(productId);
                //
                //         return GestureDetector(
                //           onTap: () {
                //             // Add to cart
                //             if (controller.allMerchandise.value.data != null) {
                //               final product = controller.allMerchandise.value.data!;
                //               cartController.addToCart(CartItem(
                //                 productId: product.sId ?? '',
                //                 productName: product.productName ?? 'Product',
                //                 imageUrl: product.primaryImage != null ?
                //                   "$imageBaseUrl${product.primaryImage}" : AppAssets.rackettt,
                //                 price: product.actualPrice?.toDouble() ?? 0.0,
                //                 quantity: 1
                //               ));
                //             }
                //           },
                //           child: Container(
                //             height: 56,
                //             padding: const EdgeInsets.all(15),
                //             decoration: BoxDecoration(
                //               color: AppColors.primaryColor,
                //               borderRadius: BorderRadius.circular(10),
                //             ),
                //             child: Stack(
                //               children: [
                //                 const Icon(
                //                   Icons.shopping_cart,
                //                   color: AppColors.whiteColor,
                //                 ),
                //                 if (quantity > 0)
                //                   Positioned(
                //                     right: -5,
                //                     top: -5,
                //                     child: Container(
                //                       padding: const EdgeInsets.all(2),
                //                       decoration: BoxDecoration(
                //                         color: Colors.red,
                //                         borderRadius: BorderRadius.circular(6),
                //                       ),
                //                       constraints: const BoxConstraints(
                //                         minWidth: 12,
                //                         minHeight: 12,
                //                       ),
                //                       child: Text(
                //                         '$quantity',
                //                         style: const TextStyle(
                //                           color: Colors.white,
                //                           fontSize: 8,
                //                         ),
                //                         textAlign: TextAlign.center,
                //                       ),
                //                     ),
                //                   ),
                //               ],
                //             ),
                //           ),
                //         );
                //       }),
                //     ],
                //   ),
                // ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}
