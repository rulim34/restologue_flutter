import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/data/datasources/home_remote_data_source.dart';
import '../../../../core/domain/entities/resto.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/home_repository.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource _remoteDataSource;

  const HomeRepositoryImpl(
    this._remoteDataSource,
  );

  @override
  Future<Either<Failure, List<Resto>>> getRestos() async {
    try {
      final List<Resto> restos = await _remoteDataSource.getRestos();
      return Right(restos);
    } on RequestException {
      return Left(RequestFailure());
    } on DioError {
      return Left(RequestFailure());
    }
  }
}
