import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:food_delivery_clean_arch/src/core/utils/app_colors.dart';
import 'package:food_delivery_clean_arch/src/core/utils/app_constants.dart';
import 'package:food_delivery_clean_arch/src/core/utils/route_helper.dart';
import 'package:food_delivery_clean_arch/src/presentation/controllers/index_controller.dart';
import 'package:food_delivery_clean_arch/src/presentation/widgets/app_icon.dart';
import 'package:food_delivery_clean_arch/src/presentation/widgets/big_text.dart';
import 'package:food_delivery_clean_arch/src/presentation/widgets/small_text.dart';

class CartPage extends HookWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 60.h,
            right: 5.09.w,
            left: 5.09.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                    onTap: () => Get.toNamed(RouteHelper.initial),
                    // onTap:() => Get.back(),
                    child: AppIcon(
                      icon: Icons.arrow_back_ios,
                      iconColor: Colors.white,
                      iconSize: 24.sp,
                      backgroundColor: AppColors.mainColor,
                    )),
                SizedBox(
                  width: 25.5.w,
                ),
                GestureDetector(
                    onTap: () => Get.toNamed(RouteHelper.initial),
                    child: AppIcon(
                      icon: Icons.home_outlined,
                      iconColor: Colors.white,
                      iconSize: 24.sp,
                      backgroundColor: AppColors.mainColor,
                    )),
              ],
            ),
          ),
          Positioned(
              top: 100.h,
              //start widget
              bottom: 40.h,
              // end widget
              left: 5.09.w,
              right: 5.09.w,
              child: Container(
                margin: EdgeInsets.only(top: 15.h),
                child: NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (overScroll) {
                    overScroll.disallowIndicator();
                    return false;
                  },
                  child: MediaQuery.removePadding(
                    context: context,
                    removeTop: true,
                    child: GetBuilder<CartController>(
                      builder: (cartController) {
                        var _cartList = cartController.getItems;
                        // _cartList = [];
                        return ListView.builder(
                            itemCount: _cartList.length,
                            itemBuilder: (context, index) => Container(
                                  height: 100.h,
                                  width: double.maxFinite,
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          var popularIndex = Get.find<
                                                  PopularProductController>()
                                              .popularProduct
                                              .indexOf(
                                                  _cartList[index].product!);
                                          if (popularIndex >= 0) {
                                            Get.toNamed(
                                                RouteHelper.getPopularFood(
                                                    popularIndex, "cart-page"));
                                          } else {
                                            var recommendedIndex = Get.find<
                                                    RecommendedProductController>()
                                                .recommandedProduct
                                                .indexOf(
                                                    _cartList[index].product!);
                                            Get.toNamed(
                                                RouteHelper.getRecommendedFood(
                                                    recommendedIndex,
                                                    "cart-page"));
                                          }
                                        },
                                        child: Container(
                                          width: 100.h,
                                          height: 100.h,
                                          margin: EdgeInsets.only(bottom: 10.h),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20.r),
                                              image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      AppConstants.BASE_URL +
                                                          _cartList[index]
                                                              .img!))),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Expanded(
                                          child: SizedBox(
                                        height: 100.h,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            BigText(
                                              text: _cartList[index].name!,
                                              color: Colors.black54,
                                            ),
                                            SmallText(text: 'Spicy'),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                BigText(
                                                  text:
                                                      "\$ ${_cartList[index].price!}",
                                                  color: Colors.redAccent,
                                                ),
                                                Container(
                                                  padding: EdgeInsets.only(
                                                    top: 10.h,
                                                    bottom: 10.h,
                                                    left: 5.09.w,
                                                    right: 5.09.w,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.r),
                                                    color: Colors.white,
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                          onTap: () =>
                                                              cartController.addItem(
                                                                  _cartList[
                                                                          index]
                                                                      .product!,
                                                                  -1),
                                                          child: Icon(
                                                              Icons.remove,
                                                              color: AppColors
                                                                  .signColor)),
                                                      SizedBox(
                                                        width: 10.w / 2,
                                                      ),
                                                      Container(
                                                          width: 45.w / 2,
                                                          child: Center(
                                                              child: BigText(
                                                                  text:
                                                                      '${cartController.getItems[index].quantity!}'))),
                                                      SizedBox(
                                                        width: 10.w / 2,
                                                      ),
                                                      GestureDetector(
                                                          onTap: () =>
                                                              cartController.addItem(
                                                                  _cartList[
                                                                          index]
                                                                      .product!,
                                                                  1),
                                                          child: Icon(Icons.add,
                                                              color: AppColors
                                                                  .signColor)),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                ));
                      },
                    ),
                  ),
                ),
              ))
        ],
      ),
      bottomNavigationBar: GetBuilder<CartController>(
          builder: (cartController) => Container(
                height: 120.h,
                padding: EdgeInsets.only(
                    top: 30.h, bottom: 30.h, left: 5.09.w, right: 5.09.w),
                decoration: BoxDecoration(
                    color: AppColors.buttonBackgroundColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.r),
                      topRight: Radius.circular(40.r),
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        top: 20.h,
                        bottom: 20.h,
                        left: 5.09.w,
                        right: 5.09.w,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.r),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 5.w,
                          ),
                          SizedBox(
                              width: 100.w,
                              child: Center(
                                  child: BigText(
                                      text:
                                          '\$ ${cartController.totalAmount}'))),
                          SizedBox(
                            width: 5.w,
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      // onTap: ()=>popularProduct.addItem(product),
                      onTap: () => cartController.saveToHistory(),
                      child: Container(
                        padding: EdgeInsets.only(
                          top: 20.h,
                          bottom: 20.h,
                          left: 5.09.w,
                          right: 5.09.w,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          color: AppColors.mainColor,
                        ),
                        child: BigText(
                          text: 'Check out',
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              )),
    );
  }
}
