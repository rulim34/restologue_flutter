import '../entities/category.dart';
import '../entities/customer_review.dart';
import '../entities/menu.dart';
import '../entities/resto.dart';
import 'category_model.dart';
import 'customer_review_model.dart';
import 'menu_model.dart';

class RestoModel extends Resto {
  const RestoModel({
    required String id,
    required String name,
    required String description,
    required String pictureId,
    required String city,
    String address = '',
    List<Category> categories = const [],
    List<Food> foods = const [],
    List<Drink> drinks = const [],
    required String rating,
    List<CustomerReview> customerReviews = const [],
  }) : super(
          id: id,
          name: name,
          description: description,
          pictureId: pictureId,
          city: city,
          address: address,
          categories: categories,
          foods: foods,
          drinks: drinks,
          rating: rating,
          customerReviews: customerReviews,
        );

  factory RestoModel.fromJson(Map<dynamic, dynamic> json) {
    return RestoModel(
      id: json['id'].toString(),
      name: json['name'].toString(),
      description: json['description'].toString(),
      pictureId: json['pictureId'].toString(),
      city: json['city'].toString(),
      address: json['address']?.toString() ?? '',
      categories: json.containsKey('categories')
          ? List.from(json['categories']
              .map((d) => CategoryModel.fromJson(d as Map)) as Iterable)
          : [],
      foods: json.containsKey('menus')
          ? List.from(json['menus']['foods']
              .map((d) => FoodModel.fromJson(d as Map)) as Iterable)
          : [],
      drinks: json.containsKey('menus')
          ? List.from(json['menus']['drinks']
              .map((d) => DrinkModel.fromJson(d as Map)) as Iterable)
          : [],
      rating: json['rating'].toString(),
      customerReviews: json.containsKey('customerReviews')
          ? List.from(json['customerReviews']
              .map((d) => CustomerReviewModel.fromJson(d as Map)) as Iterable)
          : [],
    );
  }
}
