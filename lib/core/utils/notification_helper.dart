import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';

import '../config/config.dart';
import '../data/models/resto_model.dart';
import 'navigation.dart';

@singleton
class NotificationHelper {
  final BehaviorSubject<String> _selectNotificationSubject =
      BehaviorSubject<String>();
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin;
  final Dio _dio;

  NotificationHelper(
    this._flutterLocalNotificationsPlugin,
    this._dio,
  );

  Future<void> initNotifications() async {
    const androidInitializationSettings = AndroidInitializationSettings(
      'icon',
    );

    const iOSInitializationSettings = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iOSInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onSelectNotification: (String? payload) async {
        _selectNotificationSubject.add(payload ?? 'Empty payload');
      },
    );
  }

  Future<void> showNotification(
    RestoModel resto,
  ) async {
    const _channelId = '1';
    const _channelName = 'random_resto_recommendation_channel';
    const _channelDescription =
        'Restologue random resto recommendation channel';

    final bigPicturePath = await _downloadAndSaveFile(
        'https://$apiUrl/images/medium/${resto.pictureId}', 'bigPicture');

    final bigPictureStyleInformation = BigPictureStyleInformation(
      FilePathAndroidBitmap(bigPicturePath),
      htmlFormatTitle: true,
      htmlFormatContent: true,
    );

    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      _channelId,
      _channelName,
      _channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: bigPictureStyleInformation,
    );

    const iOSPlatformChannelSpecifics = IOSNotificationDetails();
    final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    const notificationTitle = '<b>Random Restaurant Recommendation</b>';
    final restoTitle = resto.name;

    await _flutterLocalNotificationsPlugin.show(
      0,
      notificationTitle,
      restoTitle,
      platformChannelSpecifics,
      payload: jsonEncode(resto.toJson()),
    );
  }

  void configureSelectNotificationSubject({
    required String route,
  }) {
    _selectNotificationSubject.stream.listen(
      (String payload) async {
        final data = RestoModel.fromJson(jsonDecode(payload) as Map);
        final resto = data;
        Navigation.intentWithData(route, resto);
      },
    );
  }

  void closeSelectNotificationSubject() {
    _selectNotificationSubject.close();
  }

  Future<String> _downloadAndSaveFile(
    String url,
    String fileName,
  ) async {
    final directory = await getTemporaryDirectory();
    final filePath = '${directory.path}/$fileName';
    await _dio.download(
      Uri.parse(url).toString(),
      filePath,
    );
    return filePath;
  }
}
