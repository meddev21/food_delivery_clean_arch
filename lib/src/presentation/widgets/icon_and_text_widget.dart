import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'small_text.dart';


class IconAndTextWidget extends HookWidget {
  final IconData icon;
  final String text;
  final Color iconColor;
  
  const IconAndTextWidget({Key? key, 
    required this.icon, 
    required this.text, 
    required this.iconColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor,size: 24.sp,),
        SizedBox(width: 5.w,),
        SmallText(text: text)
        
      ],
    );
  }
}
