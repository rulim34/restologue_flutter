import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/config/theme.dart';
import 'core/domain/entities/resto.dart';
import 'core/utils/background_service.dart';
import 'core/utils/notification_helper.dart';
import 'features/details/presentation/pages/details_page.dart';
import 'features/navbar/presentation/widgets/navbar.dart';
import 'injection.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(RestoAdapter());
  await configureDependencies();

  final NotificationHelper _notificationHelper = getIt<NotificationHelper>();
  final BackgroundService _backgroundService = getIt<BackgroundService>();

  _backgroundService.initializeIsolate();
  await _notificationHelper.initNotifications();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  runApp(
    ProviderScope(
      child: App(_notificationHelper),
    ),
  );
}

class App extends StatefulWidget {
  final NotificationHelper notificationHelper;

  const App(
    this.notificationHelper,
  );

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    widget.notificationHelper.configureSelectNotificationSubject(
      route: '/details',
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.notificationHelper.closeSelectNotificationSubject();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restologue',
      theme: lightTheme,
      debugShowCheckedModeBanner: false,
      navigatorKey: getIt<GlobalKey<NavigatorState>>(),
      home: NavBar(),
      routes: {
        '/details': (context) => DetailsPage(
              resto: ModalRoute.of(context)!.settings.arguments! as Resto,
            ),
      },
    );
  }
}
