import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:sizer/sizer.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/app_column.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/expandable_text_widget.dart';
import 'package:food_delivery/controllers/popular_product_controller.dart';
import 'package:food_delivery/controllers/cart_controller.dart';
import 'package:food_delivery/models/products_model.dart';
import 'package:food_delivery/routes/route_helper.dart';

class PopularFoodDetail extends StatelessWidget {
  final int pageId;
  final String page;
  PopularFoodDetail({Key? key, required this.pageId, required this.page}) : super(key: key);

  late PopularProductController controller;
  late CartController cartController;
  late ProductModel product;
  @override
  Widget build(BuildContext context) {
    controller = Get.find();
    cartController = Get.find();
    ProductModel product =  controller.popularProductList[pageId];
    controller.initProduct(
        product,
        cartController);
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
                  height: Dimensions.popularFoodImgSize,
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
                  GetBuilder<PopularProductController>(
                      builder: (controller)
                      => GestureDetector(
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
                                      AppIcon(icon: Icons.circle, size: Dimensions.iconSize20,
                                        iconColor: Colors.transparent, backgroundColor: AppColors.mainColor,
                                      ),
                                      Positioned(
                                          right: controller.totalItems.toString().length==1?
                                          Dimensions.width5:Dimensions.width2,
                                          top: Dimensions.height1,
                                          child: BigText(
                                            text:controller.totalItems.toString(),
                                            size: Dimensions.font14, color: Colors.white,))
                                    ],
                                  )
                                 ),
                               )
                             ],
                           ),
                         )
                        )
                ],
              )
          ),
          //introduction of food
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.popularFoodImgSize -20,
              child: Container(
                padding: EdgeInsets.only(
                    left: 5.09.w,
                    right: 5.09.w,
                    top: Dimensions.height20,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(Dimensions.radius20),
                    topLeft: Radius.circular(Dimensions.radius20),
                  ),
                  color: Colors.white
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppColumn(text:
                    // "Chinese Side"
                    product.name!
                      ,size: Dimensions.font26,),
                    SizedBox(height: Dimensions.height20,),
                    BigText(text: "Introduce",),
                    SizedBox(height: Dimensions.height20,),
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
      bottomNavigationBar: GetBuilder<PopularProductController>(
          builder: (popularProduct) =>Container(
            height: Dimensions.bottomHeightBar,
            padding: EdgeInsets.only(
                top: Dimensions.height30,
                bottom: Dimensions.height30,
                left: 5.09.w,
                right: 5.09.w
            ),
            decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20*2),
                  topRight: Radius.circular(Dimensions.radius20*2),
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(
                    top: Dimensions.height20,
                    bottom: Dimensions.height20,
                    left: 5.09.w,
                    right: 5.09.w,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                          onTap: ()=> popularProduct.setQuantity(false),
                          child: Icon(Icons.remove, color: AppColors.signColor)),
                      SizedBox(width: Dimensions.width10/2,),
                      Container(
                        width: Dimensions.width45/2,
                          child: Center(child: BigText(text: '${popularProduct.inCartItems}'))),
                      SizedBox(width: Dimensions.width10/2,),
                      GestureDetector(
                          onTap: ()=> popularProduct.setQuantity(true),
                          child: Icon(Icons.add, color: AppColors.signColor)),
                    ],
                  ),
                ),
                GestureDetector(
                  onTap: ()=>popularProduct.addItem(product),
                  child: Container(
                    padding: EdgeInsets.only(
                      top: Dimensions.height20,
                      bottom: Dimensions.height20,
                      left: 5.09.w,
                      right: 5.09.w,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                      color: AppColors.mainColor,
                    ),
                        child: BigText(text:'\$ ${product.price} |  Add to cart', color: Colors.white,),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}