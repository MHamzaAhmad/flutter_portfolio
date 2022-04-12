import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:portfolio/controllers/shopping_controller.dart';
import 'package:portfolio/models/product.dart';
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
      price: 150.0,
    ),
    Product(
      name: 'Air Max',
      image: 'assets/air_max.png',
      price: 350.0,
    ),
    Product(
      name: 'Muslin',
      image: 'assets/muslin.png',
      price: 350.0,
    ),
    Product(
      name: 'Oceans',
      image: 'assets/oceans.png',
      price: 350.0,
    ),
    Product(
      name: 'Shadow',
      image: 'assets/shadow_6000.png',
      price: 350.0,
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Portfolio',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PageView(
          controller: _pageController,
          children: [
            Container(
              color: const Color(0xffebeaef),
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: GridView.count(
                physics: const BouncingScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 30,
                crossAxisSpacing: 20,
                childAspectRatio: 0.74,
                children: products.map((e) => ProductCard(product: e)).toList(),
              ),
            ),
            Obx(
              () => shop.totalProducts != 0
                  ? Container(
                      color: const Color(0xffebeaef),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: GridView.count(
                        physics: const BouncingScrollPhysics(),
                        crossAxisCount: 2,
                        mainAxisSpacing: 30,
                        crossAxisSpacing: 20,
                        childAspectRatio: 0.74,
                        children: shop.boughtProducts
                            .map((e) => ProductCard(product: e, remove: true))
                            .toList(),
                      ),
                    )
                  : const Center(
                      child: Text(
                        'No products',
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
      ),
      extendBody: true,
      bottomNavigationBar: SnakeNavigationBar.color(
        behaviour: SnakeBarBehaviour.floating,
        snakeShape: SnakeShape.circle,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
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
    );
  }
}
