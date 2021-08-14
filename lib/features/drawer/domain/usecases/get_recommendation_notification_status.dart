import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../repositories/drawer_repository.dart';

@lazySingleton
class GetRecommendationNotificationStatus {
  final DrawerRepository _repository;

  const GetRecommendationNotificationStatus(
    this._repository,
  );

  Future<Either<Failure, bool>> call() async {
    return _repository.getRecommendationNotificationStatus();
  }
}
