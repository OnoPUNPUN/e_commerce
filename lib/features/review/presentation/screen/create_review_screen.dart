import 'package:e_commerce/features/review/data/models/create_review_request_model.dart';
import 'package:e_commerce/features/review/presentation/controller/review_controller.dart';
import 'package:e_commerce/features/shared/presentation/widgets/center_cicular_progress.dart';
import 'package:e_commerce/features/shared/presentation/widgets/show_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateReviewScreen extends StatefulWidget {
  final String productId;

  const CreateReviewScreen({super.key, required this.productId});

  static const String name = '/create-review';

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _reviewTEController = TextEditingController();
  final ReviewController _reviewController = Get.find<ReviewController>();
  int _selectedRating = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Create Review')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Text(
                  'Rate this product',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                _buildRatingSelector(),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _reviewTEController,
                  maxLines: 6,
                  decoration: InputDecoration(hintText: "Write a Review"),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Review cannot be empty';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                GetBuilder<ReviewController>(
                  builder: (controller) {
                    return Visibility(
                      visible: !controller.inProgress,
                      replacement: CenterCicularProgress(),
                      child: FilledButton(
                        onPressed: () {
                          if (_formKey.currentState?.validate() ?? false) {
                            _submitReview();
                          }
                        },
                        child: Text("Submit Review"),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRatingSelector() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedRating = index + 1;
            });
          },
          child: Icon(
            index < _selectedRating ? Icons.star : Icons.star_border,
            color: Colors.amber,
            size: 40,
          ),
        );
      }),
    );
  }

  Future<void> _submitReview() async {
    final CreateReviewRequestModel requestModel = CreateReviewRequestModel(
      product: widget.productId,
      comment: _reviewTEController.text.trim(),
      rating: _selectedRating.toString(),
    );

    bool isSuccess = await _reviewController.createReview(requestModel);

    if (isSuccess) {
      showSnackbarMessage(context, 'Review submitted successfully');
      // Refresh the review list before going back
      await _reviewController.getReviews(widget.productId);
      Navigator.pop(context);
    } else {
      showSnackbarMessage(
        context,
        _reviewController.errorMessage ?? 'Failed to submit review',
      );
    }
  }

  @override
  void dispose() {
    _reviewTEController.dispose();
    super.dispose();
  }
}
