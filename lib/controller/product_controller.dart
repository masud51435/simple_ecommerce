import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:simple_ecommerce/model/product_model.dart';

class ProductController extends GetxController {
  static ProductController get instance => Get.find();

  final searchController = TextEditingController();
  RxBool isLoading = false.obs;
  RxList<ProductModel> products = RxList<ProductModel>();
  RxList<ProductModel> filteredProducts = RxList<ProductModel>();
  RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getProducts();
    searchController.addListener(() {
      filterProducts(searchController.text);
    });
  }

  Future<void> getProducts() async {
    try {
      isLoading.value = true;
      final response = await http.get(
        Uri.parse("https://fakestoreapi.com/products"),
      );
      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        products.clear();
        products.addAll(
          jsonResponse.map<ProductModel>(
            (json) => ProductModel.fromJson(json),
          ),
        );
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
