import 'package:get/get.dart';

import 'package:food_delivery_clean_arch/src/domain/repositories/cart/cart_repo.dart';
import 'package:food_delivery_clean_arch/src/domain/entities/cart/cart.dart';
import 'package:food_delivery_clean_arch/src/domain/entities/product.dart';
import 'package:food_delivery_clean_arch/src/data/models/cart/cart_model.dart';
import 'cart_history_controller.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  final CartHistoryController cartHistoryController;

  CartController({required this.cartRepo, required this.cartHistoryController});

  Map<int, Cart> _items = {};

  Map<int, Cart> get items {
    if (_items.isEmpty) {
      cartRepo.getCartList().fold((l) => null,
          (r) => _items = {for (Cart cart in r) cart.product!.id!: cart});
    }
    return _items;
  }

  List<Cart> storageItems = [];

  void addItem(Product product, int quantity) {
    if (quantity != 0) {
      _items.update(
          product.id!,
          (currentProduct) => CartModel(
              id: currentProduct.id!,
              name: currentProduct.name!,
              price: currentProduct.price!,
              img: currentProduct.img!,
              quantity: currentProduct.quantity! + quantity,
              isExist: true,
              time: DateTime.now().toString(),
              product: currentProduct.product),
          ifAbsent: () => CartModel(
              id: product.id!,
              name: product.name!,
              price: product.price!,
              img: product.img!,
              quantity: quantity,
              isExist: true,
              time: DateTime.now().toString(),
              product: product));
      _items.removeWhere((key, value) => value.quantity == 0);
    }
    cartRepo.addToCartList(getItems);
    update();
  }

  List<Cart> get getItems => _items.values.toList();

  bool existInCart(Product product) => _items.containsKey(product.id!);

  int getQuantity(Product product) =>
      _items.containsKey(product.id!) ? (_items[product.id]?.quantity)! : 0;

  int get totalAmount => _items.isNotEmpty
      ? _items.values
          .map((e) => e.price! * e.quantity!)
          .reduce((value, element) => value + element)
      : 0;

  int get totalItems => _items.isNotEmpty
      ? _items.values
          .map((e) => e.quantity ?? 0)
          .reduce((value, element) => value + element)
      : 0;

  void clear() {
    _items = {};
    update();
  }

  void saveToHistory() {
    cartHistoryController.saveToHistory(items.values.toList());
    cartRepo.removeCart();
    clear();
  }
}
