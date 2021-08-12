import 'package:dartz/dartz.dart';

import '../../../../core/entities/resto.dart';
import '../../../../core/error/failures.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<Resto>>> searchRestos({
    required String searchQuery,
  });
}
