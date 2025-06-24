import 'package:flutter/material.dart';

SizedBox padVertical([int defaultVal = 5]) {
  return SizedBox(height: defaultVal.toDouble());
}

SizedBox padHorizontal(int pad) {
  return SizedBox(width: pad.toDouble());
}

SizedBox emptyView() {
  return const SizedBox();
}
