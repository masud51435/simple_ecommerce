import 'package:flutter/material.dart';

import '../../../model/product_model.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(product.category ?? ''),
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.orangeAccent,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    product.rating!.rate.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            product.title ?? "",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            product.description ?? "",
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }
}
