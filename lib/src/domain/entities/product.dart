import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
abstract class Product extends Equatable {
  int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  String? img;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? typeId;

  Product(
      {required this.id,
      required this.name,
      required this.description,
      required this.price,
      required this.stars,
      required this.img,
      required this.location,
      required this.createdAt,
      required this.updatedAt,
      required this.typeId});

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        price,
        stars,
        img,
        location,
        createdAt,
        updatedAt,
        typeId
      ];

  @override
  bool get stringify => true;
}
