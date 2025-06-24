import 'package:badminton/app_settings/components/label.dart';
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:flutter/material.dart';

Widget commonButton({
  VoidCallback? onPressed,
  String? txt,
  BuildContext? context,
  Color? forceColor,
  bool? arrow,
  bool loading = false, // ✅ New parameter
}) {
  return SizedBox(
    height: 56,
    child: ElevatedButton(
      onPressed: loading ? null : onPressed, // Disable when loading
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 10),
        elevation: 0.0,
        backgroundColor: forceColor ?? AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: loading
          ? const SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.whiteColor),
        ),
      )
          : arrow == true
          ? const Icon(
        Icons.arrow_forward,
        color: AppColors.whiteColor,
      )
          : Label(
        txt: txt ?? '',
        type: TextTypes.f_16_600,
        forceColor: AppColors.whiteColor,
      ),
    ),
  );
}
