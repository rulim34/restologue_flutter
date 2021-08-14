import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/domain/entities/customer_review.dart';
import '../../../../core/error/failures.dart';
import '../repositories/details_repository.dart';

@lazySingleton
class PostReview {
  final DetailsRepository _repository;

  const PostReview(
    this._repository,
  );

  Future<Either<Failure, List<CustomerReview>>> call({
    required Map<String, dynamic> data,
  }) async {
    return _repository.postReview(
      data: data,
    );
  }
}
