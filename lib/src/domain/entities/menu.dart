import 'package:equatable/equatable.dart';
import 'product.dart';

// ignore: must_be_immutable
abstract class Menu extends Equatable {
  int? totalSize;
  int? typeId;
  int? offset;
  late List<Product> products;

  Menu(
      {required this.totalSize,
      required this.typeId,
      required this.offset,
      required this.products});

  @override
  List<Object?> get props => [totalSize, typeId, offset, products];

  @override
  bool get stringify => true;


}
