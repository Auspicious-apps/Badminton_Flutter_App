import 'package:badminton/Pages/ProductDetail/pg_product_detail.dart';
import 'package:badminton/app_settings/components/label.dart';
import 'package:badminton/app_settings/constants/app_assets.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/constants/app_dim.dart';
import 'package:flutter/material.dart';

import '../../../repository/endpoint.dart';

// Product Card Widget
class ProductCard extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final String oldPrice;
  final VoidCallback onImageTap;
  final VoidCallback onCartTap;
  final int quantity; // Add this parameter

  const ProductCard({
    Key? key,
    required this.image,
    required this.name,
    required this.price,
    required this.oldPrice,
    required this.onImageTap,
    required this.onCartTap,
    this.quantity = 0, // Default to 0
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2),
      decoration: BoxDecoration(
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)],
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: onImageTap,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                  ),
                  child: image.isNotEmpty
                      ? Image.network(
                          "$imageBaseUrl$image",
                          height: 130,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              AppAssets.rackettt,
                              height: 130,
                              width: double.infinity,
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Label(
                      txt: name,
                      type: TextTypes.f_14_600,
                      maxLines: 1,
                    ),
                    padVertical(5),
                    Row(
                      children: [
                        Label(
                          txt: "₹$price",
                          type: TextTypes.f_14_600,
                          forceColor: AppColors.primaryColor,
                        ),
                        padHorizontal(5),
                        if (oldPrice.isNotEmpty && oldPrice != "null")
                          Label(
                            txt: "₹$oldPrice",
                            type: TextTypes.f_12_400,
                            forceColor: AppColors.smalltxt,
                            // decoration: TextDecoration.lineThrough,
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 5,
            right: 5,
            child: GestureDetector(
              onTap: onCartTap,
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
                  if (quantity > 0)
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
                          '$quantity',
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
        ],
      ),
    );
  }
}
