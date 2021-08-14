import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/customer_review.dart';
import '../../../../core/domain/entities/resto.dart';
import '../../../../core/error/failures.dart';

abstract class DetailsRepository {
  const DetailsRepository();

  Future<Either<Failure, Resto>> getDetails({
    required String id,
  });

  Future<Either<Failure, List<CustomerReview>>> postReview({
    required Map<String, dynamic> data,
  });

  Future<Either<Failure, void>> createResto({
    required Resto resto,
  });
  Future<Either<Failure, void>> deleteResto({
    required String id,
  });
  Future<Either<Failure, bool>> getRestoStatus({
    required String id,
  });
}
