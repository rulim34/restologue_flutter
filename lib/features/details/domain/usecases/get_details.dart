import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/domain/entities/resto.dart';
import '../../../../core/error/failures.dart';
import '../repositories/details_repository.dart';

@lazySingleton
class GetDetails {
  final DetailsRepository _repository;

  const GetDetails(
    this._repository,
  );

  Future<Either<Failure, Resto>> call({
    required String id,
  }) async {
    return _repository.getDetails(
      id: id,
    );
  }
}
