import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:food_delivery_clean_arch/src/core/network/network_info.dart';
import 'app_constants.dart';
import 'package:food_delivery_clean_arch/src/core/resources/api_client.dart';
import 'package:food_delivery_clean_arch/src/data/datasources/local/app_database.dart';
import 'package:food_delivery_clean_arch/src/data/datasources/remote/news_api_service.dart';
import 'package:food_delivery_clean_arch/src/data/datasources/local/news_local_service.dart';
import 'package:food_delivery_clean_arch/src/data/repositories/articles_repository_impl.dart';

// here we initialize essential system dependencies like -Database, network_checker,
//language service repo and controller GetStorage,  Get connect-
//+ all implementation of repositories (not abstract
//because implementation who has the function body) of the project
class DependencyCreator {
  static init() async {
    // Define need later constant like GetStorage, Database instante
    final database =
        await $FloorAppDatabase.databaseBuilder(DatabaseName).build();

    // Systems
    // Internet Checker
    Get.lazyPut(() => InternetConnectionChecker(), fenix: true);
    Get.lazyPut(() => NetworkInfoImpl(Get.find()), fenix: true);
    // Api Client
    Get.lazyPut(() => ApiClient(BaseUrl), fenix: true);
    // Database
    Get.lazyPut(() => database, fenix: true);

    // Services
    // Remote
    Get.lazyPut(() => NewsApiService(Get.find()), fenix: true);
    // Local
    Get.lazyPut(() => NewsLocalService(Get.find()), fenix: true);
    
    // Repository
    Get.lazyPut(() => ArticlesRepositoryImpl(
        newsApiService: Get.find(),
        newsLocalService: Get.find(),
        // here [ArticlesRepositoryImpl] need NetworkInfo  the abstract not implement but abstract 
        // has no body fuction so we injected with Get.find() with type of the implement [NetworkInfoImpl] 
        networkInfo: Get.find<NetworkInfoImpl>()), fenix: true);
  }
}
