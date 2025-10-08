import 'package:e_commerce/app/core/models/network_response.dart';
import 'package:e_commerce/app/core/services/network_caller.dart';
import 'package:e_commerce/app/urls.dart';
import 'package:e_commerce/features/shared/data/models/category_model.dart';
import 'package:get/get.dart';

class CategoryController extends GetxController {
  int _currentPage = 0;

  int? _lastPageNo;

  final int _pageSize = 30;

  bool _getCategoryInProgress = false;

  bool _isInitialLoading = false;

  String? _errorMessage;

  List<CategoryModel> _categorieList = [];

  bool get getCategoryInProgress => _getCategoryInProgress;

  bool get isInitialLoading => _isInitialLoading;

  List<CategoryModel> get categorieList => _categorieList;

  String? get errorMessage => _errorMessage;

  Future<bool> getCategoryList() async {
    bool isSuccess = false;

    if (_lastPageNo != null && _currentPage >= _lastPageNo!) {
      return false;
    }

    if (_currentPage == 0) {
      _categorieList.clear();
      _isInitialLoading = true;
    } else {
      _getCategoryInProgress = true;
    }
    update();

    _currentPage++;

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: urls.categoryList(_currentPage, _pageSize),
    );

    if (response.isSuccess) {
      final data = response.body!['data'];
      _lastPageNo = data['last_page'];
      List<CategoryModel> list = [
        for (Map<String, dynamic> jsonData in data['results'])
          CategoryModel.fromJson(jsonData)
      ];
      _categorieList.addAll(list);
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _isInitialLoading = false;
    _getCategoryInProgress = false;
    update();

    return isSuccess;
  }

  Future<void> refreshCategories() async {
    _currentPage = 0;
    getCategoryList();
  }

}
