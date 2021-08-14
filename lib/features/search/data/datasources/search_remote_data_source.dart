import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/config/config.dart';
import '../../../../core/data/models/resto_model.dart';
import '../../../../core/error/exceptions.dart';

abstract class SearchRemoteDataSource {
  const SearchRemoteDataSource();

  Future<List<RestoModel>> searchRestos({
    String apiUrl,
    String endPoint,
    required String searchQuery,
  });
}

@LazySingleton(as: SearchRemoteDataSource)
class SearchRemoteDataSourceImpl extends SearchRemoteDataSource {
  final Dio _dio;

  const SearchRemoteDataSourceImpl(
    this._dio,
  );

  @override
  Future<List<RestoModel>> searchRestos({
    String apiUrl = apiUrl,
    String endPoint = 'search',
    required String searchQuery,
  }) async {
    final Uri url = Uri(
      scheme: 'https',
      host: apiUrl,
      path: endPoint,
      queryParameters: {
        'q': searchQuery,
      },
    );
    final Response response = await _dio.get('$url');

    if (response.statusCode == 200) {
      return List<RestoModel>.from(response.data['restaurants']
          .map((d) => RestoModel.fromJson(d as Map)) as Iterable);
    } else {
      throw RequestException();
    }
  }
}
