import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'features/details/presentation/notifiers/notifiers.dart';
import 'features/drawer/presentation/notifiers/notifiers.dart';
import 'features/favourites/presentation/notifiers/notifiers.dart';
import 'features/home/presentation/notifiers/notifiers.dart';
import 'features/navbar/presentation/notifiers/notifiers.dart';
import 'features/search/presentation/notifiers/notifiers.dart';
import 'injection.dart';

final navBarProvider = StateNotifierProvider.autoDispose<NavBarNotifier, int>(
  (ref) => getIt<NavBarNotifier>(),
);

final homeProvider = StateNotifierProvider.autoDispose<HomeNotifier, HomeState>(
  (ref) => getIt<HomeNotifier>(),
);

final detailsProvider =
    StateNotifierProvider.autoDispose<DetailsNotifier, DetailsState>(
  (ref) => getIt<DetailsNotifier>(),
);

final reviewsProvider =
    StateNotifierProvider.autoDispose<ReviewsNotifier, ReviewsState>(
  (ref) => getIt<ReviewsNotifier>(),
);

final bookmarkProvider =
    StateNotifierProvider.autoDispose<BookmarkNotifier, bool>(
  (ref) => getIt<BookmarkNotifier>(),
);

final searchProvider =
    StateNotifierProvider.autoDispose<SearchNotifier, SearchState>(
  (ref) => getIt<SearchNotifier>(),
);

final searchBarProvider =
    StateNotifierProvider.autoDispose<SearchBarNotifier, bool>(
  (ref) => getIt<SearchBarNotifier>(),
);

final favouritesProvider =
    StateNotifierProvider.autoDispose<FavouritesNotifier, FavouritesState>(
  (ref) => getIt<FavouritesNotifier>(),
);

final recommendationNotificationProvider =
    StateNotifierProvider<RecommendationNotificationNotifier, bool>(
  (ref) => getIt<RecommendationNotificationNotifier>(),
);
