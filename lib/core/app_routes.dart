import 'package:get/get.dart';
import 'package:simple_ecommerce/order_confirm/order_confirm.dart';
import 'package:simple_ecommerce/screens/cart/cart_screen.dart';
import 'package:simple_ecommerce/screens/checkout/check_out.dart';

import '../screens/home_page/home_page.dart';

class AppRoutes {
  static String HOMEPAGE = '/homePage';
  static String SIGNUP = '/signUp';
  static String LOGIN = '/login';
  static String MyCART = '/myCart';
  static String CHECKOUT = '/checkout';
  static String ORDERCONFIRM = '/orderConfirm';

  static List<GetPage> routes = [
    GetPage(
      name: HOMEPAGE,
      page: () => const HomePage(),
    ),

    GetPage(
      name: MyCART,
      page: () => const CartScreen(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: CHECKOUT,
      page: () => const CheckOut(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: ORDERCONFIRM,
      page: () => const OrderConfirm(),
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
