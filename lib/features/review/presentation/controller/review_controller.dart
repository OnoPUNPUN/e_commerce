import 'package:e_commerce/app/urls.dart';
import 'package:get/get.dart';

import '../../../../app/core/models/network_response.dart';
import '../../../../app/core/services/network_caller.dart';
import '../../data/models/create_review_request_model.dart';
import '../../data/models/review_model.dart';
import '../../data/models/update_review_request_model.dart';

class ReviewController extends GetxController {
  bool _inProgress = false;
  List<ReviewModel> _reviewList = [];
  String? _errorMessage;

  bool get inProgress => _inProgress;
  List<ReviewModel> get reviewList => _reviewList;
  String? get errorMessage => _errorMessage;

  Future<bool> createReview(CreateReviewRequestModel requestModel) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .postRequest(url: urls.createReviewUrl, body: requestModel.toJson());

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }

  Future<bool> updateReview(
    String reviewId,
    UpdateReviewRequestModel requestModel,
  ) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>()
        .patchRequest(
          url: urls.updateReviewUrl(reviewId),
          body: requestModel.toJson().cast<String, String>(),
        );

    if (response.isSuccess) {
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }

  Future<bool> getReviews(String productId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();

    final NetworkResponse response = await Get.find<NetworkCaller>().getRequest(
      url: urls.getReviewsUrl(productId),
    );

    if (response.isSuccess) {
      List<ReviewModel> list = [];
      if (response.body != null) {
        print('🔍 API Response structure: ${response.body}');

        // Handle different possible response structures
        dynamic data = response.body!['data'];
        print('📊 Data type: ${data.runtimeType}');

        if (data is List) {
          print('📋 Data is a list with ${data.length} items');
          // If data is already a list
          for (int i = 0; i < data.length; i++) {
            print('📄 Review $i: ${data[i]}');
            try {
              list.add(ReviewModel.fromJson(data[i]));
            } catch (e) {
              print('❌ Error parsing review $i: $e');
            }
          }
        } else if (data is Map && data['results'] is List) {
          print(
            '📋 Data has results field with ${data['results'].length} items',
          );
          // If data has a 'results' field containing the list
          for (int i = 0; i < data['results'].length; i++) {
            print('📄 Review $i: ${data['results'][i]}');
            try {
              list.add(ReviewModel.fromJson(data['results'][i]));
            } catch (e) {
              print('❌ Error parsing review $i: $e');
            }
          }
        } else {
          print('⚠️ Unknown data structure: $data');
        }
      }
      _reviewList = list;
      _errorMessage = null;
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }

    _inProgress = false;
    update();

    return isSuccess;
  }

  double getAverageRating() {
    if (_reviewList.isEmpty) return 0.0;

    double totalRating = 0.0;
    for (ReviewModel review in _reviewList) {
      totalRating += review.rating;
    }

    return totalRating / _reviewList.length;
  }

  int getTotalReviews() {
    return _reviewList.length;
  }
}
