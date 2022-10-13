import 'package:dartz/dartz.dart';


import 'package:food_delivery_clean_arch/src/core/error/failures.dart';
import 'package:food_delivery_clean_arch/src/domain/entities/product.dart';

abstract class RecommendedProductRepo{
  Future<Either<Failure, List<Product>>> getRecommendedProductList();
}