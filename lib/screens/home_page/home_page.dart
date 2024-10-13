import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:simple_ecommerce/controller/product_controller.dart';

import 'widgets/home_appbar.dart';
import 'widgets/product.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.put(ProductController());

    return Scaffold(
      appBar: HomeAppBar(controller: controller),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return Center(
              child: LoadingAnimationWidget.hexagonDots(
                color: Colors.blue,
                size: 50,
              ),
            );
          }

          if (controller.filteredProducts.isEmpty) {
            return const Center(
              child: Text('No products available.'),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(15),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 0.75,
            ),
            itemCount: controller.filteredProducts.length,
            itemBuilder: (BuildContext context, int index) {
              final product = controller.filteredProducts[index];
              return Product(product: product);
            },
          );
        },
      ),
    );
  }
}
