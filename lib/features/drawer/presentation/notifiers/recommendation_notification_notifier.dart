import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/get_recommendation_notification_status.dart';
import '../../domain/usecases/set_recommendation_notification_status.dart';

@injectable
class RecommendationNotificationNotifier extends StateNotifier<bool> {
  final GetRecommendationNotificationStatus
      _getRecommendationNotificationStatus;
  final SetRecommendationNotificationStatus
      _setRecommendationNotificationStatus;

  RecommendationNotificationNotifier(
    this._getRecommendationNotificationStatus,
    this._setRecommendationNotificationStatus,
  ) : super(false);

  Future<void> getRecomendationNotificationStatus() async {
    final failureOrStatus = await _getRecommendationNotificationStatus();

    failureOrStatus.fold(
      (failure) => state = false,
      (status) => state = status,
    );
  }

  // ignore: avoid_positional_boolean_parameters, use_setters_to_change_properties
  Future<void> setRecomendationNotificationStatus({
    required bool status,
  }) async {
    final failureOrSuccess = await _setRecommendationNotificationStatus(
      status: status,
    );

    failureOrSuccess.fold(
      (failure) => state = false,
      (success) => state = status,
    );
  }
}
