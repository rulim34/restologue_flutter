import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/config/config.dart';
import '../../../../core/data/models/customer_review_model.dart';
import '../../../../core/data/models/resto_model.dart';
import '../../../../core/error/exceptions.dart';

abstract class DetailsRemoteDataSource {
  const DetailsRemoteDataSource();

  Future<RestoModel> getDetails({
    String apiUrl,
    String endPoint,
    required String id,
  });

  Future<List<CustomerReviewModel>> postReview({
    String apiUrl,
    String endPoint,
    required Map<String, dynamic> data,
  });
}

@LazySingleton(as: DetailsRemoteDataSource)
class DetailsRemoteDataSourceImpl extends DetailsRemoteDataSource {
  final Dio _dio;

  const DetailsRemoteDataSourceImpl(
    this._dio,
  );

  @override
  Future<RestoModel> getDetails({
    String apiUrl = apiUrl,
    String endPoint = 'detail',
    required String id,
  }) async {
    try {
      final Uri url = Uri(
        scheme: 'https',
        host: apiUrl,
        pathSegments: [endPoint, id],
      );
      final Response response = await _dio.get('$url');

      if (response.statusCode == 200) {
        return RestoModel.fromJson(response.data['restaurant'] as Map);
      } else {
        throw RequestException();
      }
    } catch (error) {
      throw RequestException();
    }
  }

  @override
  Future<List<CustomerReviewModel>> postReview({
    String apiUrl = apiUrl,
    String endPoint = 'review',
    required Map<String, dynamic> data,
  }) async {
    try {
      final Uri url = Uri(
        scheme: 'https',
        host: apiUrl,
        path: endPoint,
      );
      final Response response = await _dio.post('$url',
          options: Options(
            headers: {
              HttpHeaders.contentTypeHeader: 'application/json',
              'X-Auth-Token': 1234
            },
          ),
          data: jsonEncode(data));

      if (response.statusCode == 200) {
        return List<CustomerReviewModel>.from(response.data['customerReviews']
            .map((d) => CustomerReviewModel.fromJson(d as Map)) as Iterable);
      } else {
        throw RequestException();
      }
    } catch (error) {
      throw RequestException();
    }
  }
}
