import 'package:e_commerce/app/urls.dart';
import 'package:get/get.dart';

import '../../../../app/core/models/network_response.dart';
import '../../../../app/core/services/network_caller.dart';
import '../../data/models/wishlist_item_model.dart';

class WishlistController extends GetxController {
  bool _inProgress = false;
  List<WishlistItemModel> _wishlistItemList = [];

  bool get inProgress => _inProgress;
  List<WishlistItemModel> get wishlistItemList => _wishlistItemList;
  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  Future<bool> getWishlist() async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: urls.wishlistUrl,
    );

    if (response.isSuccess) {
      List<WishlistItemModel> list = [];
      for (Map<String, dynamic> jsonData in response.body!['data']['results']) {
        list.add(WishlistItemModel.fromJson(jsonData));
      }
      _wishlistItemList = list;
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }

  Future<bool> addToWishlist(String productId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(url: urls.wishlistUrl, body: {'product': productId});

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
      // Refresh wishlist after adding
      await getWishlist();
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }

  Future<bool> removeFromWishlist(String wishlistItemId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .deleteRequest(url: urls.deleteWishlistItemUrl(wishlistItemId));

    if (response.isSuccess) {
      _wishlistItemList.removeWhere((item) => item.id == wishlistItemId);
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }

  bool isInWishlist(String productId) {
    return _wishlistItemList.any((item) => item.product.id == productId);
  }

  String? getWishlistItemId(String productId) {
    try {
      return _wishlistItemList
          .firstWhere((item) => item.product.id == productId)
          .id;
    } catch (e) {
      return null;
    }
  }
}
