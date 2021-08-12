import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/customer_review.dart';
import '../../domain/usecases/post_review.dart';
import 'notifiers.dart';

@injectable
class ReviewsNotifier extends StateNotifier<ReviewsState> {
  PostReview postReview;
  String? id;
  String? name;
  String? review;

  ReviewsNotifier({
    required this.postReview,
  }) : super(const ReviewsInitial());

  void setInitialReviews({
    required List<CustomerReview> reviews,
  }) {
    state = ReviewsLoaded(
      reviews: reviews,
    );
  }

  Future<void> sendReview() async {
    state = const ReviewsLoading();

    final failureOrReviews = await postReview(
      data: {
        'id': id,
        'name': name,
        'review': review!,
      },
    );

    failureOrReviews.fold(
      (failure) {
        state = const ReviewsError(
          message: 'Failed to fetch restaurant reviews.',
        );
      },
      (reviews) {
        state = ReviewsLoaded(
          reviews: reviews,
        );
      },
    );
  }
}
