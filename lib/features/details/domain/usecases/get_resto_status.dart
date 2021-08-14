import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../repositories/details_repository.dart';

@lazySingleton
class GetRestoStatus {
  final DetailsRepository _repository;

  const GetRestoStatus(
    this._repository,
  );

  Future<Either<Failure, bool>> call({
    required String id,
  }) async {
    return _repository.getRestoStatus(
      id: id,
    );
  }
}
