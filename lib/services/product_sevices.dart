import 'package:get/get.dart';
import 'package:simple_ecommerce/model/product_model.dart';

class ProductService extends GetConnect {
  static const String _baseUrl = "https://fakestoreapi.com/products";

  // Fetch products using GetConnect with pagination
  Future<List<ProductModel>> fetchProducts(int page, int limit) async {
    final response = await get('$_baseUrl?limit=$limit&page=$page');

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = response.body;
      return jsonResponse
          .map(
            (json) => ProductModel.fromJson(json),
          )
          .toList();
    } else {
      throw Exception(
          'Failed to load products, status code: ${response.statusCode}');
    }
  }
}
