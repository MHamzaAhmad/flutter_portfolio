import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/controllers/shopping_controller.dart';
import 'package:portfolio/controllers/warehouse_controller.dart';
import 'package:portfolio/views/home_page.dart';
import 'package:portfolio/views/poduct_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Portfolio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: GoogleFonts.raleway().fontFamily,
      ),
      initialRoute: '/',
      // initialBinding: ShopppingBinding(),
      getPages: [
        GetPage(
          name: '/',
          page: () => const HomePage(),
          bindings: [WarehouseBindings(), ShopppingBinding()],
        ),
      ],
    );
  }
}
