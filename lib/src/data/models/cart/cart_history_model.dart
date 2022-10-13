import 'package:food_delivery_clean_arch/src/domain/entities/cart/cart.dart';
import 'package:food_delivery_clean_arch/src/domain/entities/cart/cart_history.dart';
import 'cart_model.dart';

// ignore: must_be_immutable
class CartHistoryModel extends CartHistory {
  CartHistoryModel({required super.order});

  CartHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['order'] != null) {
      order = List<CartModel>.from(
          ((json['order'] as List)).map((order) => CartModel.fromJson(order)));
    }
    orderTime = json['orderTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "orderTime": orderTime,
      "order": List<Map<String, dynamic>>.from(
          order!.map((cart) => (cart as CartModel).toJson())),
    };
    return data;
  }
}
