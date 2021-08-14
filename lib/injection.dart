import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import 'core/domain/entities/resto.dart';
import 'injection.config.dart';

final getIt = GetIt.instance;

@injectableInit
Future<void> configureDependencies() async {
  await $initGetIt(getIt);
}

@module
abstract class RegisterModule {
  @preResolve
  @singleton
  Future<Box<Resto>> get favouritesBox async =>
      Hive.openBox<Resto>('favourites');

  @preResolve
  @singleton
  Future<Box> get configurationBox async => Hive.openBox('configuration');

  @singleton
  GlobalKey<ScaffoldState> get drawerKey => GlobalKey();

  @singleton
  GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();

  @singleton
  FlutterLocalNotificationsPlugin get flutterLocalNotificationsPlugin =>
      FlutterLocalNotificationsPlugin();

  @lazySingleton
  Dio get dio => Dio();
}
