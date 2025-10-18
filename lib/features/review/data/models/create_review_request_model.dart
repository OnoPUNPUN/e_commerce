class CreateReviewRequestModel {
  final String product;
  final String comment;
  final String rating;

  CreateReviewRequestModel({
    required this.product,
    required this.comment,
    required this.rating,
  });

  Map<String, dynamic> toJson() {
    return {'product': product, 'comment': comment, 'rating': rating};
  }
}
