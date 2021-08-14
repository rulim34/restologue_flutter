import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/domain/entities/resto.dart';

@immutable
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoading extends HomeState {
  const HomeLoading();
}

class HomeLoaded extends HomeState {
  final List<Resto> restos;

  const HomeLoaded({
    required this.restos,
  });

  @override
  List<Object> get props => [
        restos,
      ];
}

class HomeError extends HomeState {
  final String message;

  const HomeError({
    required this.message,
  });

  @override
  List<Object> get props => [
        message,
      ];
}
