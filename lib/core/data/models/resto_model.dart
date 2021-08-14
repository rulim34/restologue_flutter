import '../../domain/entities/category.dart';
import '../../domain/entities/customer_review.dart';
import '../../domain/entities/menus.dart';
import '../../domain/entities/resto.dart';
import 'category_model.dart';
import 'customer_review_model.dart';
import 'menus_model.dart';

class RestoModel extends Resto {
  const RestoModel({
    required String id,
    required String name,
    required String description,
    required String pictureId,
    required String city,
    String address = '',
    List<Category> categories = const [],
    Menus menus = const Menus(),
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
          menus: menus,
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
      menus: json.containsKey('menus')
          ? MenusModel.fromJson(json['menus'] as Map)
          : const Menus(),
      rating: json['rating'].toString(),
      customerReviews: json.containsKey('customerReviews')
          ? List.from(json['customerReviews']
              .map((d) => CustomerReviewModel.fromJson(d as Map)) as Iterable)
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'city': city,
      'address': address,
      'pictureId': pictureId,
      'categories': List.from(
        categories.map((d) => CategoryModel(name: d.name).toJson()),
      ),
      'menus': MenusModel(drinks: menus.drinks).toJson(),
      'rating': rating,
      'customerReviews': List<dynamic>.from(
        customerReviews.map((d) => CustomerReviewModel(
              name: d.name,
              review: d.review,
              date: d.date,
            ).toJson()),
      ),
    };
  }
}
