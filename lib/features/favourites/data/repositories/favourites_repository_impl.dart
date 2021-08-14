import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/data/datasources/favourites_local_data_source.dart';
import '../../../../core/domain/entities/resto.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/favourites_repository.dart';

@LazySingleton(as: FavouritesRepository)
class FavouritesRepositoryImpl extends FavouritesRepository {
  final FavouritesLocalDataSource _localDataSource;

  const FavouritesRepositoryImpl(
    this._localDataSource,
  );

  @override
  Future<Either<Failure, List<Resto>>> getRestos() async {
    try {
      final List<Resto> restos = await _localDataSource.getRestos();
      return Right(restos);
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }
}
