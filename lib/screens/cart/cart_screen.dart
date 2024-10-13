import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:simple_ecommerce/model/product_model.dart';

import '../../controller/cart_controller.dart';
import '../../core/app_colors.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Cart'),
      ),
      body: Obx(
        () {
          if (cartController.cartItems.isEmpty) {
            return const Center(
              child: Text("Your cart is empty"),
            );
          } else {
            return ListView.builder(
              itemCount: cartController.cartItems.length,
              itemBuilder: (context, index) {
                final item = cartController.cartItems[index];
                final product = item["product"] as ProductModel;
                final quantity = item["quantity"] as int;

                // Calculate individual product total price
                final individualTotalPrice = product.price! * quantity;

                return Column(
                  children: [
                    ListTile(
                      leading: CachedNetworkImage(
                        width: 60,
                        fit: BoxFit.contain,
                        imageUrl: product.image!,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: LoadingAnimationWidget.staggeredDotsWave(
                            color: Colors.purple.shade300,
                            size: 30,
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                      title: Text(
                        product.title!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '\$${individualTotalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                onPressed: () {
                                  cartController.decreaseQuantity(product);
                                },
                                icon: const Icon(Icons.remove),
                              ),
                              Text('$quantity'),
                              IconButton(
                                onPressed: () {
                                  cartController.increaseQuantity(product);
                                },
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: IconButton.filled(
                        onPressed: () {
                          cartController.removeFromCart(product);
                        },
                        style: IconButton.styleFrom(
                            backgroundColor: Colors.grey.shade300),
                        icon: Icon(
                          Icons.delete,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                );
              },
            );
          }
        },
      ),
      bottomNavigationBar: Obx(
        () => BottomAppBar(
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total Price',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  Text(
                    '\$${cartController.totalPrice.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 40),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: () {},
                  label: const Text(
                    'CheckOut',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                  icon: Icon(
                    Icons.shopping_cart_checkout,
                    color: whiteColor,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    fixedSize: Size(Get.width, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
