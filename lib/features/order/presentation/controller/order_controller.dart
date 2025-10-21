import 'package:e_commerce/app/urls.dart';
import 'package:e_commerce/features/order/data/models/create_order_request_model.dart';
import 'package:e_commerce/features/order/data/models/order_model.dart';
import 'package:e_commerce/features/order/data/models/shipping_address_model.dart';
import 'package:get/get.dart';

import '../../../../app/core/models/network_response.dart';
import '../../../../app/core/services/network_caller.dart';
import 'ssl_payment_helper.dart';

class OrderController extends GetxController {
  bool _inProgress = false;
  bool _paymentInProgress = false;
  OrderModel? _orderModel;
  String? _errorMessage;
  Map<String, dynamic>? _paymentResult;

  bool get inProgress => _inProgress;
  bool get paymentInProgress => _paymentInProgress;
  OrderModel? get orderModel => _orderModel;
  String? get errorMessage => _errorMessage;
  Map<String, dynamic>? get paymentResult => _paymentResult;

  Future<bool> createOrder({
    required String fullName,
    required String address,
    required String city,
    required String postalCode,
    required String phone,
  }) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final shippingAddress = ShippingAddressModel(
      fullName: fullName,
      address: address,
      city: city,
      postalCode: postalCode,
      phone: phone,
    );

    final orderRequest = CreateOrderRequestModel(
      paymentMethod: 'ssl',
      shippingAddress: shippingAddress,
      redirectUrl: 'https://jsonplaceholder.typicode.com/posts',
    );

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(url: urls.createOrderUrl, body: orderRequest.toJson());

    if (response.isSuccess) {
      _orderModel = OrderModel.fromJson(response.body!['data']);
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }

  Future<bool> processPayment({required int totalAmount}) async {
    bool isSuccess = false;
    _paymentInProgress = true;
    _errorMessage = null;
    update();

    try {
      final String tranId = DateTime.now().millisecondsSinceEpoch.toString();

      final Map<String, dynamic> paymentResult =
          await SSLPaymentHelper.processPayment(
            totalAmount: totalAmount,
            tranId: tranId,
          );

      _paymentResult = paymentResult;

      if (paymentResult['success'] == true) {
        _errorMessage = null;
        isSuccess = true;
      } else {
        _errorMessage = paymentResult['message'] ?? 'Payment failed';
      }
    } catch (e) {
      _errorMessage = 'Payment processing failed: $e';
      print('Order Controller Payment Error: $e');
    }

    _paymentInProgress = false;
    update();

    return isSuccess;
  }

  Future<bool> createOrderWithPayment({
    required String fullName,
    required String address,
    required String city,
    required String postalCode,
    required String phone,
    required int totalAmount,
  }) async {
    bool isSuccess = false;
    _inProgress = true;
    _errorMessage = null;
    update();

    final bool orderCreated = await createOrder(
      fullName: fullName,
      address: address,
      city: city,
      postalCode: postalCode,
      phone: phone,
    );

    if (orderCreated) {
      final bool paymentSuccess = await processPayment(
        totalAmount: totalAmount,
      );
      isSuccess = paymentSuccess;
    } else {
      _errorMessage = 'Failed to create order';
    }

    _inProgress = false;
    update();

    return isSuccess;
  }
}
