import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import 'package:food_delivery_clean_arch/src/config/app_colors.dart';
import 'package:food_delivery_clean_arch/src/config/app_constants.dart';
import 'package:food_delivery_clean_arch/src/domain/entities/cart/cart_history.dart';
import 'package:food_delivery_clean_arch/src/presentation/widgets/big_text.dart';
import 'package:food_delivery_clean_arch/src/presentation/widgets/small_text.dart';

class CartHistoryBody extends HookWidget {
  const CartHistoryBody(this.item, {super.key});

  final CartHistory item;

  @override
  Widget build(BuildContext context) {
    return Container(
                        height: 120.h,
                        margin: EdgeInsets.only(bottom: 20.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            (() {
                              DateFormat f = DateFormat('yyyy/MM/dd hh:mm a');
                              String strTime = f.format(DateTime.parse(
                                  item.orderTime!));
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
                                      item.order!.length,
                                      (index) => index <= 2
                                          ? Container(
                                              height: 70.h,
                                              width: 70.h,
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
                                                              item
                                                                  .order![index]
                                                                  .img!))),
                                            )
                                          : Container()),
                                ),
                                SizedBox(
                                  height: 80.h,
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
                                            "${item.order!.length} Items",
                                        color: AppColors.titleColor,
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w,
                                            vertical: 5.h),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5.r),
                                            border: Border.all(
                                                width: 1.w,
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
                      );
  }
}