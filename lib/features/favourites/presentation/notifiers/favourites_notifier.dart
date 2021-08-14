import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/get_restos.dart';
import 'notifiers.dart';

@injectable
class FavouritesNotifier extends StateNotifier<FavouritesState> {
  final GetRestos _getRestos;

  FavouritesNotifier(
    this._getRestos,
  ) : super(const FavouritesInitial());

  Future<void> getRestos() async {
    if (mounted) {
      state = const FavouritesLoading();
    }

    final failureOrRestos = await _getRestos();

    failureOrRestos.fold(
      (failure) {
        if (mounted) {
          state = const FavouritesError(
            message: 'Failed to obtain favourite restaurant data.',
          );
        }
      },
      (restos) {
        if (mounted) {
          state = FavouritesLoaded(
            restos: restos,
          );
        }
      },
    );
  }
}
