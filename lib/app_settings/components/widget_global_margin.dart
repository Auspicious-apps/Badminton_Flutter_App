import 'package:flutter/material.dart';

class WidgetGlobalMargin extends StatelessWidget {
  final Widget child;

  const WidgetGlobalMargin({super.key, required this.child});
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.only(left: 15, right: 15), child: child);
  }
}
