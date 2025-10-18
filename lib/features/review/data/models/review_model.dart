class ReviewModel {
  final String id;
  final String productId;
  final String userId;
  final String userName;
  final String comment;
  final int rating;
  final String createdAt;

  ReviewModel({
    required this.id,
    required this.productId,
    required this.userId,
    required this.userName,
    required this.comment,
    required this.rating,
    required this.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> jsonData) {
    return ReviewModel(
      id: jsonData['_id']?.toString() ?? '',
      productId: _extractId(jsonData['product']),
      userId: _extractId(jsonData['user']),
      userName: _extractUserName(jsonData),
      comment: jsonData['comment']?.toString() ?? '',
      rating: jsonData['rating'] is int
          ? jsonData['rating']
          : int.tryParse(jsonData['rating']?.toString() ?? '0') ?? 0,
      createdAt:
          jsonData['createdAt']?.toString() ??
          jsonData['created_at']?.toString() ??
          '',
    );
  }

  static String _extractId(dynamic value) {
    if (value is String) {
      return value;
    } else if (value is Map<String, dynamic> && value['_id'] != null) {
      return value['_id'].toString();
    }
    return '';
  }

  static String _extractUserName(Map<String, dynamic> jsonData) {
    // Try different possible user name fields
    if (jsonData['user_name'] != null) {
      return jsonData['user_name'].toString();
    }
    if (jsonData['userName'] != null) {
      return jsonData['userName'].toString();
    }
    if (jsonData['user'] is Map<String, dynamic>) {
      final user = jsonData['user'] as Map<String, dynamic>;
      if (user['first_name'] != null && user['last_name'] != null) {
        return '${user['first_name']} ${user['last_name']}';
      }
      if (user['name'] != null) {
        return user['name'].toString();
      }
    }
    return 'Anonymous';
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'product': productId,
      'user': userId,
      'user_name': userName,
      'comment': comment,
      'rating': rating,
      'created_at': createdAt,
    };
  }
}
