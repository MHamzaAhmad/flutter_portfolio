import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/controllers/shopping_controller.dart';
import 'package:portfolio/models/product.dart';
import 'package:portfolio/utils/constants.dart';
import 'package:portfolio/views/poduct_page.dart';

class CartProductCard extends StatelessWidget {
  final Product product;
  const CartProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shop = Get.find<ShoppingController>();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        onTap: () {
          Get.to(
            () => ProductPage(
              product: product,
            ),
          );
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            color: backgroundColor,
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Hero(
                  tag: product.id.toString(),
                  child: Material(
                    elevation: 10,
                    borderRadius: BorderRadius.circular(10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        product.image,
                        height: MediaQuery.of(context).size.height * 0.08,
                        width: MediaQuery.of(context).size.width * 0.14,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15, 8, 8, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '\$${product.price}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                //quantity buttons
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(50),
                          child: IconButton(
                            iconSize: 15,
                            constraints: const BoxConstraints(
                              maxHeight: 60,
                              maxWidth: 60,
                              minHeight: 30,
                              minWidth: 30,
                            ),
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              shop.decrementProductQuantity(product);
                            },
                          ),
                        ),
                      ),
                      Obx(
                        () => Text(
                          shop.getProductQuantity(product).toString(),
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Material(
                          elevation: 10,
                          borderRadius: BorderRadius.circular(50),
                          child: IconButton(
                            iconSize: 15,
                            constraints: const BoxConstraints(
                              maxHeight: 60,
                              maxWidth: 60,
                              minHeight: 30,
                              minWidth: 30,
                            ),
                            padding: EdgeInsets.zero,
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              shop.incrementProductQuantity(product);
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
