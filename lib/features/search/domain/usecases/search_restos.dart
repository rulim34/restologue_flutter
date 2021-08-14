import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/domain/entities/resto.dart';
import '../../../../core/error/failures.dart';
import '../repositories/search_repository.dart';

@lazySingleton
class SearchRestos {
  final SearchRepository _repository;

  const SearchRestos(
    this._repository,
  );

  Future<Either<Failure, List<Resto>>> call({
    required String searchQuery,
  }) async {
    return _repository.searchRestos(
      searchQuery: searchQuery,
    );
  }
}
