import 'package:get/get.dart';

import 'package:food_delivery_clean_arch/src/domain/repositories/cart/cart_history_repo.dart';
import 'package:food_delivery_clean_arch/src/domain/entities/cart/cart_history.dart';
import 'package:food_delivery_clean_arch/src/domain/entities/cart/cart.dart';
import 'package:food_delivery_clean_arch/src/core/error/failures.dart';

class CartHistoryController extends GetxController  with StateMixin<List<CartHistory>>, ScrollMixin{
 
 final CartHistoryRepo cartHistoryRepo;

 CartHistoryController({required this.cartHistoryRepo}); 
  
    @override
  void onInit() {
    fetchData();
    super.onInit();
  }

  RxList<CartHistory> cartHistories = RxList<CartHistory>([]);

   void saveToHistory(List<Cart> cartList){
    cartHistoryRepo.addToCartHistoryList(cartList);
  }


   fetchData() async {
        final either = cartHistoryRepo.getCartsHistories();
    either.fold((Failure failure) {
      change(null, status: RxStatus.error());
    }, (List<CartHistory> list) {
      if(list.isEmpty){
        change(null, status: RxStatus.empty());
      }else{
        cartHistories.addAll(list);
        change(cartHistories, status: RxStatus.success());
      }
    });

   }
  /*
  (Failure failure) {
      change(null, status: RxStatus.error());
    },List<CartHistory> list) {
      if(list.isEmpty){
        change(null, status: RxStatus.empty());
      }else{
        recommandedProducts.addAll(list);
        change(recommandedProducts, status: RxStatus.success());
      }
    }
   */
  
  @override
  Future<void> onEndScroll() {
    // TODO: implement onEndScroll
    throw UnimplementedError();
  }
  
  @override
  Future<void> onTopScroll() {
    // TODO: implement onTopScroll
    throw UnimplementedError();
  }

}