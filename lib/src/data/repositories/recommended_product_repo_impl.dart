import 'dart:io';
import 'dart:async';

import 'package:get/get.dart';
import 'package:dartz/dartz.dart';

import 'package:food_delivery_clean_arch/src/core/resources/api_client.dart';
import 'package:food_delivery_clean_arch/src/config/app_constants.dart';
import 'package:food_delivery_clean_arch/src/core/error/failures.dart';
import 'package:food_delivery_clean_arch/src/core/error/exceptions.dart';
import 'package:food_delivery_clean_arch/src/core/params/api_request.dart';
import 'package:food_delivery_clean_arch/src/domain/entities/product.dart';
import 'package:food_delivery_clean_arch/src/data/models/menu_model.dart';
import 'package:food_delivery_clean_arch/src/domain/repositories/recommended_product_repo.dart';

class RecommendedProductRepoImpl extends RecommendedProductRepo {
  final ApiClient apiClient;

  RecommendedProductRepoImpl(this.apiClient);

  @override
  Future<Either<Failure, List<Product>>> getRecommendedProductList() async {
    try {
      List<Product> recommandedProductList = [];
      APIRequestParams params = const APIRequestParams(
          url: AppConstants.POPULAR_PRODUCT_URL,
          method: HTTPMethod.get);
      Response response = await apiClient.demand(params);
      if (response.isOk) {
        recommandedProductList
            .addAll(MenuModel.fromJson(response.body).products);
            return Right(recommandedProductList);
      } else {
        return Left(Failure.responseFailure(
          RequestException(
            statusCode: response.statusCode,
            statusText: response.statusText,
            details: response.body)));
      }
    } on SocketException catch (e) {
        return Left(OfflineFailure(details: e.message));
      } on TimeoutException catch (e) {
        return Left(TimeOutFailure(e.message));
      } catch (e) {
        return Left(GlobalFailure(e.toString()));
      }
  }
}
