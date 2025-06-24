import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final class CustomAppTheme {
  //Screen
  static const double designWidth = 390;
  static const double designHeight = 844;
  //Default Padding
  static const double _leftRightPadding = 15;

  static const double leftRightPaddingLarge = 32;

  static const double leftRightContainerPadding = 16;

  static const double topBottomSmallPadding = 12;
  static const double _topBottomPadding = 16;
  //Left Padding
  static const double leftSmallPadding = 12;
  static const double leftMediumPadding = 16;
  //Top Padding
  static const double topSmallPadding = 16;
  static const double topMediumPadding = 20;
  static const double topLargePadding = 24;
  //Bottom Padding
  static const double bottomSmallPadding = 16;
  static const double bottomMediumPadding = 20;
  static const double bottomLargePadding = 24;

  static var paddingVertical =
      EdgeInsets.symmetric(vertical: _topBottomPadding.h);
  static var paddingHorizontal =
      EdgeInsets.symmetric(horizontal: _leftRightPadding.w);
  static var paddingHorizontalLarge =
      EdgeInsets.symmetric(horizontal: leftRightPaddingLarge.w);

  static var paddingHorizontalContainer =
      EdgeInsets.symmetric(horizontal: leftRightContainerPadding.w);
  static var paddingAll = EdgeInsets.symmetric(
      horizontal: leftRightContainerPadding.w, vertical: _topBottomPadding.w);

  //Shape
  static const double smallShape = 6;
  static const double mediumShape = 8;
  static const double largeShape = 32;

  // BottomSheet
  static double getBottomSheetHeight(BuildContext context) {
    return MediaQuery.sizeOf(context).height * 0.45;
  }

  //Button
  static final Size buttonSize = Size(328.w, 48.h);
  //Text
}
