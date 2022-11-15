import 'package:get/get.dart';
import 'package:dartz/dartz.dart';

import 'package:food_delivery_clean_arch/src/domain/repositories/cart/cart_history_repo.dart';
import 'package:food_delivery_clean_arch/src/data/models/cart/cart_history_model.dart';
import 'package:food_delivery_clean_arch/src/domain/entities/cart/cart.dart';

class CartHistoryController extends GetxController {
 
 final CartHistoryRepo cartHistoryRepo;

 CartHistoryController({required this.cartHistoryRepo}); 

   void saveToHistory(List<Cart> cartList){
    cartHistoryRepo.addToCartHistoryList(cartList);
  }

  List<CartHistoryModel> get cartHistoryList{
    Either either =  cartHistoryRepo.getCartsHistories();
    return either.fold(
      (l)  {
        Get.snackbar('Failure', l.toString());
        return [];
      }, 
      (r) => r  
      );
  }

}