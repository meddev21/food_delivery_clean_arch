import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:food_delivery_clean_arch/src/core/utils/app_colors.dart';
import 'small_text.dart';

class ExpandableTextWidget extends HookWidget {
  final String text;
  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hiddenText = useState(true);
    String firstHalf = '';
    String secondHalf = '';

    double textHeight = 150.h;

    void toggleHiddenText() {
      hiddenText.value = !hiddenText.value;
    }

    useEffect(() {
      if (text.length > textHeight) {
        firstHalf = text.substring(0, textHeight.toInt());
        secondHalf = text.substring(textHeight.toInt() + 1, text.length);
      } else {
        firstHalf = text;
        secondHalf = '';
      }
    });

    return Container(
      child: secondHalf.isEmpty
          ? SmallText(
              height: 1.8.h,
              color: AppColors.paraColor,
              size: 16.sp,
              text: firstHalf)
          : Column(
              children: [
                SmallText(
                    height: 1.8.h,
                    color: AppColors.paraColor,
                    size: 16.sp,
                    text: hiddenText.value
                        ? ("$firstHalf...")
                        : (firstHalf + secondHalf)),
                InkWell(
                  onTap: toggleHiddenText,
                  child: Row(
                    children: [
                      SmallText(
                        size: 16.sp,
                        text: hiddenText.value ? "Show more" : "Show less",
                        color: AppColors.mainColor,
                      ),
                      Icon(
                        hiddenText.value
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                        color: AppColors.mainColor,
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
