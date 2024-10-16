import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:simple_ecommerce/core/app_colors.dart';
import 'package:simple_ecommerce/model/product_model.dart';
import 'package:simple_ecommerce/screens/product_details/widgets/top_image_section.dart';

import '../../controller/cart_controller.dart';
import 'widgets/product_description.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final CartController cartController = CartController.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopImageSection(product: product),
            ProductDescription(product: product),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
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
                  '\$${product.price}',
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
                  cartController.addToCart(product);
                },
                label: const Text(
                  'Add to Cart',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
                icon: Icon(
                  Icons.shopping_cart,
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
    );
  }
}
