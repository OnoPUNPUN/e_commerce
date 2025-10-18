class UpdateReviewRequestModel {
  final String comment;
  final String rating;

  UpdateReviewRequestModel({required this.comment, required this.rating});

  Map<String, dynamic> toJson() {
    return {'comment': comment, 'rating': rating};
  }
}
