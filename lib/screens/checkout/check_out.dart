import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:simple_ecommerce/common/appbar/Custom_appbar.dart';

import '../../controller/cart_controller.dart';
import '../cart/widgets/bottom_sheet_item.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({super.key});

  @override
  Widget build(BuildContext context) {
    final CartController cartController = CartController.instance;
    return Scaffold(
      appBar: const CustomAppBar(title: Text('Check Out')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Review your cart',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                  itemCount: cartController.cartItems.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final cartItem = cartController.cartItems[index];
                    final product = cartItem.productModel;
                    final individualTotalPrice =
                        product.price! * cartItem.quantity;

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
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                "${cartItem.quantity}x",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                            ),
                          ),
                          trailing: Text(
                            '\$${individualTotalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                        ),
                        const Divider(),
                      ],
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                BottomSheetItem(
                  title: 'Sub-Total',
                  price: '\$${cartController.totalPrice.toStringAsFixed(2)}',
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
                  price: '\$${cartController.totalPrice.toStringAsFixed(2)}',
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    final user = FirebaseAuth.instance.currentUser;

                    if (user != null) {
                      Get.toNamed('/orderConfirm');
                      cartController.clearCart();
                    } else {
                      Get.toNamed('/signUp');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    fixedSize: Size(Get.width, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
