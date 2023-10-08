import 'package:flutter/material.dart';
import 'routes.dart';
import 'menu.dart';
import 'theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Apps(),
      routes: Routes.getRoutes(),
      theme: AppTheme.getDarkTheme(context),
    );
  }
}
