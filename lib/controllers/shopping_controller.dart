import 'package:get/get.dart';
import 'package:portfolio/models/product.dart';

class ShopppingBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ShoppingController());
  }
}

class ShoppingController extends GetxController {
  RxList boughtProducts = [].obs;

  void addProduct(Product product) {
    boughtProducts.add(product);
    update();
  }

  void removeProduct(Product product) {
    boughtProducts.remove(product);
    update();
  }

  int get totalProducts => boughtProducts.length;
}
