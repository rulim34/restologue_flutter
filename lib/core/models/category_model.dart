import '../entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required String name,
  }) : super(
          name: name,
        );

  factory CategoryModel.fromApiJson(Map<dynamic, dynamic> json) {
    return CategoryModel(
      name: json['name'].toString(),
    );
  }
}