import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_ecommerce/controller/product_controller.dart';

import 'widgets/home_appbar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductController controller = Get.put(ProductController());

    return Scaffold(
      appBar: HomeAppBar(controller: controller),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.filteredProducts.isEmpty) {
          return const Center(
            child: Text('No products available.'),
          );
        }

        return ListView.builder(
          itemCount: controller.filteredProducts.length,
          itemBuilder: (BuildContext context, int index) {
            final product = controller.filteredProducts[index];

            return ListTile(
              tileColor:
                  index.isEven ? Colors.grey.shade100 : Colors.grey.shade200,
              title: Text(product.title ?? 'No title available'),
            );
          },
        );
      }),
    );
  }
}
