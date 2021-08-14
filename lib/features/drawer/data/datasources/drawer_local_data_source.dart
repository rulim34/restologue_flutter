import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/exceptions.dart';

abstract class DrawerLocalDataSource {
  const DrawerLocalDataSource();

  Future<bool> getRecommendationNotificationStatus();

  Future<void> setRecommendationNotificationStatus({
    required bool status,
  });
}

@LazySingleton(as: DrawerLocalDataSource)
class DrawerLocalDataSourceImpl implements DrawerLocalDataSource {
  final Box _box;

  DrawerLocalDataSourceImpl(
    this._box,
  );

  @override
  Future<bool> getRecommendationNotificationStatus() async {
    try {
      final bool? status = _box.get('recommendation_notification') as bool?;

      return status ?? false;
    } catch (error) {
      throw ConfigurationException();
    }
  }

  @override
  Future<void> setRecommendationNotificationStatus({
    required bool status,
  }) async {
    try {
      return _box.put('recommendation_notification', status);
    } catch (error) {
      throw ConfigurationException();
    }
  }
}
