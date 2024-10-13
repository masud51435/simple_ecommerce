import 'package:get/get.dart';
import 'package:simple_ecommerce/screens/cart/cart_screen.dart';
import 'package:simple_ecommerce/screens/product_details/product_details.dart';

import '../screens/home_page/home_page.dart';

class AppRoutes {
  static String HOMEPAGE = '/homePage';
  static String SIGNUP = '/signUp';
  static String LOGIN = '/login';
  static String PRODUCTDETAILS = '/productDetails';
  static String MyCART = '/myCart';

  static List<GetPage> routes = [
    GetPage(
      name: HOMEPAGE,
      page: () => const HomePage(),
    ),
    GetPage(
      name: PRODUCTDETAILS,
      page: () => const ProductDetails(),
      transition: Transition.rightToLeft, 
    ),
    GetPage(
      name: MyCART,
      page: () => const CartScreen(),
      transition: Transition.rightToLeft, 
    ),
    //  GetPage(
    //   name: SIGNUP,
    //   page: () => const SignUp(),
    // ),
    // GetPage(
    //   name: LOGIN,
    //   page: () => const Login(),
    // ),
    // GetPage(
    //   name: ADDNOTE,
    //   page: () => const AddNotePage(),
    // ),
  ];
}
