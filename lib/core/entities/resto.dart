import 'package:equatable/equatable.dart';

import 'category.dart';
import 'customer_review.dart';
import 'menu.dart';

class Resto extends Equatable {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final String address;
  final List<Category> categories;
  final List<Food> foods;
  final List<Drink> drinks;
  final String rating;
  final List<CustomerReview> customerReviews;

  const Resto({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    this.address = '',
    this.categories = const [],
    this.foods = const [],
    this.drinks = const [],
    required this.rating,
    this.customerReviews = const [],
  });

  @override
  List<Object> get props => [
        id,
        name,
        description,
        pictureId,
        city,
        address,
        categories,
        foods,
        drinks,
        rating,
        customerReviews,
      ];
}
