import 'package:dartz/dartz.dart';

import '../../../../core/domain/entities/resto.dart';
import '../../../../core/error/failures.dart';

abstract class FavouritesRepository {
  const FavouritesRepository();

  Future<Either<Failure, List<Resto>>> getRestos();
}
