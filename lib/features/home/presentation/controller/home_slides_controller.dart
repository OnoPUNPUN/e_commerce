import 'package:e_commerce/app/core/models/network_response.dart';
import 'package:e_commerce/app/urls.dart';
import 'package:e_commerce/features/home/data/models/home_sliders.dart';
import 'package:get/get.dart';

import '../../../../app/core/services/network_caller.dart';

class HomeSlidesController extends GetxController {
  bool _getSlidersInprogress = false;

  String? _errorMessage;

  List<HomeSliders> _sliders = [];

  bool get getSlidersInprogress => _getSlidersInprogress;

  String? get errorMessage => _errorMessage;

  List<HomeSliders> get sliders => _sliders;

  Future<bool> getHomeSliders() async {
    bool isSuccess = true;
    update();
    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: urls.homeSliderUrl,
    );

    if (response.isSuccess) {
      _errorMessage = null;
      List<HomeSliders> listOfSliders = [];
      for (Map<String, dynamic> jsonData
          in response.body!['data']['results'] ?? []) {
        listOfSliders.add(HomeSliders.fromJson(jsonData));
      }
      _sliders = listOfSliders;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _getSlidersInprogress = false;
    update();

    return isSuccess;
  }
}
