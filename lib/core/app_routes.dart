import 'package:get/get.dart';

import '../screens/home_page/home_page.dart';


class AppRoutes {

  static String HOMEPAGE = '/homePage';
  static String SIGNUP = '/signUp';
  static String LOGIN = '/login';
  static String ADDNOTE = '/addNote';

  static List<GetPage> routes = [
 
    GetPage(
      name: HOMEPAGE,
      page: () => const HomePage(),
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
