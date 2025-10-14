import 'package:e_commerce/app/urls.dart';
import 'package:get/get.dart';

import '../../../../app/core/models/network_response.dart';
import '../../../../app/core/services/network_caller.dart';
import '../../data/models/product_model.dart';

class SpecialProductController extends GetxController {
  int _currentPage = 0;
  int? _lastPageNo;
  final int _pageSize = 10;
  bool _getProductListInProgress = false;
  bool _isInitialLoading = false;
  final List<ProductModel> _productList = [];
  String? _errorMessage;

  bool get getProductsInProgress => _getProductListInProgress;
  bool get isInitialLoading => _isInitialLoading;
  List<ProductModel> get productList => _productList;
  String? get errorMessage => _errorMessage;

  @override
  void onInit() {
    super.onInit();
    getSpecialProducts();
  }

  Future<bool> getSpecialProducts() async {
    bool isSuccess = false;

    if (_currentPage > (_lastPageNo ?? 1)) {
      return false;
    }
    if (_currentPage == 0) {
      _productList.clear();
      _isInitialLoading = true;
    } else {
      _getProductListInProgress = true;
    }
    update();

    _currentPage++;

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
        url: urls.specialProducts(_currentPage, _pageSize));

    if (response.isSuccess) {
      _lastPageNo = response.body!['data']['last_page'];
      List<ProductModel> list = [];
      for (Map<String, dynamic> jsonData in response.body!['data']['results']) {
        list.add(ProductModel.fromJson(jsonData));
      }
      _productList.addAll(list);
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }

    if (_isInitialLoading) {
      _isInitialLoading = false;
    } else {
      _getProductListInProgress = false;
    }

    update();
    return isSuccess;
  }

  Future<void> refreshSpecialProducts() async {
    _currentPage = 0;
    getSpecialProducts();
  }
}