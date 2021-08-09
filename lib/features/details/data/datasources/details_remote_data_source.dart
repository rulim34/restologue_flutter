import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/config/config.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/models/resto_model.dart';

abstract class DetailsRemoteDataSource {
  Future<RestoModel> getDetails({
    String apiUrl,
    String endPoint,
    required String id,
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
      return RestoModel.fromApiJson(response.data['restaurant'] as Map);
    } else {
      throw RequestException();
    }
  }
}
