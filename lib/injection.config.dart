// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:dio/dio.dart' as _i3;
import 'package:flutter/material.dart' as _i42;
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as _i41;
import 'package:get_it/get_it.dart' as _i1;
import 'package:hive/hive.dart' as _i5;
import 'package:injectable/injectable.dart' as _i2;

import 'core/data/datasources/favourites_local_data_source.dart' as _i8;
import 'core/data/datasources/home_remote_data_source.dart' as _i14;
import 'core/domain/entities/resto.dart' as _i9;
import 'core/utils/background_service.dart' as _i39;
import 'core/utils/date_time_helper.dart' as _i40;
import 'core/utils/notification_helper.dart' as _i43;
import 'features/details/data/datasources/details_remote_data_source.dart'
    as _i24;
import 'features/details/data/repositories/details_repository_impl.dart'
    as _i26;
import 'features/details/domain/repositories/details_repository.dart' as _i25;
import 'features/details/domain/usecases/create_resto.dart' as _i35;
import 'features/details/domain/usecases/delete_resto.dart' as _i36;
import 'features/details/domain/usecases/get_details.dart' as _i28;
import 'features/details/domain/usecases/get_resto_status.dart' as _i29;
import 'features/details/domain/usecases/post_review.dart' as _i32;
import 'features/details/presentation/notifiers/bookmark_notifier.dart' as _i38;
import 'features/details/presentation/notifiers/details_notifier.dart' as _i37;
import 'features/details/presentation/notifiers/reviews_notifier.dart' as _i34;
import 'features/drawer/data/datasources/drawer_local_data_source.dart' as _i4;
import 'features/drawer/data/repositories/drawer_repository_impl.dart' as _i7;
import 'features/drawer/domain/repositories/drawer_repository.dart' as _i6;
import 'features/drawer/domain/usecases/get_recommendation_notification_status.dart'
    as _i12;
import 'features/drawer/domain/usecases/set_recommendation_notification_status.dart'
    as _i23;
import 'features/drawer/presentation/notifiers/recommendation_notification_notifier.dart'
    as _i33;
import 'features/favourites/data/repositories/favourites_repository_impl.dart'
    as _i11;
import 'features/favourites/domain/repositories/favourites_repository.dart'
    as _i10;
import 'features/favourites/domain/usecases/get_restos.dart' as _i13;
import 'features/favourites/presentation/notifiers/favourites_notifier.dart'
    as _i27;
import 'features/home/data/repositories/home_repository_impl.dart' as _i16;
import 'features/home/domain/repositories/home_repository.dart' as _i15;
import 'features/home/domain/usecases/get_restos.dart' as _i30;
import 'features/home/presentation/notifiers/home_notifier.dart' as _i31;
import 'features/navbar/presentation/notifiers/navbar_notifier.dart' as _i17;
import 'features/search/data/datasources/search_remote_data_source.dart'
    as _i19;
