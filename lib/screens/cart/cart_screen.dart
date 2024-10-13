import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:simple_ecommerce/common/appbar/Custom_appbar.dart';

import 'package:simple_ecommerce/model/product_model.dart';
import 'package:simple_ecommerce/screens/cart/widgets/bottom_sheet_item.dart';

import '../../controller/cart_controller.dart';
import '../../core/app_colors.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = Get.find<CartController>();

    return Scaffold(
      appBar: const CustomAppBar(title: Text('Your Cart')),
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
                            size: 20,
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
                            ' \$${individualTotalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 25),
                          Row(
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
                  onPressed: () {
                    showModalBottomSheet<void>(
                      context: context,
                      builder: (BuildContext context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                height: 7,
                                width: 60,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade500,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          
                            BottomSheetItem(
                              title: 'Sub-Total',
                              price:
                                  '\$${cartController.totalPrice.toStringAsFixed(2)}',
                            ),
                            const BottomSheetItem(
                              title: 'Delivery Fee',
                              price: '\$${00}',
                            ),
                            const BottomSheetItem(
                              title: 'Discount',
                              price: '-\$${00}',
                            ),
                            const Divider(),
                            BottomSheetItem(
                              title: 'Total Cost',
                              price:
                                  '\$${cartController.totalPrice.toStringAsFixed(2)}',
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: ElevatedButton(
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                  fixedSize: Size(Get.width, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Text(
                                  'Proceed to Order',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
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
