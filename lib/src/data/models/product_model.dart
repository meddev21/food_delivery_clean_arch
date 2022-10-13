import 'package:food_delivery_clean_arch/src/domain/entities/product.dart';

// ignore: must_be_immutable
class ProductModel extends Product {
  ProductModel(
      {required super.id,
      required super.name,
      required super.description,
      required super.price,
      required super.stars,
      required super.img,
      required super.location,
      required super.createdAt,
      required super.updatedAt,
      required super.typeId});

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      stars: json['stars'],
      img: json['img'],
      location: json['location'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      typeId: json['type_id']);

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['stars'] = stars;
    data['img'] = img;
    data['location'] = location;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['type_id'] = typeId;
    return data;
  }
  // ignore: recursive_getters
  int? get totalSize => totalSize;
  set totalSize(int? totalSize) => totalSize = totalSize;
  // ignore: recursive_getters, annotate_overrides
  int? get typeId => typeId;
  @override
  set typeId(int? typeId) => typeId = typeId;
  // ignore: recursive_getters
  int? get offset => offset;
  set offset(int? offset) => offset = offset;
  // ignore: recursive_getters
  List<ProductModel> get products => products;
  set products(List<ProductModel> products) => products = products;

}
