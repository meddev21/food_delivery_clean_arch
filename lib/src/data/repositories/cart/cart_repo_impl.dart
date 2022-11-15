import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:get_storage/get_storage.dart';

import 'package:food_delivery_clean_arch/src/config/app_constants.dart';
import 'package:food_delivery_clean_arch/src/core/error/failures.dart';
import 'package:food_delivery_clean_arch/src/domain/entities/cart/cart.dart';
import 'package:food_delivery_clean_arch/src/data/models/cart/cart_model.dart';
import 'package:food_delivery_clean_arch/src/domain/repositories/cart/cart_repo.dart';

class CartRepoImpl extends CartRepo {
  final GetStorage box;

  CartRepoImpl(this.box);

  List<String> cart = [];
  List<String> cartHistory = [];

  @override
  void addToCartList(List<Cart> cartList) {
    cart = List.from(cartList.map((e) => jsonEncode(e)));
    box.write(AppConstants.CART_LIST, cart);
  }

  @override
  Either<Failure, List<Cart>> getCartList() {
    if (box.hasData(AppConstants.CART_LIST)) {
      List<dynamic> rawCart =
          box.read(AppConstants.CART_LIST).map((e) => jsonDecode(e)).toList();
      return Right(rawCart.map((e) => CartModel.fromJson(e)).toList());
    }
    return const Left(EmptyCacheFailure());
  }

  @override
  void removeCart() {
    box.remove(AppConstants.CART_LIST);
  }
}
