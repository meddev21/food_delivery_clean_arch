import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class SmallText extends HookWidget {
  final Color? color;
  final String text;
  double size;
  double height;// space between lines
  SmallText({Key? key,
    required this.text,
    this.color = const Color(0xFFccc7c5),
    this.size = 0,
    this.height = 1.2
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.roboto(
          color: color,
          fontSize: size==0?12.sp:size,
          height: height
      ),
    );
  }
}
