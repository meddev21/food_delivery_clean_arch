import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:food_delivery_clean_arch/src/config/app_colors.dart';
import 'package:food_delivery_clean_arch/src/config/app_constants.dart';
import 'package:food_delivery_clean_arch/src/config/route_helper.dart';
import 'package:food_delivery_clean_arch/src/domain/entities/product.dart';
import 'package:food_delivery_clean_arch/src/presentation/widgets/app_icon.dart';
import 'package:food_delivery_clean_arch/src/presentation/widgets/big_text.dart';
import 'package:food_delivery_clean_arch/src/presentation/widgets/app_column.dart';
import 'package:food_delivery_clean_arch/src/presentation/widgets/expandable_text_widget.dart';
import 'package:food_delivery_clean_arch/src/presentation/controllers/popular_product_controller.dart';


class PopularFoodDetail extends HookWidget {
  final int pageId;
  final String page;
  const PopularFoodDetail({Key? key, required this.pageId, required this.page}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    PopularProductController controller = Get.find();
    Product product =  controller.popularProducts[pageId];
    controller.initProduct(pageId);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              child: CachedNetworkImage(
                imageUrl: AppConstants.BASE_URL +  product.img!,
                imageBuilder: (context, imageProvider) => Container(
                  width: double.maxFinite,
                  height: 0.4.sh,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                  ),
                ),
                placeholder: (context, url) => const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
          ),
          //icon widgets
          Positioned(
              top:  5.33.h,
              left: 5.09.w,
              right: 5.09.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap:() {
                        if(page == "cart-page"){
                          Get.toNamed(RouteHelper.cartPage);
                        }else{
                          Get.toNamed(RouteHelper.initial);
                        }
                      },
                      child: AppIcon(icon:Icons.arrow_back_ios)),
                  GestureDetector(
                          onTap:() => controller.totalItems>0?Get.toNamed(RouteHelper.getCartPage()):null,
                           child: Stack(
                             children: [
                               AppIcon(icon:Icons.shopping_cart_outlined),
                               Visibility(
                                 visible: controller.totalItems>0,
                                 child: Positioned(
                                   right: 0,top: 0,
                                     child:
                                  Stack(
                                    children: [
                                      AppIcon(icon: Icons.circle, size: 20.sp,
                                        iconColor: Colors.transparent, backgroundColor: AppColors.mainColor,
                                      ),
                                      Positioned(
                                          right: controller.totalItems.toString().length==1?
                                          5.w:2.w,
                                          top: 1.h,
                                          child: BigText(
                                            text:controller.totalItems.toString(),
                                            size: 14.sp, color: Colors.white,))
                                    ],
                                  )
                                 ),
                               )
                             ],
                           ),
                         ),
                ],
              )
          ),
          //introduction of food
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: 0.38.sh,
              child: Container(
                padding: EdgeInsets.only(
                    left: 5.09.w,
                    right: 5.09.w,
                    top: 20.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(20.r),
                    topLeft: Radius.circular(20.r),
                  ),
                  color: Colors.white
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text:
                    // "Chinese Side"
                    product.name!
                      ,size: 26.sp,),
                    SizedBox(height: 20.h,),
                    BigText(text: "Introduce",),
                    SizedBox(height: 20.h,),
                    //expandable text widget
                    Expanded(
                      child: NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (overScroll){
                          overScroll.disallowIndicator();
                          return false;
                        },
                        child: SingleChildScrollView(
                        child: ExpandableTextWidget(
                            // text: "dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet. Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,"
                            text: product.description!,
                        ),
                      ),
                    ),)
                  ],
                ),
              )
          ),
        ],
      ),
      bottomNavigationBar: Container(
            height: 0.14.sh,
            padding: EdgeInsets.only(
                top: 30.h,
                bottom: 30.h,
                left: 5.09.w,
                right: 5.09.w
            ),
            decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r*2),
                  topRight: Radius.circular(20.r*2),
                )
            ),
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
                      GestureDetector(
                          onTap: ()=> controller.setQuantity(false),
                          child: Icon(Icons.remove, color: AppColors.signColor)),
                      SizedBox(width: 5.w,),
                      SizedBox(
                        width: 22.5.w,
                          child: Center(child: BigText(text: '${controller.inCartItems}'))),
                      SizedBox(width: 5.w,),
                      GestureDetector(
                          onTap: ()=> controller.setQuantity(true),
                          child: Icon(Icons.add, color: AppColors.signColor)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: controller.addItem,
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
                        child: BigText(text:'\$ ${product.price} |  Add to cart', color: Colors.white,),
                  ),
                )
              ],
            ),
          ),
    );
  }
}