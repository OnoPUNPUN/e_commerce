import 'shipping_address_model.dart';

class CreateOrderRequestModel {
  final String paymentMethod;
  final ShippingAddressModel shippingAddress;
  final String redirectUrl;

  CreateOrderRequestModel({
    required this.paymentMethod,
    required this.shippingAddress,
    required this.redirectUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'payment_method': paymentMethod,
      'shipping_address': shippingAddress.toJson(),
      'redirect_url': redirectUrl,
    };
  }
}
