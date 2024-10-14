import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../common/appbar/Custom_appbar.dart';
import '../../controller/cart_controller.dart';
import '../../core/app_colors.dart';
import 'widgets/bottom_section.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = CartController.instance;
    return Scaffold(
      appBar: const CustomAppBar(title: Text('Your Cart')),
      body: Obx(
        () {
          if (cartController.cartItems.isEmpty) {
            return const Center(
              child: Text(
                'Your cart is empty',
              ),
            );
          }
          return ListView.builder(
            itemCount: cartController.cartItems.length,
            itemBuilder: (context, index) {
              final cartItem = cartController.cartItems[index];
              final product = cartItem.productModel;
              final individualTotalPrice = product.price! * cartItem.quantity;

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
                          size: 20,
                        ),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    title: Text(
                      product.title ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '\$${individualTotalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          const SizedBox(width: 20),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Decrease quantity button
                              InkWell(
                                onTap: () =>
                                    cartController.decreaseQuantity(product),
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade300,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: const Icon(Icons.remove),
                                ),
                              ),
                              // Display quantity
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  cartItem.quantity.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              // Increase quantity button
                              InkWell(
                                onTap: () =>
                                    cartController.increaseQuantity(product),
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                      color: Colors.grey.shade700,
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Icon(
                                    Icons.add,
                                    color: whiteColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
        },
      ),
      bottomNavigationBar: BottomSection(cartController: cartController),
    );
  }
}
