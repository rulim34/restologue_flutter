import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/details/presentation/notifier/notifier.dart';
import 'features/home/presentation/notifier/notifier.dart';
import 'injection.dart';

final homeProvider = StateNotifierProvider.autoDispose<HomeNotifier, HomeState>(
  (ref) => getIt<HomeNotifier>(),
);

final detailsProvider =
    StateNotifierProvider.autoDispose<DetailsNotifier, DetailsState>(
  (ref) => getIt<DetailsNotifier>(),
);
