import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'injection.config.dart';

final getIt = GetIt.instance;

@injectableInit
void configureDependencies() {
  $initGetIt(getIt);
}

@module
abstract class RegisterModule {
  @lazySingleton
  Dio get dio => Dio();
}
