import 'package:dartz/dartz.dart';

import '../../../../core/entities/customer_review.dart';
import '../../../../core/entities/resto.dart';
import '../../../../core/error/failures.dart';

abstract class DetailsRepository {
  Future<Either<Failure, Resto>> getDetails({
    required String id,
  });

  Future<Either<Failure, List<CustomerReview>>> postReview({
    required Map<String, dynamic> data,
  });
}
