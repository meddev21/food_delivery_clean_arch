import 'package:dartz/dartz.dart';


import 'package:food_delivery_clean_arch/src/core/error/failures.dart';
import 'package:food_delivery_clean_arch/src/domain/entities/cart/cart.dart';

abstract class CartRepo{

  void addToCartList(List<Cart> cartList);

  Either<Failure, List<Cart>> getCartList();

  void removeCart();
}