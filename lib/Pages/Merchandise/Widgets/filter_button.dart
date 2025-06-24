import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final double? width;
  final VoidCallback? onTap; // Add onTap callback

  const FilterButton({
    Key? key,
    required this.label,
    this.isSelected = false,
    this.width,
    this.onTap, // Include onTap in constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap, // Handle tap event
      child: Container(
        width: width,
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryColor : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: AppColors.primaryColor),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? AppColors.whiteColor : AppColors.primaryColor,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}