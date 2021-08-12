import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/config/config.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/models/customer_review_model.dart';
import '../../../../core/models/resto_model.dart';

abstract class DetailsRemoteDataSource {
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
  final Dio dio;

  DetailsRemoteDataSourceImpl({
    required this.dio,
  });

  @override
  Future<RestoModel> getDetails({
    String apiUrl = apiUrl,
    String endPoint = 'detail',
    required String id,
  }) async {
    final Uri url = Uri(
      scheme: 'https',
      host: apiUrl,
      pathSegments: [endPoint, id],
    );
    final Response response = await dio.get('$url');

    if (response.statusCode == 200) {
      return RestoModel.fromJson(response.data['restaurant'] as Map);
    } else {
      throw RequestException();
    }
  }

  @override
  Future<List<CustomerReviewModel>> postReview({
    String apiUrl = apiUrl,
    String endPoint = 'review',
    required Map<String, dynamic> data,
  }) async {
    final Uri url = Uri(
      scheme: 'https',
      host: apiUrl,
      path: endPoint,
    );
    final Response response = await dio.post('$url',
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
  }
}
