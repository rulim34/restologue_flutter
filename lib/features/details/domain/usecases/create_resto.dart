import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/domain/entities/resto.dart';
import '../../../../core/error/failures.dart';
import '../repositories/details_repository.dart';

@lazySingleton
class CreateResto {
  final DetailsRepository _repository;

  const CreateResto(
    this._repository,
  );

  Future<Either<Failure, void>> call({
    required Resto resto,
  }) async {
    return _repository.createResto(
      resto: resto,
    );
  }
}
