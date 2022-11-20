import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:food_delivery_clean_arch/src/config/app_colors.dart';
import 'small_text.dart';

class ExpandableTextWidget extends HookWidget {
  final String text;
  const ExpandableTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hiddenText = useState(true);
    String firstHalf = '';
    String secondHalf = '';
    
    double textHeight = 242.h;
    double smallTextHeight = 1.5.h;
    double smallTextSize = 15.sp;

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
              height: smallTextHeight,
              color: AppColors.paraColor,
              size: smallTextSize,
              text: firstHalf)
          : Column(
              children: [
                SmallText(
                    height: smallTextHeight,
                    color: AppColors.paraColor,
                    size: smallTextSize,
                    text: hiddenText.value
                        ? ("$firstHalf...")
                        : (firstHalf + secondHalf)),
                Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: InkWell(
                    onTap: toggleHiddenText,
                    child: Row(
                      children: [
                        SmallText(
                          size: smallTextSize,
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
                  ),
                )
              ],
            ),
    );
  }
}
