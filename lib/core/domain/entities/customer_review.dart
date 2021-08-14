import 'package:equatable/equatable.dart';

class CustomerReview extends Equatable {
  final String name;
  final String review;
  final String date;

  const CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  @override
  List<Object> get props => [
        name,
        review,
        date,
      ];
}
