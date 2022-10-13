import 'package:dartz/dartz.dart';


import 'package:food_delivery_clean_arch/src/core/error/failures.dart';
import 'package:food_delivery_clean_arch/src/domain/entities/cart/cart_history.dart';
import 'package:food_delivery_clean_arch/src/domain/entities/cart/cart.dart';

abstract class CartHistoryRepo{

  void addToCartHistoryList(List<Cart> cartList);

  Either<Failure, List<CartHistory>> getCartsHistories();
}