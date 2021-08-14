import 'dart:convert';

import 'package:restologue/core/error/exceptions.dart';
import 'package:restologue/core/error/failures.dart';
import 'package:restologue/core/data/datasources/home_remote_data_source.dart';
import 'package:restologue/core/data/models/resto_model.dart';
import 'package:restologue/features/home/data/repositories/home_repository_impl.dart';
import 'package:restologue/core/domain/entities/resto.dart';
import 'package:dartz/dartz.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'home_repository_impl_test.mocks.dart';

@GenerateMocks([HomeRemoteDataSource])
void main() {
  late HomeRepositoryImpl repository;
  late MockHomeRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockHomeRemoteDataSource();
    repository = HomeRepositoryImpl(mockRemoteDataSource);
  });

  group('getRestos', () {
    final List<RestoModel> tListRestoModel = List<RestoModel>.from(
        jsonDecode(fixture('list.json'))['restaurants']
            .map((d) => RestoModel.fromJson(d as Map)) as Iterable);
    final List<Resto> tListResto = tListRestoModel;

    test(
      'should return List<Resto> when the call to remote data source is successful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getRestos(),
        ).thenAnswer(
          (_) async => tListRestoModel,
        );
        // act
        final result = await repository.getRestos();
        // assert
        verify(
          mockRemoteDataSource.getRestos(),
        );
        expect(
          result,
          equals(Right(tListResto)),
        );
      },
    );

    test(
      'should return RequestFailure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getRestos(),
        ).thenThrow(
          RequestException(),
        );
        // act
        final result = await repository.getRestos();
        // assert
        verify(
          mockRemoteDataSource.getRestos(),
        );
        expect(
          result,
          equals(Left(RequestFailure())),
        );
      },
    );
  });
}
