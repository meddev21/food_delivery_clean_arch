import 'package:get/get.dart';
import 'package:food_delivery_clean_arch/src/domain/repositories/popular_product_repo.dart';
import 'package:food_delivery_clean_arch/src/domain/entities/product.dart';
import 'package:food_delivery_clean_arch/src/core/error/failures.dart';

class PopularProductController extends GetxController with StateMixin<List<Product>>, ScrollMixin{
  final PopularProductRepo popularProductRepo;

  PopularProductController(this.popularProductRepo);
  
  @override
  void onInit() {
    fetchData();
    super.onInit();
  }
  var popularProduct = RxList<Product>([]);

    fetchData() async {
    final either = await popularProductRepo.getPopularProductList();
    either.fold((Failure failure) {
      change(null, status: RxStatus.error());
    }, (List<Product> list) {
      if(list.isEmpty){
        change(null, status: RxStatus.empty());
      }else{
        popularProduct.addAll(list);
        change(popularProduct, status: RxStatus.success());
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