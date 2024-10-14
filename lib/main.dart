import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:simple_ecommerce/core/app_colors.dart';
import 'package:simple_ecommerce/core/app_routes.dart';
import 'package:simple_ecommerce/firebase_options.dart';
import 'package:simple_ecommerce/model/cart_item_model.dart';
import 'package:simple_ecommerce/model/product_model.dart';

import 'controller/cart_controller.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // initialize hive storage
  await Hive.initFlutter();
  Hive.registerAdapter(ProductModelAdapter());
  Hive.registerAdapter(RatingAdapter());
  Hive.registerAdapter(CartItemModelAdapter());
  await Hive.openBox<ProductModel>('cartBox');
  await Hive.openBox<ProductModel>('productBox');
  await Hive.openBox<CartItemModel>('cartItemBox');

  // Initialize CartController globally
  Get.put(CartController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Simple E-Commerce App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: whiteColor,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: true,
      ),
      initialRoute: AppRoutes.HOMEPAGE,
      getPages: AppRoutes.routes,
    );
  }
}
