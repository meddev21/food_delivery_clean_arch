import 'package:food_delivery_clean_arch/src/domain/entities/menu.dart';
import 'product_model.dart';

// ignore: must_be_immutable
class MenuModel extends Menu {
  MenuModel(
      {required super.totalSize,
      required super.typeId,
      required super.offset,
      required super.products});

  factory MenuModel.fromJson(Map<String, dynamic> json) => MenuModel(
      totalSize: json['total_size'],
      typeId: json['type_id'],
      offset: json['offset'],
      products: List<ProductModel>.from((json['products'] as List)
          .map((product) => ProductModel.fromJson(product))));
}
