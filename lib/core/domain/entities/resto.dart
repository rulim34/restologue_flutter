import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import 'category.dart';
import 'customer_review.dart';
import 'menus.dart';

part 'resto.g.dart';

@HiveType(typeId: 1)
class Resto extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String pictureId;
  @HiveField(4)
  final String city;
  final String address;
  final List<Category> categories;
  final Menus menus;
  @HiveField(5)
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
    this.menus = const Menus(),
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
        menus,
        rating,
        customerReviews,
      ];
}
