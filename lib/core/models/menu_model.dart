import '../entities/menu.dart';

class FoodModel extends Food {
  const FoodModel({
    required String name,
  }) : super(
          name: name,
        );

  factory FoodModel.fromJson(Map<dynamic, dynamic> json) {
    return FoodModel(
      name: json['name'].toString(),
    );
  }
}

class DrinkModel extends Drink {
  const DrinkModel({
    required String name,
  }) : super(
          name: name,
        );

  factory DrinkModel.fromJson(Map<dynamic, dynamic> json) {
    return DrinkModel(
      name: json['name'].toString(),
    );
  }
}
