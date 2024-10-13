import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../model/product_model.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  // List to store cart products with their quantities
  RxList<Map<String, dynamic>> cartItems = <Map<String, dynamic>>[].obs;

  // Hive box for persistent storage
  late Box<ProductModel> cartBox;

  @override
  void onInit() {
    super.onInit();
    // Open the Hive box for cart items
    cartBox = Hive.box<ProductModel>('cartBox');

    // Load existing cart items from Hive when the controller is initialized
    loadCartItemsFromHive();
  }

  // Load cart items from Hive and add them to the cartItems list
  void loadCartItemsFromHive() {
    final savedCartItems = cartBox.values.toList();
    cartItems.addAll(
      savedCartItems.map((product) => {"product": product, "quantity": 1}),
    );
  }

  // Method to add a product to the cart
  void addToCart(ProductModel product) {
    // Check if the product is already in the cart
    bool isAlreadyInCart = cartItems.any((item) => item["product"].id == product.id);

    if (isAlreadyInCart) {
      Get.snackbar(
        "Already Added",
        "${product.title} is already in your cart",
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    } else {
      // Add the product to the cart with quantity 1 and save it to Hive
      cartItems.add({"product": product, "quantity": 1});
      cartBox.add(product);

      // Show success snackbar
      Get.snackbar(
        "Success",
        "${product.title} has been added to your cart",
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    }
  }

  // Method to remove a product from the cart
  void removeFromCart(ProductModel product) {
    int index = cartItems.indexWhere((item) => item["product"].id == product.id);
    cartItems.removeAt(index);
    cartBox.deleteAt(index);
  }

  // Method to increase the quantity of a product
  void increaseQuantity(ProductModel product) {
    int index = cartItems.indexWhere((item) => item["product"].id == product.id);
    cartItems[index]["quantity"] += 1;
    cartItems.refresh(); // Notify listeners of the change
  }

  // Method to decrease the quantity of a product (minimum quantity is 1)
  void decreaseQuantity(ProductModel product) {
    int index = cartItems.indexWhere((item) => item["product"].id == product.id);
    if (cartItems[index]["quantity"] > 1) {
      cartItems[index]["quantity"] -= 1;
      cartItems.refresh(); // Notify listeners of the change
    }
  }

  // Method to get the total price of the cart
  double get totalPrice => cartItems.fold(
        0.0,
        (sum, item) => sum + item["product"].price! * item["quantity"],
      );
}
