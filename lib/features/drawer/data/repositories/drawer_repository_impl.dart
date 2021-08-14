import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/utils/background_service.dart';
import '../../../../core/utils/date_time_helper.dart';
import '../../domain/repositories/drawer_repository.dart';
import '../datasources/drawer_local_data_source.dart';

@LazySingleton(as: DrawerRepository)
class DrawerRepositoryImpl extends DrawerRepository {
  final DrawerLocalDataSource _localDataSource;

  const DrawerRepositoryImpl(
    this._localDataSource,
  );

  @override
  Future<Either<Failure, bool>> getRecommendationNotificationStatus() async {
    try {
      return Right(
        await _localDataSource.getRecommendationNotificationStatus(),
      );
    } on ConfigurationException {
      return Left(ConfigurationFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setRecommendationNotificationStatus({
    required bool status,
  }) async {
    try {
      if (status) {
        await AndroidAlarmManager.periodic(
          const Duration(hours: 24),
          1,
          BackgroundService.callback,
          startAt: DateTimeHelper.format(),
          exact: true,
          wakeup: true,
          rescheduleOnReboot: true,
        );
      } else {
        await AndroidAlarmManager.cancel(1);
      }

      return Right(
        await _localDataSource.setRecommendationNotificationStatus(
          status: status,
        ),
      );
    } on ConfigurationException {
      return Left(ConfigurationFailure());
    }
  }
}
