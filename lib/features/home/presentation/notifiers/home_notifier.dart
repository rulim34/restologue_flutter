import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/get_restos.dart';
import 'notifiers.dart';

@injectable
class HomeNotifier extends StateNotifier<HomeState> {
  GetRestos getRestos;

  HomeNotifier({
    required this.getRestos,
  }) : super(const HomeInitial());

  Future<void> fetchRestos() async {
    state = const HomeLoading();

    final failureOrRestos = await getRestos();

    failureOrRestos.fold(
      (failure) {
        state = const HomeError(
          message: 'Failed to fetch restaurant data.',
        );
      },
      (restos) {
        state = HomeLoaded(
          restos: restos,
        );
      },
    );
  }
}
