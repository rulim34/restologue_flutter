import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/resto.dart';
import '../../../../core/error/failures.dart';
import '../repositories/search_repository.dart';

@lazySingleton
class SearchRestos {
  final SearchRepository repository;

  SearchRestos(this.repository);

  Future<Either<Failure, List<Resto>>> call({
    required String searchQuery,
  }) async {
    return repository.searchRestos(
      searchQuery: searchQuery,
    );
  }
}
