import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/controllers/shopping_controller.dart';
import 'package:portfolio/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool remove;
  const ProductCard({Key? key, required this.product, this.remove = false})
      : super(key: key);

  final textStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  @override
  Widget build(BuildContext context) {
    final shop = Get.find<ShoppingController>();
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: Image.asset(product.image),
          ),
          Container(
            color: Colors.white,
            height: 70,
            // padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 17,
                          color: Colors.black54,
                        ),
                      ),
                      Text(
                        '\$${product.price}',
                        style: textStyle,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 80,
                    color: Colors.black,
                    child: IconButton(
                      color: Colors.white,
                      icon: remove
                          ? const Icon(Icons.remove)
                          : const Icon(Icons.add),
                      onPressed: () {
                        remove
                            ? shop.removeProduct(product)
                            : shop.addProduct(product);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
