import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class BigText extends HookWidget {
  final Color? color;
  final String text;
  double size;
  TextOverflow overflow;
  BigText({Key? key,
    required this.text,
    this.color = const Color(0xFF332d2b),
    this.size = 0,
    this.overflow = TextOverflow.ellipsis,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: 1, // to see overflow
      overflow: overflow,
      style: GoogleFonts.roboto(
        color: color,
        fontWeight: FontWeight.w400,
        fontSize: size==0?15.sp:size
      ),
    );
  }
}
