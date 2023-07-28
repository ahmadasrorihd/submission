import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/providers/api_provider.dart';
import 'package:restaurant_api/providers/db_provider.dart';
import 'package:restaurant_api/providers/scheduling_provider.dart';
import 'package:restaurant_api/ui/home.dart';
import 'package:restaurant_api/util/background_service.dart';
import 'package:restaurant_api/util/notification_helper.dart';
import 'package:restaurant_api/util/routes.dart';

import 'common/navigation.dart';
import 'core/api/api_client.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper notificationHelper = NotificationHelper();
  final BackgroundService service = BackgroundService();
  service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => DataProvider(apiClient: ApiClient())),
        ChangeNotifierProvider(create: (_) => DbProvider()),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurant App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: Home.routeName,
      routes: routes,
      navigatorKey: navigatorKey,
    );
  }
}