import 'features/search/data/repositories/search_repository_impl.dart' as _i21;
import 'features/search/domain/repositories/search_repository.dart' as _i20;
import 'features/search/domain/usecases/search_restos.dart' as _i22;
import 'features/search/presentation/notifiers/search_notifier.dart' as _i18;
import 'injection.dart' as _i44; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) async {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.lazySingleton<_i3.Dio>(() => registerModule.dio);
  gh.lazySingleton<_i4.DrawerLocalDataSource>(
      () => _i4.DrawerLocalDataSourceImpl(get<_i5.Box<dynamic>>()));
  gh.lazySingleton<_i6.DrawerRepository>(
      () => _i7.DrawerRepositoryImpl(get<_i4.DrawerLocalDataSource>()));
  gh.lazySingleton<_i8.FavouritesLocalDataSource>(
      () => _i8.FavouritesLocalDataSourceImpl(get<_i5.Box<_i9.Resto>>()));
  gh.lazySingleton<_i10.FavouritesRepository>(() =>
      _i11.FavouritesRepositoryImpl(get<_i8.FavouritesLocalDataSource>()));
  gh.lazySingleton<_i12.GetRecommendationNotificationStatus>(() =>
      _i12.GetRecommendationNotificationStatus(get<_i6.DrawerRepository>()));
  gh.lazySingleton<_i13.GetRestos>(
      () => _i13.GetRestos(get<_i10.FavouritesRepository>()));
  gh.lazySingleton<_i14.HomeRemoteDataSource>(
      () => _i14.HomeRemoteDataSourceImpl(get<_i3.Dio>()));
  gh.lazySingleton<_i15.HomeRepository>(
      () => _i16.HomeRepositoryImpl(get<_i14.HomeRemoteDataSource>()));
  gh.factory<_i17.NavBarNotifier>(() => _i17.NavBarNotifier());
  gh.factory<_i18.SearchBarNotifier>(() => _i18.SearchBarNotifier());
  gh.lazySingleton<_i19.SearchRemoteDataSource>(
      () => _i19.SearchRemoteDataSourceImpl(get<_i3.Dio>()));
  gh.lazySingleton<_i20.SearchRepository>(
      () => _i21.SearchRepositoryImpl(get<_i19.SearchRemoteDataSource>()));
  gh.lazySingleton<_i22.SearchRestos>(
      () => _i22.SearchRestos(get<_i20.SearchRepository>()));
  gh.lazySingleton<_i23.SetRecommendationNotificationStatus>(() =>
      _i23.SetRecommendationNotificationStatus(get<_i6.DrawerRepository>()));
  gh.lazySingleton<_i24.DetailsRemoteDataSource>(
      () => _i24.DetailsRemoteDataSourceImpl(get<_i3.Dio>()));
  gh.lazySingleton<_i25.DetailsRepository>(() => _i26.DetailsRepositoryImpl(
      get<_i24.DetailsRemoteDataSource>(),
      get<_i8.FavouritesLocalDataSource>()));
  gh.factory<_i27.FavouritesNotifier>(
      () => _i27.FavouritesNotifier(get<_i13.GetRestos>()));
  gh.lazySingleton<_i28.GetDetails>(
      () => _i28.GetDetails(get<_i25.DetailsRepository>()));
  gh.lazySingleton<_i29.GetRestoStatus>(
      () => _i29.GetRestoStatus(get<_i25.DetailsRepository>()));
  gh.lazySingleton<_i30.GetRestos>(
      () => _i30.GetRestos(get<_i15.HomeRepository>()));
  gh.factory<_i31.HomeNotifier>(() => _i31.HomeNotifier(get<_i30.GetRestos>()));
  gh.lazySingleton<_i32.PostReview>(
      () => _i32.PostReview(get<_i25.DetailsRepository>()));
  gh.factory<_i33.RecommendationNotificationNotifier>(() =>
      _i33.RecommendationNotificationNotifier(
          get<_i12.GetRecommendationNotificationStatus>(),
          get<_i23.SetRecommendationNotificationStatus>()));
  gh.factory<_i34.ReviewsNotifier>(
      () => _i34.ReviewsNotifier(get<_i32.PostReview>()));
  gh.factory<_i18.SearchNotifier>(
      () => _i18.SearchNotifier(get<_i22.SearchRestos>()));
  gh.lazySingleton<_i35.CreateResto>(
      () => _i35.CreateResto(get<_i25.DetailsRepository>()));
  gh.lazySingleton<_i36.DeleteResto>(
      () => _i36.DeleteResto(get<_i25.DetailsRepository>()));
  gh.factory<_i37.DetailsNotifier>(
      () => _i37.DetailsNotifier(get<_i28.GetDetails>()));
  gh.factory<_i38.BookmarkNotifier>(() => _i38.BookmarkNotifier(
      get<_i35.CreateResto>(),
      get<_i36.DeleteResto>(),
      get<_i29.GetRestoStatus>()));
  gh.singleton<_i39.BackgroundService>(_i39.BackgroundService());
  await gh.singletonAsync<_i5.Box<_i9.Resto>>(
      () => registerModule.favouritesBox,
      preResolve: true);
  await gh.singletonAsync<_i5.Box<dynamic>>(
      () => registerModule.configurationBox,
      preResolve: true);
  gh.singleton<_i40.DateTimeHelper>(_i40.DateTimeHelper());
  gh.singleton<_i41.FlutterLocalNotificationsPlugin>(
      registerModule.flutterLocalNotificationsPlugin);
  gh.singleton<_i42.GlobalKey<_i42.NavigatorState>>(
      registerModule.navigatorKey);
  gh.singleton<_i42.GlobalKey<_i42.ScaffoldState>>(registerModule.drawerKey);
  gh.singleton<_i43.NotificationHelper>(_i43.NotificationHelper(
      get<_i41.FlutterLocalNotificationsPlugin>(), get<_i3.Dio>()));
  return get;
}

class _$RegisterModule extends _i44.RegisterModule {}
