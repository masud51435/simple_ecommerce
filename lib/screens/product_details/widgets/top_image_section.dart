import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../core/app_colors.dart';
import '../../../model/product_model.dart';

class TopImageSection extends StatelessWidget {
  const TopImageSection({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      height: Get.height * 0.45,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton.filled(
                onPressed: () {
                  Get.back();
                },
                style: IconButton.styleFrom(backgroundColor: whiteColor),
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.grey.shade700,
                ),
              ),
              const Text(
                'Product Details',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton.filled(
                onPressed: () {},
                style: IconButton.styleFrom(backgroundColor: whiteColor),
                icon: Icon(
                  Icons.favorite_border_outlined,
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),
          Expanded(
            child: CachedNetworkImage(
              fit: BoxFit.contain,
              imageUrl: product.image.toString(),
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Center(
                child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Colors.purple.shade300,
                  size: 30,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
        ],
      ),
    );
  }
}
