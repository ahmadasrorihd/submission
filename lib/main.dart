import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_api/providers/api_provider.dart';
import 'package:restaurant_api/providers/db_provider.dart';
import 'package:restaurant_api/ui/home.dart';
import 'package:restaurant_api/util/routes.dart';

import 'core/api/api_client.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => DataProvider(apiClient: ApiClient())),
        ChangeNotifierProvider(create: (_) => DbProvider()),
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
    );
  }
}
