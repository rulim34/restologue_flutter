import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/resto.dart';
import '../../../../core/error/failures.dart';
import '../repositories/details_repository.dart';

@lazySingleton
class GetDetails {
  final DetailsRepository repository;

  GetDetails(this.repository);

  Future<Either<Failure, Resto>> call({
    required String id,
  }) async {
    return repository.getDetails(
      id: id,
    );
  }
}
