import 'package:get/get.dart';
import 'package:food_delivery_clean_arch/src/domain/repositories/recommended_product_repo.dart';
import 'package:food_delivery_clean_arch/src/domain/entities/product.dart';
import 'package:food_delivery_clean_arch/src/core/error/failures.dart';

class RecommendedProductController extends GetxController with StateMixin<List<Product>>, ScrollMixin{
  final RecommendedProductRepo recommendedProductRepo;

  RecommendedProductController(this.recommendedProductRepo);
  
  @override
  void onInit() {
    fetchData();
    super.onInit();
  }
  var recommandedProduct = RxList<Product>([]);
  
    fetchData() async {
    final either = await recommendedProductRepo.getRecommendedProductList();
    either.fold((Failure failure) {
      change(null, status: RxStatus.error());
    }, (List<Product> list) {
      if(list.isEmpty){
        change(null, status: RxStatus.empty());
      }else{
        recommandedProduct.addAll(list);
        change(recommandedProduct, status: RxStatus.success());
      }
    });
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