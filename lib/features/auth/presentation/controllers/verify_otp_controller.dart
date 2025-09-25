import 'package:e_commerce/app/urls.dart';
import 'package:get/get.dart';

import '../../../../app/core/models/network_response.dart';
import '../../../../app/core/services/network_caller.dart';
import '../../../shared/data/models/user_model.dart';
import '../../data/verify_otp_request_model.dart';

class VerifyOtpController extends GetxController {
  bool _verifyOtpInProgress = false;
  String? _errorMessage;
  UserModel? _userModel;
  String? _accessToken;

  String? get errorMessage => _errorMessage;

  bool get verifyOtpInProgress => _verifyOtpInProgress;

  UserModel? get userModel => _userModel;

  String? get accessToken => _accessToken;

  Future<bool> verifyOtp(VerifyOtpRequestModel model) async {
    bool isSuccess = false;
    _verifyOtpInProgress = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(url: urls.verifyOtpUrl, body: model.toJson());

    if (response.isSuccess) {
      _errorMessage = null;
      _userModel = UserModel.fromJson(response.body!['data']['user']);
      _accessToken = response.body!['data']['token'];
      isSuccess = true;
    } else {
      _errorMessage = response.body?['msg'] ?? response.errorMessage;
    }
    _verifyOtpInProgress = false;
    update();

    return isSuccess;
  }
}