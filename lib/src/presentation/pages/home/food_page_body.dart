import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dots_indicator/dots_indicator.dart';

import 'package:food_delivery_clean_arch/src/config/app_colors.dart';
import 'package:food_delivery_clean_arch/src/config/app_constants.dart';
import 'package:food_delivery_clean_arch/src/config/route_helper.dart';
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
    final PopularProductController popularProductController = Get.find();
    final RecommendedProductController recommendedProductController =
        Get.find();
    final PageController pageController =
        usePageController(viewportFraction: 0.85);

    final currPageValue = useState(0.0);
    int numberPages = 0;
    const double scaleFactor = 0.8;
    final double height = 180.h;

int getNextPage(int currentPage){
    if(currentPage == numberPages-1) return 0;
    return currentPage +1;
  }

  void nextPage(){
    int nextPageIndex = getNextPage(pageController.page!.toInt());
    pageController.animateToPage(nextPageIndex, duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
  }
  
      useEffect(() {
      pageController.addListener(() {
        currPageValue.value = pageController.page!;
      });
        // Timer.periodic(const Duration(seconds: 2), (_) => nextPage());
       return;
    });

    Widget buildPageItem(int index, Product product) {
      Matrix4 matrix = Matrix4.identity();
      if (index == currPageValue.value.floor() - 1) {
        var currScale = scaleFactor;
        var currTrans = height * (1 - currScale) / 2;
        matrix = Matrix4.diagonal3Values(1, currScale, 1)
          ..setTranslationRaw(0, currTrans, 0);
      } else if (index == currPageValue.value.floor()) {
        var currScale = 1 - (currPageValue.value - index) * (1 - scaleFactor);
        var currTrans = height * (1 - currScale) / 2;
        matrix = Matrix4.diagonal3Values(1, currScale, 1)
          ..setTranslationRaw(0, currTrans, 0);
      } else if (index == currPageValue.value.floor() + 1) {
        var currScale =
            scaleFactor + (currPageValue.value - index + 1) * (1 - scaleFactor);
        var currTrans = height * (1 - currScale) / 2;
        matrix = Matrix4.diagonal3Values(1, currScale, 1)
          ..setTranslationRaw(0, currTrans, 0);
      } else {
        var currScale = scaleFactor;
        var currTrans = height * (1 - currScale) / 2;
        matrix = Matrix4.diagonal3Values(1, currScale, 1)
          ..setTranslationRaw(0, currTrans, 0);
      }
      return Transform(
        transform: matrix,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () =>
                  Get.toNamed(RouteHelper.getPopularFood(index, "home")),
              child: Container(
                height: 180.h,
                margin: EdgeInsets.only(left: 8.w, right: 8.w),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    color: index.isEven
                        ? const Color(0xFF69c5df)
                        : const Color(0xFF9294cc),
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            AppConstants.BASE_URL + product.img!))),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: 100.h,
                margin: EdgeInsets.only(
                    left: 30.w, right: 30.w, bottom: 10.h),
                padding:
                    EdgeInsets.only(top: 15.h, left: 10.w, right: 10.w),
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
                child: AppColumn(text: product.name!, size: 19.sp),
              ),
            ),
          ],
        ),
      );
    }
    return Column(
      children: [
        //slider section
        SizedBox(
          height: 250.h,
          child: popularProductController.obx(
              (state) {
                 numberPages = state?.length??0;  
                return SizedBox(
                    height: 320.h,
                    child: PageView.builder(
                        controller: pageController,
                        itemCount: state?.length,
                        itemBuilder: (context, index) {
                          return buildPageItem(index, state![index]);
                        }),
                  );
              },
              onLoading: CircularProgressIndicator(
                color: AppColors.mainColor,
              )),
        ),

        //dots
        popularProductController.obx((state) => DotsIndicator(
            dotsCount: state!.isNotEmpty ? state.length : 1,
            position: currPageValue.value,
            decorator: DotsDecorator(
              activeColor: AppColors.mainColor,
              size: Size.square(9.w),
              activeSize: Size(18.w, 9.h),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.r)),
            ))),

        //popular text
        SizedBox(
          height: 10.h,
        ),
        Container(
          // margin: EdgeInsets.only(left: 10.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              SizedBox(
                width: 5.w,
              ),
              Container(
                  margin: EdgeInsets.only(top: 5.h),
                  child: BigText(
                    text: '.',
                    color: Colors.black26,
                  )),
              SizedBox(
                width: 5.w,
              ),
              Container(
                  margin: EdgeInsets.only(top: 2.h),
                  child: SmallText(text: 'Food pairing'))
            ],
          ),
        ),
        //list of food and images
        recommendedProductController.obx(
            (state) => ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: state?.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => Get.toNamed(RouteHelper.getRecommendedFood(
                        index, "home")), //TODO: add route here
                    child: Container(
                      margin: EdgeInsets.only(
                        left: 5.09.w,
                        right: 5.09.w,
                        bottom: 10.h,
                      ),
                      child: Row(
                        children: [
                          //image section
                          Container(
                            width: 100.h,
                            height: 100.h,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.r),
                                color: Colors.white38,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(AppConstants.BASE_URL +
                                        state![index].img!))),
                          ),
                          //text container
                          Expanded(
                            child: Container(
                              height: 85.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20.r),
                                  bottomRight: Radius.circular(20.r),
                                ),
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: 2.54.w, right: 2.54.w),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BigText(
                                        text:
                                            // 'Nutritious fruit meal in China'
                                            state[index].name!),
                                    SizedBox(
                                      height: 10.h,
                                    ),
                                    SmallText(
                                        text: "With chinese characteristics"),
                                    SizedBox(
                                      height: 10.h,
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
                }),
            onLoading: CircularProgressIndicator(
              color: AppColors.mainColor,
            )),
      ],
    );
  }
}
