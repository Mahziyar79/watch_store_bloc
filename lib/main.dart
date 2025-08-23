import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_store/components/themes.dart';
import 'package:watch_store/my_http_overrides.dart';
import 'package:watch_store/routes/routes.dart';
import 'package:watch_store/screens/auth/cubit/auth_cubit.dart';
import 'package:watch_store/screens/auth/send_sms_screen.dart';
import 'package:watch_store/screens/mainScreen/main_screen.dart';
import 'package:watch_store/utils/shared_preferences_manager.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPreferencesManager().init();
  HttpOverrides.global = MyHttpOverrides();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        title: 'Watch Store',
        debugShowCheckedModeBanner: false,
        theme: lightTheme(),
        // initialRoute: ScreenNames.root,
        routes: routes,
        home: BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            if (state is LoggedInState) {
              return MainScreen();
            } else {
              return SendSmsScreen();
            }
          },
        ),
      ),
    );
  }
}
