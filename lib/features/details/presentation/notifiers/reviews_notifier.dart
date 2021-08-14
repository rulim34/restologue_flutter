import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/domain/entities/customer_review.dart';
import '../../domain/usecases/post_review.dart';
import 'notifiers.dart';

@injectable
class ReviewsNotifier extends StateNotifier<ReviewsState> {
  final PostReview _postReview;
  String? id;
  String? name;
  String? review;

  ReviewsNotifier(
    this._postReview,
  ) : super(const ReviewsInitial());

  void setInitialReviews({
    required List<CustomerReview> reviews,
  }) {
    state = ReviewsLoaded(
      reviews: reviews,
    );
  }

  Future<void> postReview() async {
    state = const ReviewsLoading();

    final failureOrReviews = await _postReview(
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
