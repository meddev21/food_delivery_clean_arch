import 'package:food_delivery_clean_arch/src/domain/entities/cart/cart.dart';
import '../product_model.dart';

// ignore: must_be_immutable
class CartModel extends Cart {
  CartModel(
      {required super.id,
      required super.name,
      required super.price,
      required super.img,
      required super.quantity,
      required super.isExist,
      required super.time,
      required super.product});

  factory CartModel.fromJson(Map<String, dynamic> json) => CartModel(
        id: json['id'],
        name: json['name'],
        price: json['price'],
        img: json['img'],
        quantity: json['quantity'],
        isExist: json['isExist'],
        time: json['time'],
        product: ProductModel.fromJson(json['product']),
      );

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      "id": id,
      "name": name,
      "price": price,
      "img": img,
      "quantity": quantity,
      "isExist": isExist,
      "time": time,
      "product": (product as ProductModel).toJson(),
    };
    return data;
  }
}
