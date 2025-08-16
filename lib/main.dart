import 'package:flutter/material.dart';
import 'package:watch_store/components/themes.dart';
import 'package:watch_store/routes/names.dart';
import 'package:watch_store/routes/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Watch Store',
      debugShowCheckedModeBanner: false,
      theme: lightTheme(),
      initialRoute: ScreenNames.root,
      routes: routes,
    );
  }
}
