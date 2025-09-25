import 'package:e_commerce/app/core/models/network_response.dart';
import 'package:e_commerce/app/core/services/network_caller.dart';
import 'package:e_commerce/app/urls.dart';
import 'package:e_commerce/features/auth/data/login_request_model.dart';
import 'package:get/get.dart';

import '../../../shared/data/models/user_model.dart';

class LoginController extends GetxController {
  bool _inProgress = false;
  UserModel? _userModel;
  String? _accessToken;
  String? _errorMessage;

  bool get logInProgress => _inProgress;

  UserModel? get userModel => _userModel;

  String? get accessToken => _accessToken;

  String? get errorMessage => _errorMessage;

  Future<bool> login(LoginRequestModel requestModel) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(url: urls.loginUrl, body: requestModel.toJson());

    if (response.isSuccess) {
      _errorMessage = null;
      _userModel = UserModel.fromJson(response.body!['data']['user']);
      _accessToken = response.body!['data']['token'];
      isSuccess = true;
    } else {
      _errorMessage = response.body?['msg'] ?? response.errorMessage;
    }
    _inProgress = false;
    update();

    return isSuccess;
  }
}
