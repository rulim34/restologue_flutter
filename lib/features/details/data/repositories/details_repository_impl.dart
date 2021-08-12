import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/entities/customer_review.dart';
import '../../../../core/entities/resto.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failures.dart';
import '../../domain/repositories/details_repository.dart';
import '../datasources/details_remote_data_source.dart';

@LazySingleton(as: DetailsRepository)
class DetailsRepositoryImpl implements DetailsRepository {
  final DetailsRemoteDataSource remoteDataSource;

  DetailsRepositoryImpl({
    required this.remoteDataSource,
  });

  @override
  Future<Either<Failure, Resto>> getDetails({
    required String id,
  }) async {
    try {
      final Resto resto = await remoteDataSource.getDetails(
        id: id,
      );
      return Right(resto);
    } on RequestException {
      return Left(RequestFailure());
    } on DioError {
      return Left(RequestFailure());
    }
  }

  @override
  Future<Either<Failure, List<CustomerReview>>> postReview({
    required Map<String, dynamic> data,
  }) async {
    try {
      final List<CustomerReview> reviews = await remoteDataSource.postReview(
        data: data,
      );
      return Right(reviews);
    } on RequestException {
      return Left(RequestFailure());
    } on DioError {
      return Left(RequestFailure());
    }
  }
}
