// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'features/details/data/datasources/details_remote_data_source.dart'
    as _i13;
import 'features/details/data/repositories/details_repository_impl.dart'
    as _i15;
import 'features/details/domain/repositories/details_repository.dart' as _i14;
import 'features/details/domain/usecases/get_details.dart' as _i16;
import 'features/details/domain/usecases/post_review.dart' as _i19;
import 'features/details/presentation/notifiers/details_notifier.dart' as _i21;
import 'features/details/presentation/notifiers/reviews_notifier.dart' as _i20;
import 'features/home/data/datasources/home_remote_data_source.dart' as _i4;
import 'features/home/data/repositories/home_repository_impl.dart' as _i6;
import 'features/home/domain/repositories/home_repository.dart' as _i5;
import 'features/home/domain/usecases/get_restos.dart' as _i17;
import 'features/home/presentation/notifiers/home_notifier.dart' as _i18;
import 'features/navbar/presentation/notifiers/navbar_notifier.dart' as _i7;
import 'features/search/data/datasources/search_remote_data_source.dart' as _i9;
import 'features/search/data/repositories/search_repository_impl.dart' as _i11;
import 'features/search/domain/repositories/search_repository.dart' as _i10;
import 'features/search/domain/usecases/search_restos.dart' as _i12;
import 'features/search/presentation/notifiers/search_notifier.dart' as _i8;
import 'injection.dart' as _i22; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i7.NavBarNotifier>(() => _i7.NavBarNotifier());
  gh.factory<_i8.SearchBarNotifier>(() => _i8.SearchBarNotifier());
  gh.lazySingleton<_i9.SearchRemoteDataSource>(
      () => _i9.SearchRemoteDataSourceImpl(dio: get<_i3.Dio>()));
  gh.lazySingleton<_i10.SearchRepository>(() => _i11.SearchRepositoryImpl(
      remoteDataSource: get<_i9.SearchRemoteDataSource>()));
  gh.lazySingleton<_i12.SearchRestos>(
      () => _i12.SearchRestos(get<_i10.SearchRepository>()));
  gh.lazySingleton<_i13.DetailsRemoteDataSource>(
      () => _i13.DetailsRemoteDataSourceImpl(dio: get<_i3.Dio>()));
  gh.lazySingleton<_i14.DetailsRepository>(() => _i15.DetailsRepositoryImpl(
      remoteDataSource: get<_i13.DetailsRemoteDataSource>()));
  gh.lazySingleton<_i16.GetDetails>(
      () => _i16.GetDetails(get<_i14.DetailsRepository>()));
  gh.lazySingleton<_i17.GetRestos>(
      () => _i17.GetRestos(get<_i5.HomeRepository>()));
  gh.factory<_i18.HomeNotifier>(
      () => _i18.HomeNotifier(getRestos: get<_i17.GetRestos>()));
  gh.lazySingleton<_i19.PostReview>(
      () => _i19.PostReview(get<_i14.DetailsRepository>()));
  gh.factory<_i20.ReviewsNotifier>(
      () => _i20.ReviewsNotifier(postReview: get<_i19.PostReview>()));
  gh.factory<_i8.SearchNotifier>(
      () => _i8.SearchNotifier(searchRestos: get<_i12.SearchRestos>()));
  gh.factory<_i21.DetailsNotifier>(
      () => _i21.DetailsNotifier(getDetails: get<_i16.GetDetails>()));
  return get;
}

class _$RegisterModule extends _i22.RegisterModule {}
