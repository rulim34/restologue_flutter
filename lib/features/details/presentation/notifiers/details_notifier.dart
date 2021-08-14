import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/get_details.dart';
import 'notifiers.dart';

@injectable
class DetailsNotifier extends StateNotifier<DetailsState> {
  final GetDetails _getDetails;

  DetailsNotifier(
    this._getDetails,
  ) : super(const DetailsInitial());

  Future<void> getDetails({
    required String id,
  }) async {
    state = const DetailsLoading();

    final failureOrResto = await _getDetails(
      id: id,
    );

    failureOrResto.fold(
      (failure) {
        state = const DetailsError(
          message: 'Failed to fetch restaurant details.',
        );
      },
      (resto) {
        state = DetailsLoaded(
          resto: resto,
        );
      },
    );
  }
}
