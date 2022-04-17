import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:portfolio/controllers/shopping_controller.dart';
import 'package:portfolio/controllers/warehouse_controller.dart';
import 'package:portfolio/models/product.dart';
import 'package:portfolio/utils/constants.dart';
import 'package:portfolio/views/poduct_page.dart';

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
    final warehouse = Get.find<WarehouseController>();
    return InkWell(
      onTap: () {
        Get.to(
          () => ProductPage(
            product: product,
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Container(
          color: Colors.white60,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: Obx(
                  () => IconButton(
                    onPressed: () {
                      warehouse.toggleFav(product);
                    },
                    icon: warehouse.availableProducts[product.id]!.fav
                        ? const Icon(Icons.favorite, size: 18)
                        : const Icon(Icons.favorite_border_outlined, size: 18),
                  ),
                ),
              ),
              Expanded(
                child: Hero(
                  tag: product.id.toString(),
                  child: Center(
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: NetworkImage(product.image),
                    ),
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
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.19,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Text(
                              product.name,
                              overflow: TextOverflow.fade,
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const Text(
                          'Get Yours',
                          style: TextStyle(
                            fontSize: 11,
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
            ],
          ),
        ),
      ),
    );
  }
}
