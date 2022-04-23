import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:portfolio/controllers/shopping_controller.dart';
import 'package:portfolio/controllers/warehouse_controller.dart';
import 'package:portfolio/models/product.dart';
import 'package:portfolio/utils/constants.dart';
import 'package:portfolio/views/cart.dart';
import 'package:portfolio/widgets/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final shop = Get.find<ShoppingController>();
  final warehouse = Get.find<WarehouseController>();
  final PageController _pageController = PageController(initialPage: 0);
  // final List<Product> products = [
  //   Product(
  //     name: 'Foam',
  //     image: 'assets/yeezy_foam.png',
  //     price: 135.0,
  //   ),
  //   Product(
  //     name: 'Air Max',
  //     image: 'assets/air_max.png',
  //     price: 320.0,
  //   ),
  //   Product(
  //     name: 'Muslin',
  //     image: 'assets/muslin.png',
  //     price: 275.0,
  //   ),
  //   Product(
  //     name: 'Oceans',
  //     image: 'assets/oceans.png',
  //     price: 120.0,
  //   ),
  //   Product(
  //     name: 'Shadow',
  //     image: 'assets/shadow_6000.png',
  //     price: 480.0,
  //   ),
  // ];

  int index = 0;

  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {
        index = _pageController.page!.toInt();
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade300.withOpacity(0.6),
          elevation: 0,
          leading: const Center(
            child: FaIcon(
              FontAwesomeIcons.bars,
              color: Colors.black,
            ),
          ),
          title: const Text(
            'Portfolio',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: PageView(
          controller: _pageController,
          children: [
            Obx(() => MainPage(products: warehouse.products)),
            // Obx(
            //   () => warehouse.products.isNotEmpty
            //       ? MainPage(products: warehouse.products as List<Product>)
            //       : const Center(
            //           child: SpinKitPouringHourGlassRefined(
            //             color: Colors.yellow,
            //             size: 60,
            //             strokeWidth: 1.5,
            //           ),
            //         ),
            // ),
            Obx(
              () => shop.totalProducts != 0
                  ? const CartScreen()
                  : const Center(
                      child: Text(
                        'Come on dude! lets buy something!',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Made with ❤️ by',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                Text(
                  'Muhammad Hamza',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        extendBody: true,
        bottomNavigationBar: SnakeNavigationBar.color(
          behaviour: SnakeBarBehaviour.floating,
          snakeShape: SnakeShape.circle,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          padding: const EdgeInsets.all(10),
          snakeViewColor: Colors.black,
          backgroundColor: Colors.grey[300],
          unselectedItemColor: Colors.blueGrey,
          currentIndex: index,
          onTap: (i) {
            _pageController.animateToPage(
              i,
              curve: Curves.decelerate,
              duration: const Duration(milliseconds: 220),
            );
            setState(() => index = i);
          },
          items: [
            const BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.house), label: 'Home'),
            BottomNavigationBarItem(
              icon: Obx(
                () => Badge(
                  badgeContent: Text(shop.totalProducts.toString()),
                  badgeColor: Colors.yellow,
                  child: const FaIcon(FontAwesomeIcons.bagShopping),
                ),
              ),
              label: 'Shop',
            ),
            const BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.user), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}

class MainPage extends StatefulWidget {
  final List products;
  const MainPage({Key? key, required this.products}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  TextEditingController _searchController = TextEditingController();
  String query = '';
  @override
  Widget build(BuildContext context) {
    List ps = widget.products
        .where((product) =>
            product.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return widget.products.isNotEmpty
        ? Container(
            color: backgroundColor,
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 60, bottom: 10),
                  child: TextField(
                    controller: _searchController,
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search, color: Colors.black),
                      suffixIcon: InkWell(
                        child: const Icon(
                          Icons.clear,
                          color: Colors.black,
                        ),
                        onTap: () {
                          _searchController.clear();
                          setState(() => query = '');
                        },
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Search',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (val) => setState(() => query = val),
                  ),
                ),
                ps.isNotEmpty
                    ? Expanded(
                        child: GridView.count(
                          physics: const BouncingScrollPhysics(),
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          crossAxisCount: 2,
                          mainAxisSpacing: 15,
                          crossAxisSpacing: 18,
                          childAspectRatio: 0.62,
                          children:
                              ps.map((e) => ProductCard(product: e)).toList(),
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'No products found for "$query"',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ],
            ),
          )
        : const Center(
            child: SpinKitPouringHourGlassRefined(
              color: Colors.yellow,
              size: 60,
              strokeWidth: 1.5,
            ),
          );
  }
}
