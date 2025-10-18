import 'package:e_commerce/features/review/presentation/controller/review_controller.dart';
import 'package:e_commerce/features/shared/presentation/widgets/center_cicular_progress.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'create_review_screen.dart';
import '../widgets/review_bar.dart';
import '../widgets/review_card.dart';

class ReviewScreen extends StatefulWidget {
  final String productId;

  const ReviewScreen({super.key, required this.productId});

  static const String name = '/review-screen';

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final ReviewController _reviewController = Get.find<ReviewController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _reviewController.getReviews(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reviews')),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<ReviewController>(
              builder: (controller) {
                if (controller.inProgress) {
                  return CenterCicularProgress();
                } else if (controller.reviewList.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.reviews_outlined,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No reviews yet',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Be the first to review this product',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[500],
                          ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: controller.reviewList.length,
                  itemBuilder: (context, index) {
                    final review = controller.reviewList[index];
                    return ReviewCard(review: review);
                  },
                );
              },
            ),
          ),
          ReviewBar(
            buttonName: '+',
            heading: 'Reviews(${_reviewController.getTotalReviews()})',
            onTap: () {
              Navigator.pushNamed(
                context,
                CreateReviewScreen.name,
                arguments: widget.productId,
              );
            },
          ),
        ],
      ),
    );
  }
}
