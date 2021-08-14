import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../core/domain/entities/resto.dart';

@immutable
abstract class DetailsState extends Equatable {
  const DetailsState();

  @override
  List<Object> get props => [];
}

class DetailsInitial extends DetailsState {
  const DetailsInitial();
}

class DetailsLoading extends DetailsState {
  const DetailsLoading();
}

class DetailsLoaded extends DetailsState {
  final Resto resto;

  const DetailsLoaded({
    required this.resto,
  });

  @override
  List<Object> get props => [
        resto,
      ];
}

class DetailsError extends DetailsState {
  final String message;

  const DetailsError({
    required this.message,
  });

  @override
  List<Object> get props => [
        message,
      ];
}
