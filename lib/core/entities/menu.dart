import 'package:equatable/equatable.dart';

abstract class Menu extends Equatable {
  const Menu();

  @override
  List<Object> get props => [];
}

class Food extends Menu {
  final String name;

  const Food({
    required this.name,
  });

  @override
  List<Object> get props => [
        name,
      ];
}

class Drink extends Menu {
  final String name;

  const Drink({
    required this.name,
  });

  @override
  List<Object> get props => [
        name,
      ];
}
