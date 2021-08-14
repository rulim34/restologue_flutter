import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/resto.dart';
import '../../../../core/error/failures.dart';

abstract class SearchRepository {
  const SearchRepository();

  Future<Either<Failure, List<Resto>>> searchRestos({
    required String searchQuery,
  });
}
