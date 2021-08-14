import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/data/datasources/favourites_local_data_source.dart';
import '../../../../core/domain/entities/customer_review.dart';
import '../../../../core/domain/entities/resto.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/details_repository.dart';
import '../datasources/details_remote_data_source.dart';

@LazySingleton(as: DetailsRepository)
class DetailsRepositoryImpl implements DetailsRepository {
  final DetailsRemoteDataSource _remoteDataSource;
  final FavouritesLocalDataSource _localDataSource;

  const DetailsRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
  );

  @override
  Future<Either<Failure, Resto>> getDetails({
    required String id,
  }) async {
    try {
      final Resto resto = await _remoteDataSource.getDetails(
        id: id,
      );
      return Right(resto);
    } on RequestException {
      return Left(RequestFailure());
    }
  }

  @override
  Future<Either<Failure, List<CustomerReview>>> postReview({
    required Map<String, dynamic> data,
  }) async {
    try {
      final List<CustomerReview> reviews = await _remoteDataSource.postReview(
        data: data,
      );
      return Right(reviews);
    } on RequestException {
      return Left(RequestFailure());
    }
  }

  @override
  Future<Either<Failure, void>> createResto({
    required Resto resto,
  }) async {
    try {
      return Right(
        await _localDataSource.createResto(
          resto: resto,
        ),
      );
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteResto({
    required String id,
  }) async {
    try {
      return Right(
        await _localDataSource.deleteResto(
          id: id,
        ),
      );
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> getRestoStatus({
    required String id,
  }) async {
    try {
      return Right(
        await _localDataSource.getRestoStatus(
          id: id,
        ),
      );
    } on DatabaseException {
      return Left(DatabaseFailure());
    }
  }
}
