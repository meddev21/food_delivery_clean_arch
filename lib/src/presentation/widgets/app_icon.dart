import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class AppIcon extends HookWidget {
  final Color backgroundColor;
  final IconData icon;
  final Color iconColor;
  double? size;
  double? iconSize;
  AppIcon({
    Key? key,
    this.backgroundColor=const Color(0xFFfcf4e4),
    required this.icon,
    this.iconColor=const Color(0xFF756d54),
    this.iconSize,
    this.size
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    size ??= 40.w;
    iconSize ??= 16.sp;
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular((size!/2)),
        color: backgroundColor
      ),
      child: Icon(
        icon,
        color: iconColor,
        size: iconSize,
      ),
    );
  }
}
