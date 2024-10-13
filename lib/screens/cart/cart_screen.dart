import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/cart_controller.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = CartController.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Cart"),
      ),
      body: Obx(
        () {
          return cartController.cartItems.isEmpty
              ? const Center(
                  child: Text("Your cart is empty"),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cartController.cartItems.length,
                        itemBuilder: (context, index) {
                          final product = cartController.cartItems[index];
                          return ListTile(
                            leading: Image.network(product.image!, width: 50),
                            title: Text(product.title!),
                            subtitle: Text("\$${product.price}"),
                            trailing: IconButton(
                              icon: const Icon(Icons.remove_circle),
                              onPressed: () {
                                cartController.removeFromCart(product);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Price: \$${cartController.totalPrice}",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20),
                          ElevatedButton(
                            onPressed: () {
                              // You can add logic for checkout
                            },
                            child: const Text("Checkout"),
                          )
                        ],
                      ),
                    )
                  ],
                );
        },
      ),
    );
  }
}
