import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:food_delivery_clean_arch/src/config/app_colors.dart';
import 'package:food_delivery_clean_arch/src/presentation/widgets/app_icon.dart';
import 'package:food_delivery_clean_arch/src/presentation/widgets/big_text.dart';
import 'package:food_delivery_clean_arch/src/presentation/controllers/cart/cart_history_controller.dart';
import 'cart_history_body.dart';

class CartHistoryPage extends HookWidget {
  const CartHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    CartHistoryController controller = Get.find<CartHistoryController>();
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 80.h,
            width: double.maxFinite,
            color: AppColors.mainColor,
            padding: EdgeInsets.only(bottom: 8.h),
            child: Align(
              alignment: Alignment.bottomCenter,
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
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child:controller.obx(
                  (state) => ListView.builder(
                    itemCount: state?.length,
                    itemBuilder: (context, index) =>
                      CartHistoryBody(state![index])
                    )
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}
