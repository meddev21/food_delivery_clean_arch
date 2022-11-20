import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:food_delivery_clean_arch/src/core/network/network_info.dart';
import 'package:food_delivery_clean_arch/src/core/resources/api_client.dart';
import 'package:food_delivery_clean_arch/src/config/app_constants.dart';
import 'package:food_delivery_clean_arch/src/data/repositories/index_repository.dart';
import 'package:food_delivery_clean_arch/src/presentation/controllers/index_controller.dart';

// here we initialize essential system dependencies like -Database, network_checker,
//language service repo and controller GetStorage,  Get connect-
//+ all implementation of repositories (not abstract
//because implementation who has the function body) of the project
class DependencyCreator {
  static init() async {
    // Systems
    // Internet Checker
    Get.lazyPut(() => InternetConnectionChecker(), fenix: true);
    Get.lazyPut(() => NetworkInfoImpl(Get.find()), fenix: true);
    // Api Client
    Get.lazyPut(() => ApiClient(AppConstants.BASE_URL), fenix: true);
    // Storage
    await GetStorage.init();
    final box = GetStorage();
    Get.lazyPut(() => box);

    //repos
    //popular
    Get.lazyPut(() => PopularProductRepoImpl(Get.find<ApiClient>()));
    //recommended
    Get.lazyPut(() => RecommendedProductRepoImpl(Get.find<ApiClient>()));
    //cart
    Get.lazyPut(() => CartRepoImpl(Get.find<GetStorage>()));
    //cart history
    Get.lazyPut(() => CartHistoryRepoImpl(Get.find<GetStorage>()));

    //controllers
    //cart history
    Get.lazyPut(() => CartHistoryController(
        cartHistoryRepo: Get.find<CartHistoryRepoImpl>()));
    //cart
    Get.lazyPut(() => CartController(
        cartRepo: Get.find<CartRepoImpl>(),
        cartHistoryController: Get.find<CartHistoryController>()));
    //popular
    Get.lazyPut(() => PopularProductController(
        popularProductRepo: Get.find<PopularProductRepoImpl>(),
        cartController: Get.find<CartController>()));
    //recommended
    Get.lazyPut(() => RecommendedProductController(
        recommendedProductRepo: Get.find<RecommendedProductRepoImpl>(),
        cartController: Get.find<CartController>()));
  }
}
