import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:food_delivery_clean_arch/src/config/app_colors.dart';
import 'big_text.dart';
import 'small_text.dart';
import 'icon_and_text_widget.dart';

// ignore: must_be_immutable
class AppColumn extends HookWidget {
  final String text;
  double? size;

  AppColumn({Key? key, required this.text, this.size}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(
          text: text,
          size: size!,
        ),
        SizedBox(
          height: 10.h,
        ),
        Row(
          children: [
            Wrap(
              children: List.generate(
                  5,
                      (index) => Icon(
                    Icons.star,
                    color: AppColors.mainColor,
                    size: 15.sp,
                  )),
            ),
            SizedBox(
              width: 10.w,
            ),
            SmallText(text: "4.5"),
            SizedBox(
              width: 10.w,
            ),
            SmallText(text: "1287"),
            SizedBox(
              width: 10.w,
            ),
            SmallText(text: "comments"),
          ],
        ),
        SizedBox(
          height: 20.h,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndTextWidget(
              icon: Icons.circle_sharp,
              text: "Normal",
              iconColor: AppColors.iconColor1,
            ),
            IconAndTextWidget(
              icon: Icons.location_on,
              text: "1.7km",
              iconColor: AppColors.mainColor,
            ),
            IconAndTextWidget(
              icon: Icons.access_time_rounded,
              text: "32min",
              iconColor: AppColors.iconColor2,
            ),
          ],
        )
      ],
    );
  }
}
