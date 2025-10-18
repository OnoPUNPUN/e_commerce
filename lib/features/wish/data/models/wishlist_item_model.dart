import 'package:e_commerce/features/shared/data/models/product_model.dart';

class WishlistItemModel {
  final String id;
  final ProductModel product;

  WishlistItemModel({required this.id, required this.product});

  factory WishlistItemModel.fromJson(Map<String, dynamic> jsonData) {
    return WishlistItemModel(
      id: jsonData['_id'],
      product: ProductModel.fromJson(jsonData['product']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'_id': id, 'product': product.toJson()};
  }
}
