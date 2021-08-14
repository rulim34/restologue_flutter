import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../config/config.dart';
import '../../error/exceptions.dart';
import '../models/resto_model.dart';

abstract class HomeRemoteDataSource {
  const HomeRemoteDataSource();

  Future<List<RestoModel>> getRestos({
    String apiUrl,
    String endPoint,
  });
}

@LazySingleton(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final Dio _dio;

  const HomeRemoteDataSourceImpl(
    this._dio,
  );

  @override
  Future<List<RestoModel>> getRestos({
    String apiUrl = apiUrl,
    String endPoint = 'list',
  }) async {
    final Uri url = Uri(
      scheme: 'https',
      host: apiUrl,
      path: endPoint,
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
