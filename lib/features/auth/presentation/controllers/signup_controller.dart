import 'package:e_commerce/app/core/models/network_response.dart';
import 'package:e_commerce/app/core/services/network_caller.dart';
import 'package:e_commerce/app/urls.dart';
import 'package:e_commerce/features/auth/data/model.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  bool _inProgress = false;

  bool get signUpInProgress => _inProgress;

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  Future<void> signUp(SignUpRequestModel requestModel) async {
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(url: urls.signUpUrl, body: requestModel.toJson());

    if(response.isSuccess) {

    } else {

    }
  }
}
