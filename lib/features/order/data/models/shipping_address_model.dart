class ShippingAddressModel {
  final String fullName;
  final String address;
  final String city;
  final String postalCode;
  final String phone;

  ShippingAddressModel({
    required this.fullName,
    required this.address,
    required this.city,
    required this.postalCode,
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      'full_name': fullName,
      'address': address,
      'city': city,
      'postal_code': postalCode,
      'phone': phone,
    };
  }
}
