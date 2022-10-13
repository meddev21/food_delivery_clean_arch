import 'package:equatable/equatable.dart';
import 'cart.dart';

// ignore: must_be_immutable
abstract class CartHistory extends Equatable{
    List<Cart>? order;
  String? orderTime;
  
  CartHistory({this.order}): orderTime = DateTime.now().toString();

  @override
  List<Object?> get props => [order, orderTime];

  @override
  bool get stringify => true;


}