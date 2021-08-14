import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:injectable/injectable.dart';

import '../../domain/usecases/search_restos.dart';
import 'notifiers.dart';

@injectable
class SearchNotifier extends StateNotifier<SearchState> {
  final SearchRestos _searchRestos;
  String? searchQuery;

  SearchNotifier(
    this._searchRestos,
  ) : super(const SearchInitial(
          message: 'Enter a keyword and start exploring!',
        ));

  void setInitial() {
    searchQuery = '';
    state = const SearchInitial(
      message: 'Enter a keyword and start exploring!',
    );
  }

  Future<void> searchRestos() async {
    if (searchQuery == '') {
      setInitial();
    } else {
      state = const SearchLoading();

      final failureOrRestos = await _searchRestos(
        searchQuery: searchQuery!,
      );

      failureOrRestos.fold(
        (failure) {
          state = const SearchError(
            message: 'Failed to fetch restaurant details.',
          );
        },
        (restos) {
          state = SearchLoaded(
            restos: restos,
          );
        },
      );
    }
  }
}

@injectable
class SearchBarNotifier extends StateNotifier<bool> {
  SearchBarNotifier() : super(false);

  // ignore: avoid_positional_boolean_parameters, use_setters_to_change_properties
  void setState(bool status) {
    state = status;
  }
}
