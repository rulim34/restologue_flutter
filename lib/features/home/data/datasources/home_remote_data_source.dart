import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/config/config.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/models/resto_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<RestoModel>> getRestos({
    String apiUrl,
    String endPoint,
  });
}

@LazySingleton(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final Dio dio;

  HomeRemoteDataSourceImpl({
    required this.dio,
  });

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
    final Response response = await dio.get('$url');

    if (response.statusCode == 200) {
      return List<RestoModel>.from(response.data['restaurants']
          .map((d) => RestoModel.fromApiJson(d as Map)) as Iterable);
    } else {
      throw RequestException();
    }
  }
}
