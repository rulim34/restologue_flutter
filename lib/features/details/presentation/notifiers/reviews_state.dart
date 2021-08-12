import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/entities/customer_review.dart';

@immutable
abstract class ReviewsState extends Equatable {
  const ReviewsState();

  @override
  List<Object> get props => [];
}

class ReviewsInitial extends ReviewsState {
  const ReviewsInitial();
}

class ReviewsLoading extends ReviewsState {
  const ReviewsLoading();
}

class ReviewsLoaded extends ReviewsState {
  final List<CustomerReview> reviews;

  const ReviewsLoaded({
    required this.reviews,
  });

  @override
  List<Object> get props => [
        reviews,
      ];
}

class ReviewsError extends ReviewsState {
  final String message;

  const ReviewsError({
    required this.message,
  });

  @override
  List<Object> get props => [
        message,
      ];
}
