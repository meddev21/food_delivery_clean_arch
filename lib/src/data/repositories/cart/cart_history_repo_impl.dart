import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:food_delivery_clean_arch/src/domain/entities/cart/cart.dart';
import 'package:get_storage/get_storage.dart';

import 'package:food_delivery_clean_arch/src/core/utils/app_constants.dart';
import 'package:food_delivery_clean_arch/src/core/error/failures.dart';
import 'package:food_delivery_clean_arch/src/domain/entities/cart/cart_history.dart';
import 'package:food_delivery_clean_arch/src/data/models/cart/cart_history_model.dart';
import 'package:food_delivery_clean_arch/src/domain/repositories/cart/cart_history_repo.dart';

class CartHistoryRepoImpl extends CartHistoryRepo {
  final GetStorage box;

  CartHistoryRepoImpl(this.box);

  @override
  void addToCartHistoryList(List<Cart> cartList) {
    List<dynamic> cartsHistories = [];
    if (box.hasData(AppConstants.CARTS_HISTORIES_LIST)) {
      cartsHistories = box
          .read(AppConstants.CARTS_HISTORIES_LIST)
          .map((e) => e.toString())
          .toList();
    }
    cartsHistories.add(jsonEncode(CartHistoryModel(order: cartList)));
    box.write(AppConstants.CARTS_HISTORIES_LIST, cartsHistories);
    // TODO: apply removeCart func from cartController
  }

  @override
  Either<Failure, List<CartHistory>> getCartsHistories() {
    if (box.hasData(AppConstants.CARTS_HISTORIES_LIST)) {
      List<dynamic> rawCart =
          box.read(AppConstants.CART_LIST).map((e) => jsonDecode(e)).toList();
      return Right(rawCart.map((e) => CartHistoryModel.fromJson(e)).toList());
    }
    return const Left(EmptyCacheFailure());
  }
}
