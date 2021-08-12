import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/customer_review.dart';
import '../../../../core/error/failures.dart';
import '../repositories/details_repository.dart';

@lazySingleton
class PostReview {
  final DetailsRepository repository;

  PostReview(this.repository);

  Future<Either<Failure, List<CustomerReview>>> call({
    required Map<String, dynamic> data,
  }) async {
    return repository.postReview(
      data: data,
    );
  }
}
