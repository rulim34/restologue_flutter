import '../../domain/entities/menus.dart';

class MenusModel extends Menus {
  const MenusModel({
    List<Food> foods = const [],
    List<Drink> drinks = const [],
  }) : super(
          foods: foods,
          drinks: drinks,
        );

  factory MenusModel.fromJson(Map<dynamic, dynamic> json) {
    return MenusModel(
      foods: json.containsKey('foods')
          ? List.from(json['foods'].map((d) => FoodModel.fromJson(d as Map))
              as Iterable)
          : [],
      drinks: json.containsKey('drinks')
          ? List.from(json['drinks'].map((d) => DrinkModel.fromJson(d as Map))
              as Iterable)
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'foods': List.from(
        foods.map((d) => FoodModel(name: d.name).toJson()),
      ),
      'drinks': List.from(
        drinks.map((d) => DrinkModel(name: d.name).toJson()),
      ),
    };
  }
}

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

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
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

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
