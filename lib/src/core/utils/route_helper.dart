import 'package:get/get.dart';
import 'package:food_delivery_clean_arch/src/presentation/pages/page_index.dart';
import 'package:food_delivery_clean_arch/src/presentation/controllers/binding_index.dart';

class RouteHelper{
 static const String breakingNewsPage = "/breaking-news-screen";
 static const String initial = "/";

 static String getbreakingNewsPage()=>breakingNewsPage;
 static String getInitial()=>initial;

 static List<GetPage> routes = [
   GetPage(name: initial, page: () =>  MyHomePage(title: 'Home Page',)),
   GetPage(name: breakingNewsPage, binding: NewsBinding(), page: () =>  BreakingNewsPage()),

 ];

}