import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:food_delivery_clean_arch/gen/assets.gen.dart';
import 'package:food_delivery_clean_arch/src/config/route_helper.dart';
// TODO: this for load resource
import 'package:food_delivery_clean_arch/src/presentation/controllers/index_controller.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({super.key});

  // TODO: apply load resources later
  // Future<void> _loadResources() async{
  //   await Get.find<PopularProductController>().getPopularProductList();
  //   await Get.find<RecommendedProductController>().getRecommendedProductList();
  // }

  @override
  Widget build(BuildContext context) {
    AnimationController animationController = useAnimationController(
        duration: const Duration(seconds: 2), initialValue: 1)
      ..forward();
    Animation<double> animation =
        CurvedAnimation(parent: animationController, curve: Curves.linear);
    // in place of iniState in statefullWidget
    useEffect(() {
      Timer(const Duration(seconds: 3),
          () => Get.offAllNamed(RouteHelper.getInitial()));
      return null;
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: animation,
            child:
                Center(child: Assets.images.png.logoFood.image(width: 250.h)),
          ),
        ],
      ),
    );
  }
}
