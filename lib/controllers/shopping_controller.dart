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
      showSnackBar('Added ${product.name} to cart');
    } else {
      incrementProductQuantity(product);
      showSnackBar(
          '${product.name}\'s quantity incremented to ${productsMap[product.name].quantity}');
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

  void checkout(BuildContext context) {
    productsMap.clear();
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: Text(
            'Open your door, Package is at your door step.\n\n Yeah! it\'s that fast 🙃',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Okay'),
          ),
        ],
      ),
    );
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
