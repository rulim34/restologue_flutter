import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../repositories/drawer_repository.dart';

@lazySingleton
class SetRecommendationNotificationStatus {
  final DrawerRepository _repository;

  const SetRecommendationNotificationStatus(
    this._repository,
  );

  Future<Either<Failure, void>> call({
    required bool status,
  }) async {
    return _repository.setRecommendationNotificationStatus(
      status: status,
    );
  }
}
