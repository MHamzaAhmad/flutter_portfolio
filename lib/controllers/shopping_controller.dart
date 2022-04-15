import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/models/product.dart';
import 'package:portfolio/utils/constants.dart';

class ShopppingBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ShoppingController());
  }
}

class ShoppingController extends GetxController {
  RxMap productsMap = {}.obs;

  void addProduct(Product product) {
    if (productsMap[product.name] == null) {
      productsMap[product.name] = product;
    } else {
      incrementProductQuantity(product);
      Get.showSnackbar(
        GetSnackBar(
          messageText: Text(
            '${product.name}\'s quantity increased!',
            style: const TextStyle(
              color: Colors.black87,
            ),
          ),
          backgroundColor: Colors.grey,
          borderRadius: 25,
          margin: const EdgeInsets.all(24),
          duration: const Duration(milliseconds: 1200),
        ),
      );
    }
    update();
  }

  void removeProduct(Product product) {
    productsMap.remove(product.name);
    update();
  }

  void incrementProductQuantity(Product product) {
    productsMap[product.name] = product..quantity += 1;
    update();
  }

  void decrementProductQuantity(Product product) {
    if (product.quantity > 1) {
      productsMap[product.name] = product..quantity -= 1;
    } else {
      removeProduct(product);
    }
    update();
  }

  void favproduct(Product product) {
    productsMap[product.name] = product..toggleFav();
    update();
  }

  int getProductQuantity(Product product) {
    return productsMap[product.name].quantity;
  }

  Product getProduct(Product product) {
    return productsMap[product.name];
  }

  List get boughtProducts => productsMap.values.toList();

  int get totalProducts => productsMap.length;

  double get totalPrice => productsMap.values.fold(
      0.0, (total, element) => total + (element.price * element.quantity));
}
