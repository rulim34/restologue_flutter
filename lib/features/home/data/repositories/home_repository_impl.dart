import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/resto.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_data_source.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Resto>>> getRestos() async {
    try {
      final List<Resto> restos = await remoteDataSource.getRestos();
      return Right(restos);
    } on RequestException {
      return Left(RequestFailure());
    } on DioError {
      return Left(RequestFailure());
    }
  }
}
