import 'package:get/get.dart';

import 'package:food_delivery_clean_arch/src/data/models/product_model.dart';
import 'package:food_delivery_clean_arch/src/domain/repositories/recommended_product_repo.dart';
import 'package:food_delivery_clean_arch/src/domain/entities/product.dart';
import 'package:food_delivery_clean_arch/src/core/error/failures.dart';
import 'package:food_delivery_clean_arch/src/core/utils/assistance_methods/snackbars.dart';
import 'cart/cart_controller.dart';

class RecommendedProductController extends GetxController with StateMixin<List<Product>>, ScrollMixin{
  final RecommendedProductRepo recommendedProductRepo;
  final CartController cartController;

  RecommendedProductController({required this.recommendedProductRepo, required this.cartController});
  
  @override
  void onInit() {
    fetchData();
    super.onInit();
  }
  RxList<Product> recommandedProducts = RxList<Product>([]);
  Rx<Product> recommandedProduct = Rx<Product>(ProductModel.empty());

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

    fetchData() async {
    final either = await recommendedProductRepo.getRecommendedProductList();
    either.fold((Failure failure) {
      change(null, status: RxStatus.error());
    }, (List<Product> list) {
      if(list.isEmpty){
        change(null, status: RxStatus.empty());
      }else{
        recommandedProducts.addAll(list);
        change(recommandedProducts, status: RxStatus.success());
      }
    });
  } 


  void initProduct(int productId){
    _quantity = 0;
    _inCartItems = 0;
    recommandedProduct.value = recommandedProducts[productId]; 
    if(cartController.existInCart(recommandedProduct.value)) {
      _inCartItems = cartController.getQuantity(recommandedProduct.value);
    }
    //get from storage _inCartItems
  }

    void setQuantity(bool isIncrement){
  if(isIncrement){
    _quantity = checkQuantity(_quantity+1);
  }else{
    _quantity = checkQuantity(_quantity-1);
  }
  update();
}

  int checkQuantity(int quantity){
    if((_inCartItems+quantity)<0) {
      snackbar("Item count", "You can't reduce more!");
      return -_inCartItems;
    } else if((_inCartItems+quantity)>20) {
      snackbar("Item count", "You can't add more!");
      return 20 -_inCartItems;
    }else {
      return quantity;
    }
  }


   void addItem(){
    // if(_quantity>0){
      cartController.addItem(recommandedProduct.value, _quantity);
      _quantity = 0;
      _inCartItems = cartController.getQuantity(recommandedProduct.value);
      print('${recommandedProduct.value.id} has been add with $_inCartItems as quantity');
      print('cart length is ${cartController.items.length}');
    // }else{
    //   Get.snackbar("Item count", "You should at least add an item in the cart!",
    //     backgroundColor: AppColors.mainColor,
    //     colorText: Colors.white,
    //   );
    // }
    update();
  }
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