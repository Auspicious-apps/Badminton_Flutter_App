import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Needed for input formatters
import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/constants/app_const.dart';

Widget commonTxtField({
  required String hTxt,
  TextEditingController? controller,
  TextInputType keyboardType = TextInputType.text,
  bool obscureText = false,
  Widget? suffixIcon,
  int? maxLength,
  List<TextInputFormatter>? inputFormatters,
  double height = 50.0,
  bool enabled = true, // New parameter with default value false
}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    height: height,
    decoration: BoxDecoration(
      color: AppColors.whiteColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hTxt,
              hintStyle: const TextStyle(
                color: AppColors.smalltxt,
                fontFamily: AppConst.fontFamily,
                fontWeight: FontWeight.w500,
              ),
              counterText: '', // Hide the counter text below input field
            ),
            style: const TextStyle(
              color: AppColors.blackColor,
              fontFamily: AppConst.fontFamily,
              fontWeight: FontWeight.w500,
            ),
            keyboardType: keyboardType,
            obscureText: obscureText,
            maxLength: maxLength,
            inputFormatters: inputFormatters,
            enabled: enabled, // Apply the enabled parameter
          ),
        ),
        if (suffixIcon != null) suffixIcon,
      ],
    ),
  );
}