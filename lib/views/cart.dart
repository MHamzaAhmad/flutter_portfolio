import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portfolio/controllers/shopping_controller.dart';
import 'package:portfolio/widgets/cart_product_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shop = Get.find<ShoppingController>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(
        () => ListView(
          children: [
            ...shop.boughtProducts
                .map((element) => CartProductCard(product: element))
                .toList(),
            ...[
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Obx(
                      () => Text(
                        '\$${shop.totalPrice}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
