import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restologue/core/config/config.dart';
import 'package:restologue/core/data/models/resto_model.dart';
import 'package:restologue/core/error/exceptions.dart';
import 'package:restologue/core/data/datasources/home_remote_data_source.dart';

import '../../../../fixtures/fixture_reader.dart';
import 'home_remote_data_source_test.mocks.dart';

@GenerateMocks([Dio])
void main() {
  late HomeRemoteDataSourceImpl dataSource;
  late MockDio mockDio;

  setUp(() {
    mockDio = MockDio();
    dataSource = HomeRemoteDataSourceImpl(
      mockDio,
    );
  });

  void setUpMockDioSuccess200() {
    when(
      mockDio.get(any),
    ).thenAnswer(
      (_) async => Response(
        data: jsonDecode(fixture('list.json')),
        statusCode: 200,
        requestOptions: RequestOptions(
          path: 'list',
        ),
      ),
    );
  }

  void setUpMockDioFailure404() {
    when(
      mockDio.get(any),
    ).thenAnswer(
      (_) async => Response(
        data: 'Something went wrong',
        statusCode: 404,
        requestOptions: RequestOptions(
          path: 'list',
        ),
      ),
    );
  }

  group('getRestos', () {
    final tListRestoModel = List<RestoModel>.from(
        jsonDecode(fixture('list.json'))['restaurants']
            .map((d) => RestoModel.fromJson(d as Map)) as Iterable);

    test(
      '''should perform a GET request on a URL''',
      () async {
        // arrange
        setUpMockDioSuccess200();
        // act
        dataSource.getRestos();
        // assert
        verify(
          mockDio.get(
            Uri(
              scheme: 'https',
              host: apiUrl,
              path: 'list',
            ).toString(),
          ),
        );
      },
    );

    test(
      'should return List<RestoModel> when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockDioSuccess200();
        // act
        final result = await dataSource.getRestos();
        // assert
        expect(
          result,
          equals(tListRestoModel),
        );
      },
    );

    test(
      'should throw a RequestException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockDioFailure404();
        // act
        final call = dataSource.getRestos;
        // assert
        expect(
          () => call(),
          throwsA(const TypeMatcher<RequestException>()),
        );
      },
    );
  });
}
