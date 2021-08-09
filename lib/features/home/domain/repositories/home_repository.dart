import 'package:dartz/dartz.dart';

import '../../../../core/entities/resto.dart';
import '../../../../core/error/failures.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<Resto>>> getRestos();
}
