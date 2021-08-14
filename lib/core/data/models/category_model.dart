import '../../domain/entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required String name,
  }) : super(
          name: name,
        );

  factory CategoryModel.fromJson(Map<dynamic, dynamic> json) {
    return CategoryModel(
      name: json['name'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
    };
  }
}
