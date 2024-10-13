import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:simple_ecommerce/model/product_model.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final searchController = TextEditingController();
  RxBool isLoading = false.obs;
  RxList<ProductModel> products = RxList<ProductModel>();
  RxList<ProductModel> filteredProducts = RxList<ProductModel>();
  RxString searchQuery = ''.obs;

  // Hive box for storing products
  late Box<ProductModel> productBox;

  @override
  void onInit() {
    super.onInit();
    // Initialize Hive box for storing products
    productBox = Hive.box<ProductModel>("productBox");
    loadProducts();
    searchController.addListener(() {
      filterProducts(searchController.text);
    });
  }

  // Load products either from Hive or by fetching from API
  Future<void> loadProducts() async {
    // If products exist in Hive, load them
    if (productBox.isNotEmpty) {
      final productItems = productBox.values.toList();
      products.clear();
      products.addAll(productItems);
      filteredProducts.assignAll(products);
    } else {
      // If no products are found in Hive, fetch from the API
      await getProducts();
    }
  }

  // Fetch products from API and store them in Hive
  Future<void> getProducts() async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse("https://fakestoreapi.com/products"),
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);

        // Clear Hive box before adding new data
        await productBox.clear();

        // Parse API data and save it to Hive
        products.clear();
        products.addAll(
          jsonResponse.map<ProductModel>(
            (json) => ProductModel.fromJson(json),
          ),
        );

        for (var product in products) {
          productBox.put(product.id, product);
        }

        // Assign the products to the filtered list
        filteredProducts.assignAll(products);
      }
    } catch (e) {
      throw e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  // Method to filter products based on search query
  void filterProducts(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredProducts.assignAll(products);
    } else {
      filteredProducts.assignAll(
        products.where(
          (product) => product.title!.toLowerCase().contains(
                query.toLowerCase(),
              ),
        ),
      );
    }
  }
}
