import 'dart:ui';

import 'package:badges/badges.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:portfolio/controllers/shopping_controller.dart';
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
  final PageController _pageController = PageController(initialPage: 0);
  final List<Product> products = [
    Product(
      name: 'Foam',
      image: 'assets/yeezy_foam.png',
      price: 135.0,
    ),
    Product(
      name: 'Air Max',
      image: 'assets/air_max.png',
      price: 320.0,
    ),
    Product(
      name: 'Muslin',
      image: 'assets/muslin.png',
      price: 275.0,
    ),
    Product(
      name: 'Oceans',
      image: 'assets/oceans.png',
      price: 120.0,
    ),
    Product(
      name: 'Shadow',
      image: 'assets/shadow_6000.png',
      price: 480.0,
    ),
  ];

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
            MainPage(products: products),
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

class MainPage extends StatelessWidget {
  final List<Product> products;
  const MainPage({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: const EdgeInsets.all(10),
      child: GridView.count(
        physics: const BouncingScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 18,
        childAspectRatio: 0.65,
        children: products.map((e) => ProductCard(product: e)).toList(),
      ),
    );
  }
}
