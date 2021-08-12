import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/resto.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/search_repository.dart';
import '../datasources/search_remote_data_source.dart';

@LazySingleton(as: SearchRepository)
class SearchRepositoryImpl implements SearchRepository {
  final SearchRemoteDataSource remoteDataSource;

  SearchRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, List<Resto>>> searchRestos({
    required String searchQuery,
  }) async {
    try {
      final List<Resto> restos = await remoteDataSource.searchRestos(
        searchQuery: searchQuery,
      );
      return Right(restos);
    } on RequestException {
      return Left(RequestFailure());
    } on DioError {
      return Left(RequestFailure());
    }
  }
}
