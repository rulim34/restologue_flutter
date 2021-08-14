import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../repositories/details_repository.dart';

@lazySingleton
class DeleteResto {
  final DetailsRepository _repository;

  const DeleteResto(
    this._repository,
  );

  Future<Either<Failure, void>> call({
    required String id,
  }) async {
    return _repository.deleteResto(
      id: id,
    );
  }
}
