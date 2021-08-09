import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/resto.dart';
import '../../../../core/error/failures.dart';
import '../repositories/home_repository.dart';

@lazySingleton
class GetRestos {
  final HomeRepository repository;

  GetRestos(this.repository);

  Future<Either<Failure, List<Resto>>> call() async {
    return repository.getRestos();
  }
}
