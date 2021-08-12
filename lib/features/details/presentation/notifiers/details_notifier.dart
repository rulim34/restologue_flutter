import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/get_details.dart';
import 'notifiers.dart';

@injectable
class DetailsNotifier extends StateNotifier<DetailsState> {
  GetDetails getDetails;

  DetailsNotifier({
    required this.getDetails,
  }) : super(const DetailsInitial());

  Future<void> fetchDetails({
    required String id,
  }) async {
    state = const DetailsLoading();

    final failureOrResto = await getDetails(
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
