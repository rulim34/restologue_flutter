import '../entities/customer_review.dart';

class CustomerReviewModel extends CustomerReview {
  const CustomerReviewModel({
    required String name,
    required String review,
    required String date,
  }) : super(
          name: name,
          review: review,
          date: date,
        );

  factory CustomerReviewModel.fromJson(Map<dynamic, dynamic> json) {
    return CustomerReviewModel(
      name: json['name'] as String,
      review: json['review'] as String,
      date: json['date'] as String,
    );
  }
}
