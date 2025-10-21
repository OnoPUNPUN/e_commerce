import 'dart:convert';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';

class SSLPaymentHelper {
  static Future<Map<String, dynamic>> processPayment({
    required int totalAmount,
    required String tranId,
  }) async {
    try {
      Sslcommerz sslcommerz = Sslcommerz(
        initializer: SSLCommerzInitialization(
          multi_card_name: "visa,master,bkash",
          currency: SSLCurrencyType.BDT,
          product_category: "Digital Product",
          sdkType: SSLCSdkType.TESTBOX,
          store_id: "rootx68f1c22c9d879",
          store_passwd: "rootx68f1c22c9d879@ssl",
          total_amount: totalAmount.toDouble(),
          tran_id: tranId,
        ),
      );

      final response = await sslcommerz.payNow();

      if (response.status == 'VALID') {
        print(jsonEncode(response));
        print('Payment completed, TRX ID: ${response.tranId}');
        print(response.tranDate);
        return {
          'success': true,
          'status': response.status,
          'tranId': response.tranId,
          'tranDate': response.tranDate,
        };
      }

      if (response.status == 'Closed') {
        print('Payment closed');
        return {
          'success': false,
          'status': response.status,
          'message': 'Payment closed',
        };
      }

      if (response.status == 'FAILED') {
        print('Payment failed');
        return {
          'success': false,
          'status': response.status,
          'message': 'Payment failed',
        };
      }

      return {
        'success': false,
        'status': response.status,
        'message': 'Unknown payment status',
      };
    } catch (e) {
      print('SSL Payment Error: $e');
      return {
        'success': false,
        'status': 'ERROR',
        'message': 'Payment processing failed: $e',
      };
    }
  }
}
