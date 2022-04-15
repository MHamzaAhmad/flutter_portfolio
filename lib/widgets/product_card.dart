import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:portfolio/controllers/shopping_controller.dart';
import 'package:portfolio/models/product.dart';
import 'package:portfolio/utils/constants.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({Key? key, required this.product}) : super(key: key);

  final textStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.black54,
  );

  @override
  Widget build(BuildContext context) {
    final shop = Get.find<ShoppingController>();
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        color: Colors.white60,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Center(
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: AssetImage(product.image),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(4),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: backgroundColor,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        'Get Yours On',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.black45,
                        ),
                      ),
                      Text(
                        '\$${product.price}',
                        style: textStyle,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Material(
                      elevation: 15,
                      borderRadius: BorderRadius.circular(50),
                      child: IconButton(
                        iconSize: 25,
                        constraints: const BoxConstraints(
                          maxHeight: 40,
                          maxWidth: 40,
                          minHeight: 40,
                          minWidth: 40,
                        ),
                        padding: EdgeInsets.zero,
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          shop.addProduct(product);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   height: 70,
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     mainAxisSize: MainAxisSize.max,
            //     children: [
            //       Expanded(
            //         flex: 2,
            //         child: Column(
            //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //           children: [
            //             Text(
            //               product.name,
            //               style: const TextStyle(
            //                 fontSize: 17,
            //                 color: Colors.black54,
            //               ),
            //             ),
            //             Text(
            //               '\$${product.price}',
            //               style: textStyle,
            //             ),
            //           ],
            //         ),
            //       ),
            //       Expanded(
            // child: OutlinedButton(
            //   style: OutlinedButton.styleFrom(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(10),
            //     ),
            //     side: const BorderSide(
            //       color: Color.fromARGB(255, 49, 49, 49),
            //       width: 2,
            //     ),
            //   ),
            //   child: const FaIcon(
            //     FontAwesomeIcons.plus,
            //     color: Colors.black,
            //     size: 16,
            //   ),
            //   onPressed: () {
            //     shop.addProduct(product);
            //   },
            // ),
            //       )
            //       // Expanded(
            //       //   child: Container(
            //       //     height: 80,
            //       //     color: Colors.black,
            //       //     child: IconButton(
            //       //       color: Colors.white,
            //       //       icon: remove
            //       //           ? const Icon(Icons.remove)
            //       //           : const Icon(Icons.add),
            //       //       onPressed: () {
            //       //         remove
            //       //             ? shop.removeProduct(product)
            //       //             : shop.addProduct(product);
            //       //       },
            //       //     ),
            //       //   ),
            //       // ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
