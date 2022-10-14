import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:food_delivery_clean_arch/src/core/utils/app_colors.dart';
import 'package:food_delivery_clean_arch/src/core/utils/app_constants.dart';
import 'package:food_delivery_clean_arch/src/presentation/widgets/app_icon.dart';
import 'package:food_delivery_clean_arch/src/presentation/widgets/big_text.dart';
import 'package:food_delivery_clean_arch/src/presentation/widgets/small_text.dart';
import 'package:food_delivery_clean_arch/src/presentation/controllers/cart/cart_history_controller.dart';
import 'package:food_delivery_clean_arch/src/domain/entities/cart/cart_history.dart';

class CartHistoryPage extends HookWidget {
  const CartHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    CartHistoryController controller = Get.find<CartHistoryController>();
    List<CartHistory> cartHistoryList =
        controller.cartHistoryList.reversed.toList();
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 100.h,
            width: double.maxFinite,
            color: AppColors.mainColor,
            padding: EdgeInsets.only(top: 5.33.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(
                  text: "Cart History",
                  color: Colors.white,
                ),
                AppIcon(
                  icon: Icons.shopping_cart_outlined,
                  iconColor: AppColors.mainColor,
                  backgroundColor: AppColors.yellowColor,
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 20.h, left: 5.09.w, right: 5.09.w),
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView(
                  children: [
                    for (int i = 0; i < cartHistoryList.length; i++)
                      Container(
                        height: 120.h,
                        margin: EdgeInsets.only(bottom: 20.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            (() {
                              DateFormat f = DateFormat('yyyy/MM/dd hh:mm a');
                              String strTime = f.format(DateTime.parse(
                                  cartHistoryList[i].orderTime!));
                              return BigText(text: strTime);
                            }()),
                            SizedBox(
                              height: 10.h,
                            ),
                            // BigText(text: "05/02/2021"),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Wrap(
                                  direction: Axis.horizontal,
                                  children: List.generate(
                                      cartHistoryList[i].order!.length,
                                      (index) => index <= 2
                                          ? Container(
                                              height: 20.h * 4,
                                              width: 5.09.w * 4,
                                              margin: EdgeInsets.only(
                                                left: 5.w,
                                              ),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          7.5.r),
                                                  image: DecorationImage(
                                                      fit: BoxFit.cover,
                                                      image: NetworkImage(
                                                          AppConstants
                                                                  .BASE_URL +
                                                              cartHistoryList[i]
                                                                  .order![index]
                                                                  .img!))),
                                            )
                                          : Container()),
                                ),
                                SizedBox(
                                  height: 20.h * 4,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SmallText(
                                          text: 'Total',
                                          color: AppColors.titleColor),
                                      BigText(
                                        text:
                                            "${cartHistoryList[i].order!.length} Items",
                                        color: AppColors.titleColor,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w,
                                            vertical: 10.h / 2),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15.r / 3),
                                            border: Border.all(
                                                width: 1,
                                                color: AppColors.mainColor)),
                                        child: SmallText(
                                            text: "one more",
                                            color: AppColors.mainColor),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
