import 'package:get/get.dart';
import 'package:food_delivery_clean_arch/src/presentation/pages/index_pages.dart';
import 'package:food_delivery_clean_arch/src/presentation/controllers/binding_index.dart';

class RouteHelper {
  static const String breakingNewsPage = "/breaking-news-screen";
  static const String initial = "/";
  static const String popularFood = "/popular-food";
  static const String recommendedFood = "/recommended-food";
  static const String cartPage = "/cart-page";

  static String getbreakingNewsPage() => breakingNewsPage;
  static String getInitial() => initial;
  static String getPopularFood(int pageId, String page) =>
      '$popularFood?pageId=$pageId&page=$page';
  static String getRecommendedFood(int pageId, String page) =>
      '$recommendedFood?pageId=$pageId&page=$page';
  static String getCartPage() => '$cartPage';

  static List<GetPage> routes = [
    GetPage(
        name: initial,
        page: () => MyHomePage(
              title: 'Home Page',
            )),
    GetPage(
        name: breakingNewsPage,
        binding: NewsBinding(),
        page: () => BreakingNewsPage()),
    GetPage(
        name: popularFood,
        page: () => PopularFoodDetail(
              pageId: int.parse(Get.parameters['pageId']!),
              page: Get.parameters['page']!,
            )),
    // GetPage(name: popularFood, page: () {
    //   print("id sent from main page is ${Get.parameters['popularPageId']}");
    //   return PopularFoodDetail(pageId: int.parse(Get.parameters['pageId']!),);
    // }),
    GetPage(
        name: recommendedFood,
        page: () => RecommendedFoodDetail(
              pageId: int.parse(Get.parameters['pageId']!),
              page: Get.parameters['page']!,
            )),
    GetPage(
        name: cartPage,
        page: () => const CartPage(),
        transition: Transition.fadeIn),
  ];
}
