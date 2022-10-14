import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dots_indicator/dots_indicator.dart';

import 'package:food_delivery_clean_arch/src/core/utils/app_colors.dart';
import 'package:food_delivery_clean_arch/src/core/utils/app_constants.dart';
import 'package:food_delivery_clean_arch/src/core/utils/route_helper.dart';
import 'package:food_delivery_clean_arch/src/domain/entities/product.dart';
import 'package:food_delivery_clean_arch/src/presentation/controllers/index_controller.dart';
import 'package:food_delivery_clean_arch/src/presentation/widgets/big_text.dart';
import 'package:food_delivery_clean_arch/src/presentation/widgets/small_text.dart';
import 'package:food_delivery_clean_arch/src/presentation//widgets/icon_and_text_widget.dart';
import 'package:food_delivery_clean_arch/src/presentation//widgets/app_column.dart';

class FoodPageBody extends HookWidget {
  const FoodPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final PageController pageController =
        usePageController(viewportFraction: 0.85);

    final currPageValue = useState(0.0);
    const double scaleFactor = 0.8;
    final double height = 26.04.h;

    useEffect(() {
      pageController.addListener(() {
        currPageValue.value = pageController.page!;
      });
      return () {
        pageController.dispose();
      };
    });

    return Column(
      children: [
        //slider section
        GetBuilder<PopularProductController>(
            builder: (popularProducts) => popularProducts.isLoaded
                ? SizedBox(
                    height: Dimensions.pageView,
                    child: PageView.builder(
                        controller: pageController,
                        itemCount: popularProducts.popularProductList.length,
                        itemBuilder: (context, index) {
                          return _buildPageItem(
                              index, popularProducts.popularProductList[index]);
                        }),
                  )
                : CircularProgressIndicator(
                    color: AppColors.mainColor,
                  )),
        //dots
        GetBuilder<PopularProductController>(
            builder: (popularProducts) => DotsIndicator(
                  dotsCount: popularProducts.popularProductList.isNotEmpty
                      ? popularProducts.popularProductList.length
                      : 1,
                  position: currPageValue,
                  decorator: DotsDecorator(
                    activeColor: AppColors.mainColor,
                    size: const Size.square(9.0),
                    activeSize: const Size(18.0, 9.0),
                    activeShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0.sp)),
                  ),
                )),
        //popular text
        SizedBox(
          height: 3.63.h,
        ),
        Container(
          margin: EdgeInsets.only(left: 3.63.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              SizedBox(
                width: 2.54.w,
              ),
              Container(
                  margin: EdgeInsets.only(top: Dimensions.height3),
                  child: BigText(
                    text: '.',
                    color: Colors.black26,
                  )),
              SizedBox(
                width: 2.54.w,
              ),
              Container(
                  margin: EdgeInsets.only(top: Dimensions.height2),
                  child: SmallText(text: 'Food pairing'))
            ],
          ),
        ),
        //list of food and images
        GetBuilder<RecommendedProductController>(
            builder: (recommendedProduct) => recommendedProduct.isLoaded
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: recommendedProduct.recommendedProductList.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => Get.toNamed(
                            RouteHelper.getRecommendedFood(index, "home")),
                        child: Container(
                          margin: EdgeInsets.only(
                            left: 5.09.w,
                            right: 5.09.w,
                            bottom: Dimensions.height10,
                          ),
                          child: Row(
                            children: [
                              //image section
                              Container(
                                width: Dimensions.listViewImgSize,
                                height: Dimensions.listViewImgSize,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius20),
                                    color: Colors.white38,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(AppConstants
                                                .BASE_URL +
                                            recommendedProduct
                                                .recommendedProductList[index]
                                                ?.img)
                                        // AssetImage(
                                        //     "assets/images/food1.jpg"
                                        // ),
                                        )),
                              ),
                              //text container
                              Expanded(
                                child: Container(
                                  height: Dimensions.listViewTextContSize,
                                  // width: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topRight:
                                          Radius.circular(Dimensions.radius20),
                                      bottomRight:
                                          Radius.circular(Dimensions.radius20),
                                    ),
                                    color: Colors.white,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 2.54.w, right: 2.54.w),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        BigText(
                                            text:
                                                // 'Nutritious fruit meal in China'
                                                recommendedProduct
                                                    .recommendedProductList[
                                                        index]
                                                    .name),
                                        SizedBox(
                                          height: Dimensions.height10,
                                        ),
                                        SmallText(
                                            text:
                                                "With chinese characteristics"),
                                        SizedBox(
                                          height: Dimensions.height10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
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
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    })
                : CircularProgressIndicator(
                    color: AppColors.mainColor,
                  ))
      ],
    );
  }

  Widget _buildPageItem(int index, Product product) {
    Matrix4 matrix = Matrix4.identity();
    if (index == _currPageValue.floor() - 1) {
      var currScale = _scaleFactor;
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - index) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (index == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - index + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = _scaleFactor;
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    }
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap: () => Get.toNamed(RouteHelper.getPopularFood(index, "home")),
            child: Container(
              height: 26.04.h,
              margin: EdgeInsets.only(left: 2.54.w, right: 2.54.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius30),
                  color: index.isEven
                      ? const Color(0xFF69c5df)
                      : const Color(0xFF9294cc),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image:
                          NetworkImage(AppConstants.BASE_URL + product.img!))),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 14.22.h,
              margin:
                  EdgeInsets.only(left: 7.63.w, right: 7.63.w, bottom: 3.63.h),
              padding:
                  EdgeInsets.only(top: 1.81.h, left: 3.81.w, right: 3.81.w),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.sp),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0, 5),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: 1.0,
                      offset: Offset(-5, 0),
                    ),
                    BoxShadow(
                      color: Colors.white,
                      blurRadius: 1.0,
                      offset: Offset(5, 0),
                    ),
                  ]),
              child: AppColumn(text: product.name!, size: 18.sp),
            ),
          ),
        ],
      ),
    );
  }
}
