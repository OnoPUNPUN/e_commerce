import 'package:flutter/material.dart';

import '../widgets/review_bar.dart';
import '../widgets/review_card.dart';

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key});

  static const String name = '/review-screen';

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Reviews',)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return ReviewCard();
              },
            ),
          ),
          ReviewBar(buttonName: '+', heading: 'Reviews(1000)',)
        ],
      ),
    );
  }
}
