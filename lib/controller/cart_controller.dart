import 'package:get/get.dart';
import 'package:hive/hive.dart';
import '../model/cart_item_model.dart';
import '../model/product_model.dart';

class CartController extends GetxController {
  static CartController get instance => Get.find();

  RxList<CartItemModel> cartItems = <CartItemModel>[].obs;

  late Box<CartItemModel> cartBox;

  @override
  void onInit() {
    super.onInit();
    cartBox = Hive.box<CartItemModel>('cartItemBox');
    loadCartItemsFromHive();
  }

  // Load cart items from Hive and add them to the cartItems list
  void loadCartItemsFromHive() {
    final savedCartItems = cartBox.values.toList();
    cartItems.addAll(savedCartItems);
  }

  // Add product to the cart
  void addToCart(ProductModel product) {
    // Check if the product already exists in the cart
    CartItemModel? existingItem = cartItems
        .firstWhereOrNull((item) => item.productModel.id == product.id);

    if (existingItem != null) {
      // If the product exists, increase the quantity
      existingItem.quantity += 1;
      cartBox.put(existingItem.productModel.id, existingItem);
      Get.snackbar(
        "Updated",
        "Increased the quantity of ${product.title} in your cart",
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    } else {
      // If the product doesn't exist, add a new entry
      CartItemModel newItem = CartItemModel(productModel: product, quantity: 1);
      cartItems.add(newItem);
      cartBox.put(product.id, newItem);
      Get.snackbar(
        "Success",
        "${product.title} has been added to your cart",
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
    }
    cartItems.refresh();
  }

  //method for clear all items from the cart
  void clearCart() {
    cartItems.clear();
    cartBox.clear();
    cartItems.refresh();
  }

  // Method to remove a product from the cart
  void removeFromCart(ProductModel product) {
    int index =
        cartItems.indexWhere((item) => item.productModel.id == product.id);
    if (index != -1) {
      cartBox.delete(product.id);
      cartItems.removeAt(index);
    }
    cartItems.refresh();
  }

  // Method to increase the quantity of a product
  void increaseQuantity(ProductModel product) {
    CartItemModel item =
        cartItems.firstWhere((item) => item.productModel.id == product.id);
    item.quantity += 1;
    cartBox.put(product.id, item);
    cartItems.refresh();
  }

  // Method to decrease the quantity of a product (minimum quantity is 1)
  void decreaseQuantity(ProductModel product) {
    CartItemModel item =
        cartItems.firstWhere((item) => item.productModel.id == product.id);
    if (item.quantity > 1) {
      item.quantity -= 1;
      cartBox.put(product.id, item);
      cartItems.refresh();
    }
  }

  // Method to get the total price of the cart
  double get totalPrice => cartItems.fold(
        0.0,
        (sum, item) => sum + item.productModel.price! * item.quantity,
      );
}
