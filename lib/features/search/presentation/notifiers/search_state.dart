import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/entities/resto.dart';

@immutable
abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {
  final String message;

  const SearchInitial({
    required this.message,
  });

  @override
  List<Object> get props => [
        message,
      ];
}

class SearchLoading extends SearchState {
  const SearchLoading();
}

class SearchLoaded extends SearchState {
  final List<Resto> restos;

  const SearchLoaded({
    required this.restos,
  });

  @override
  List<Object> get props => [
        restos,
      ];
}

class SearchError extends SearchState {
  final String message;

  const SearchError({
    required this.message,
  });

  @override
  List<Object> get props => [
        message,
      ];
}
