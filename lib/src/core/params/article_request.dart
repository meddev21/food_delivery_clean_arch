import 'package:food_delivery_clean_arch/src/config/app_constants.dart';

class ArticlesRequestParams{
  final String apiKey;
  final String country;
  final String category;
  int page;
  final int pageSize;

  ArticlesRequestParams({
    this.apiKey = ApiKey,
    this.country = 'us',
    this.category = 'general',
    this.page = 1,
    this.pageSize = 20,
  });

  incrementPage(){
    page++;
  }
}