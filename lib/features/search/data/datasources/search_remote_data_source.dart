import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/config/config.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/models/resto_model.dart';

abstract class SearchRemoteDataSource {
  Future<List<RestoModel>> searchRestos({
    String apiUrl,
    String endPoint,
    required String searchQuery,
  });
}

@LazySingleton(as: SearchRemoteDataSource)
class SearchRemoteDataSourceImpl extends SearchRemoteDataSource {
  final Dio dio;

  SearchRemoteDataSourceImpl({
    required this.dio,
  });

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
    final Response response = await dio.get('$url');

    if (response.statusCode == 200) {
      return List<RestoModel>.from(response.data['restaurants']
          .map((d) => RestoModel.fromJson(d as Map)) as Iterable);
    } else {
      throw RequestException();
    }
  }
}
