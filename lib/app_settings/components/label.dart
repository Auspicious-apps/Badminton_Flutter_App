import 'package:badminton/app_settings/constants/app_colors.dart';
import 'package:badminton/app_settings/constants/app_const.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  const Label({
    super.key,
    required this.txt,
    required this.type,
    this.forceAlignment = TextAlign.start,
    this.scale,
    this.forceColor = AppColors.blackColor,
    this.maxLines=null,
  });
  final String txt;
  final TextTypes type;
  final Color forceColor;
  final TextAlign forceAlignment;
  final TextScaler? scale;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      textScaler: scale,
      overflow: TextOverflow.ellipsis,
      textAlign: forceAlignment,
      maxLines: maxLines??null,
      style: fontStyle(),
    );
  }

  TextStyle fontStyle() {
    FontWeight weight = FontWeight.normal;
    double size = 11.0;
    FontStyle fontStyle = FontStyle.normal;
    TextDecoration decoration = TextDecoration.none;

    switch (type) {
      case TextTypes.f_14_400:
        weight = FontWeight.w400;
        size = 14.sp;
        decoration = TextDecoration.none;
        break;
      case TextTypes.f_18_600:
        weight = FontWeight.w600;
        size = 18.sp;
        decoration = TextDecoration.none;
        break;
      case TextTypes.f_30_700:
        weight = FontWeight.w700;
        size = 30.sp;
        decoration = TextDecoration.none;
        break;
      case TextTypes.f_12_400:
        weight = FontWeight.w400;
        size = 12.sp;
        decoration = TextDecoration.none;
        break;
      case TextTypes.f_12_500:
        weight = FontWeight.w500;
        size = 12.sp;
        decoration = TextDecoration.none;
        break;
      case TextTypes.f_10_600:
        weight = FontWeight.w600;
        size = 10.sp;
        decoration = TextDecoration.none;
        break;
      case TextTypes.f_12_700:
        weight = FontWeight.w700;
        size = 12.sp;
        decoration = TextDecoration.none;
        break;
      case TextTypes.f_16_600:
        weight = FontWeight.w600;
        size = 16.sp;
        decoration = TextDecoration.none;
        break;
      case TextTypes.f_8_400:
        weight = FontWeight.w400;
        size = 8.sp;
        decoration = TextDecoration.none;
        break;
      case TextTypes.f_14_700:
        weight = FontWeight.w700;
        size = 14.sp;
        decoration = TextDecoration.none;
        break;
      case TextTypes.f_10_400:
        weight = FontWeight.w400;
        size = 10.sp;
        decoration = TextDecoration.none;
        break;
      case TextTypes.f_20_600:
        weight = FontWeight.w600;
        size = 20.sp;
        decoration = TextDecoration.none;
        break;
      case TextTypes.f_14_500:
        weight = FontWeight.w500;
        size = 14.sp;
        decoration = TextDecoration.none;
        break;
      case TextTypes.f_20_400:
        weight = FontWeight.w400;
        size = 20.sp;
        decoration = TextDecoration.none;
        break;
      case TextTypes.f_18_700:
        weight = FontWeight.w700;
        size = 18.sp;
        decoration = TextDecoration.none;
        break;
      case TextTypes.f_14_600:
        weight = FontWeight.w600;
        size = 14.sp;
        decoration = TextDecoration.none;
        break;
      case TextTypes.f_20_900:
        weight = FontWeight.w500;
        size = 16.sp;
        decoration = TextDecoration.none;
        break;
    }

    return TextStyle(
      color: forceColor,
      fontFamily: AppConst.fontFamily,
      fontWeight: weight,
      fontStyle: fontStyle,
      decoration: decoration,
      fontSize: size,
    );
  }
}

enum TextTypes {
  f_14_400,
  f_18_600,
  f_30_700,
  f_12_400,
  f_12_500,
  f_10_400,
  f_10_600,
  f_12_700,
  f_16_600,
  f_8_400,
  f_14_700,
  f_20_600,
  f_20_400,
  f_14_500,
  f_14_600,
  f_18_700,
  f_20_900
}