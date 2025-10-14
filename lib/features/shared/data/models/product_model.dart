class ProductModel {
  final String id;
  final String title;
  final List<String> photos;
  final int currentPrice;
  final double rating;
  final String? brand;
  final List<String>? tags;

  ProductModel({
    required this.id,
    required this.title,
    required this.photos,
    required this.currentPrice,
    required this.rating,
    this.brand,
    this.tags,
  });

  factory ProductModel.fromJson(Map<String, dynamic> jsonData) {
    List<String> photosList = [];

    if (jsonData['photos'] != null) {
      photosList = List<String>.from(
        jsonData['photos'].map((e) => e.toString()).toList(),
      );
    } else if (jsonData['image'] != null) {
      photosList = [jsonData['image'].toString()];
    }

    String? brandName;
    if (jsonData['brand'] != null) {
      if (jsonData['brand'] is Map) {
        brandName = jsonData['brand']['title'];
      } else if (jsonData['brand'] is String) {
        brandName = jsonData['brand'];
      }
    }

    List<String>? tagsList;
    if (jsonData['tags'] != null) {
      tagsList = List<String>.from(
        jsonData['tags'].map((e) => e.toString()).toList(),
      );
    }

    return ProductModel(
      id: jsonData['_id'] ?? '',
      title: jsonData['title'] ?? '',
      photos: photosList,
      currentPrice: jsonData['current_price'] ?? 0,
      rating: (jsonData['rating'] as num?)?.toDouble() ?? 0.0,
      brand: brandName,
      tags: tagsList,
    );
  }
}
