class OrderModel {
  final String id;
  final String paymentMethod;
  final String status;
  final int totalAmount;
  final String createdAt;
  final String? paymentUrl;

  OrderModel({
    required this.id,
    required this.paymentMethod,
    required this.status,
    required this.totalAmount,
    required this.createdAt,
    this.paymentUrl,
  });

  factory OrderModel.fromJson(Map<String, dynamic> jsonData) {
    return OrderModel(
      id: jsonData['_id']?.toString() ?? '',
      paymentMethod: jsonData['payment_method']?.toString() ?? '',
      status: jsonData['status']?.toString() ?? '',
      totalAmount: jsonData['total_amount'] ?? 0,
      createdAt: jsonData['created_at']?.toString() ?? '',
      paymentUrl: jsonData['payment_url']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'payment_method': paymentMethod,
      'status': status,
      'total_amount': totalAmount,
      'created_at': createdAt,
      'payment_url': paymentUrl,
    };
  }
}
