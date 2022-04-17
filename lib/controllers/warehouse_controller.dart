import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:portfolio/models/product.dart';
import 'package:portfolio/utils/constants.dart';

class WarehouseBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(WarehouseController());
  }
}

class WarehouseController extends GetxController {
  RxMap<int, Product> availableProducts = <int, Product>{}.obs;

  @override
  void onInit() async {
    await getData();
    super.onInit();
  }

  Future getData() async {
    final res =
        await http.get(Uri.parse('https://fakestoreapi.com/products?limit=14'));
    if (res.statusCode == 200) {
      jsonDecode(res.body).forEach((product) {
        availableProducts[product['id']] = Product.fromJson(product);
        update();
      });
    } else {
      showSnackBar('Error fetching data');
    }
  }

  void toggleFav(Product product) {
    availableProducts[product.id] = product..toggleFav();
    update();
  }

  List get products => availableProducts.value.values.toList();
}
