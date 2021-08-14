import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';

abstract class DrawerRepository {
  const DrawerRepository();

  Future<Either<Failure, bool>> getRecommendationNotificationStatus();

  Future<Either<Failure, void>> setRecommendationNotificationStatus({
    required bool status,
  });
}
