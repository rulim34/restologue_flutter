import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/domain/entities/resto.dart';

@immutable
abstract class FavouritesState extends Equatable {
  const FavouritesState();

  @override
  List<Object> get props => [];
}

class FavouritesInitial extends FavouritesState {
  const FavouritesInitial();
}

class FavouritesLoading extends FavouritesState {
  const FavouritesLoading();
}

class FavouritesLoaded extends FavouritesState {
  final List<Resto> restos;

  const FavouritesLoaded({
    required this.restos,
  });

  @override
  List<Object> get props => [
        restos,
      ];
}

class FavouritesError extends FavouritesState {
  final String message;

  const FavouritesError({
    required this.message,
  });

  @override
  List<Object> get props => [
        message,
      ];
}
