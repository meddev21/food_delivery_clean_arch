import 'package:equatable/equatable.dart';
import '../product.dart';

// ignore: must_be_immutable
abstract class Cart extends Equatable{
  int? id;
  String? name;
  int? price;
  String? img;
  int? quantity;
  bool? isExist;
  String? time;
  Product? product;
  Cart(
      {required this.id,
        required this.name,
        required this.price,
        required this.img,
        required this.quantity,
        required this.isExist,
        required this.time,
        required this.product,
      });

  @override
  List<Object?> get props => [id, name, price, img, quantity, isExist, time, product];

  @override
  bool get stringify => true;


}