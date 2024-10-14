import 'package:hive/hive.dart';
import 'package:simple_ecommerce/model/product_model.dart';

part 'cart_item_model.g.dart';

@HiveType(typeId: 2)
class CartItemModel {
  @HiveField(0)
   ProductModel productModel;
  @HiveField(1)
  num quantity;

  CartItemModel({required this.productModel, this.quantity = 1});
}
