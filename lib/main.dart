
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:food_delivery_clean_arch/src/config/dependency.dart';
import 'package:food_delivery_clean_arch/src/config/route_helper.dart';
import 'package:food_delivery_clean_arch/src/presentation/controllers/popular_product_controller.dart';
import 'package:food_delivery_clean_arch/src/presentation/controllers/recommended_product_controller.dart';

// API FORM RFP DJANGO PROJECT
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await GetStorage.init();
  // final box = GetStorage();

  await DependencyCreator.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PopularProductController>(
        builder: (_) => GetBuilder<RecommendedProductController>(
            builder: (_) => ScreenUtilInit(builder: (context, child) {
                  return GetMaterialApp(
                    debugShowCheckedModeBanner: false,
                    title: 'Food Delivery',
                    theme: ThemeData(
                      primarySwatch: Colors.blue,
                    ),
                    initialRoute: RouteHelper.getSplashPage(),
                    getPages: RouteHelper.routes,
                  );
                })));
  }
}
