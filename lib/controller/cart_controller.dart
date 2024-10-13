import 'package:get/get.dart';
import 'package:hive/hive.dart';

import '../model/product_model.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  //List to store cart products
  RxList<ProductModel> cartItems = <ProductModel>[].obs;

  //Hive box for persistant storage
  late Box<ProductModel> cartBox;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    //open the Hive box for cart items
    cartBox = Hive.box<ProductModel>('cartBox');

    // Load existing cart items from Hive when the controller is initialized
    loadCartItemsFromHive();
  }

  // Load cart items from Hive and add them to the cartItems list
  void loadCartItemsFromHive() {
    final saveCartItems = cartBox.values.toList();
    cartItems.addAll(saveCartItems);
  }

  //Method to add a product to the cart
  void addToCart(ProductModel product) {
    // Check if the product is already in the cart
    bool isAlreadyAdded = cartItems.any((item) => item.id == product.id);
    if (isAlreadyAdded) {
      Get.snackbar(
        "Already Added",
        "${product.title} is already in your cart",
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    } else {
      cartItems.add(product);
      cartBox.add(product);
      Get.snackbar(
        "Success",
        "${product.title} has been added to your cart",
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    }
  }

  //Method to remove a product from the cart
  void removeFromCart(ProductModel product) {
    int index = cartItems.indexOf(product);
    cartItems.remove(product);
    cartBox.deleteAt(index);
  }

  //Method to get the total price of the cart
  double get totalPrice => cartItems.fold(
        0.0,
        (sum, item) => sum + item.price!,
      );
}
