// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'features/details/data/datasources/details_remote_data_source.dart'
    as _i7;
import 'features/details/data/repositories/details_repository_impl.dart' as _i9;
import 'features/details/domain/repositories/details_repository.dart' as _i8;
import 'features/details/domain/usecases/get_details.dart' as _i10;
import 'features/details/presentation/notifier/details_notifier.dart' as _i13;
import 'features/home/data/datasources/home_remote_data_source.dart' as _i4;
import 'features/home/data/repositories/home_repository_impl.dart' as _i6;
import 'features/home/domain/repositories/home_repository.dart' as _i5;
import 'features/home/domain/usecases/get_restos.dart' as _i11;
import 'features/home/presentation/notifier/home_notifier.dart' as _i12;
import 'injection.dart' as _i14; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.Dio>(() => registerModule.dio);
  gh.lazySingleton<_i4.HomeRemoteDataSource>(
      () => _i4.HomeRemoteDataSourceImpl(dio: get<_i3.Dio>()));
  gh.lazySingleton<_i5.HomeRepository>(() => _i6.HomeRepositoryImpl(
      remoteDataSource: get<_i4.HomeRemoteDataSource>()));
  gh.lazySingleton<_i7.DetailsRemoteDataSource>(
      () => _i7.DetailsRemoteDataSourceImpl(dio: get<_i3.Dio>()));
  gh.lazySingleton<_i8.DetailsRepository>(() => _i9.DetailsRepositoryImpl(
      remoteDataSource: get<_i7.DetailsRemoteDataSource>()));
  gh.lazySingleton<_i10.GetDetails>(
      () => _i10.GetDetails(get<_i8.DetailsRepository>()));
  gh.lazySingleton<_i11.GetRestos>(
      () => _i11.GetRestos(get<_i5.HomeRepository>()));
  gh.factory<_i12.HomeNotifier>(
      () => _i12.HomeNotifier(getRestos: get<_i11.GetRestos>()));
  gh.factory<_i13.DetailsNotifier>(
      () => _i13.DetailsNotifier(getDetails: get<_i10.GetDetails>()));
  return get;
}

class _$RegisterModule extends _i14.RegisterModule {}
