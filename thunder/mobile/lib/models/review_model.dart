class ReviewModel {
  final int rating;
  final String comment;

  ReviewModel({required this.rating, required this.comment});

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      rating: json["rating"] ?? 0,
      comment: json["comment"] ?? "",
    );
  }
}
