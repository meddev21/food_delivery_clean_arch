import 'package:get/get.dart';

import 'package:food_delivery_clean_arch/src/data/models/product_model.dart';
import 'package:food_delivery_clean_arch/src/domain/repositories/popular_product_repo.dart';
import 'package:food_delivery_clean_arch/src/domain/entities/product.dart';
import 'package:food_delivery_clean_arch/src/domain/entities/cart/cart.dart';
import 'package:food_delivery_clean_arch/src/core/error/failures.dart';
import 'package:food_delivery_clean_arch/src/core/utils/assistance_methods/snackbars.dart';
import 'cart/cart_controller.dart';

class PopularProductController extends GetxController with StateMixin<List<Product>>, ScrollMixin{
  final PopularProductRepo popularProductRepo;
  final CartController cartController;
  PopularProductController({required this.popularProductRepo, required this.cartController});
  
  @override
  void onInit() {
    fetchData();
    super.onInit();
  }
  RxList<Product> popularProducts = RxList<Product>([]);
  Product popularProduct = ProductModel.empty();


  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;
  RxBool canAdd = false.obs;

    fetchData() async {
    final either = await popularProductRepo.getPopularProductList();
    either.fold((Failure failure) {
      change(null, status: RxStatus.error());
    }, (List<Product> list) {
      if(list.isEmpty){
        change(null, status: RxStatus.empty());
      }else{
        popularProducts.addAll(list);
        change(popularProducts, status: RxStatus.success());
      }
    });
  }

toggleCanAdd(bool vale){
  canAdd.value = vale;
  update();
}

    void initProduct(int productId){
    _quantity = 0;
    _inCartItems = 0;
    canAdd.value = false;
    popularProduct = popularProducts[productId]; 
    if(cartController.existInCart(popularProduct)) {
      _inCartItems = cartController.getQuantity(popularProduct);
    }
    //get from storage _inCartItems
  }

  int get totalItems => cartController.totalItems;

  List<Cart> get getItems => cartController.getItems;

  int get totalPrice => cartController.totalAmount;

  void setQuantity(bool isIncrement){
  if(isIncrement){
    _quantity = checkQuantity(_quantity+1);
  }else{
    _quantity = checkQuantity(_quantity-1);
  }
  if(_quantity == 0){
      toggleCanAdd(false);
  }else{
    toggleCanAdd(true);
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
      cartController.addItem(popularProduct, _quantity);
      _quantity = 0;
      _inCartItems = cartController.getQuantity(popularProduct);
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