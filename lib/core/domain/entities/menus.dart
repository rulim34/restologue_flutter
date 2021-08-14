import 'package:equatable/equatable.dart';

class Menus extends Equatable {
  final List<Food> foods;
  final List<Drink> drinks;

  const Menus({
    this.foods = const [],
    this.drinks = const [],
  });

  @override
  List<Object> get props => [];
}

class Food extends Equatable {
  final String name;

  const Food({
    required this.name,
  });

  @override
  List<Object> get props => [
        name,
      ];
}

class Drink extends Equatable {
  final String name;

  const Drink({
    required this.name,
  });

  @override
  List<Object> get props => [
        name,
      ];
}
