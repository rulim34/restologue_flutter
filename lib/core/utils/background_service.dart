import 'dart:isolate';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';

import '../data/datasources/home_remote_data_source.dart';
import '../data/models/resto_model.dart';
import 'notification_helper.dart';

@singleton
class BackgroundService {
  static const String _isolateName = 'isolate';
  static SendPort? _sendPort;
  static final Dio _dio = Dio();
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static final NotificationHelper _notificationHelper = NotificationHelper(
    _flutterLocalNotificationsPlugin,
    _dio,
  );
  static final HomeRemoteDataSource _homeRemoteDataSource =
      HomeRemoteDataSourceImpl(
    _dio,
  );
  final ReceivePort _port = ReceivePort();

  BackgroundService();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      _port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    final RestoModel result =
        ((await _homeRemoteDataSource.getRestos())..shuffle()).first;
    await _notificationHelper.showNotification(
      result,
    );

    _sendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _sendPort?.send('DONE');
  }
}
