import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_store/components/themes.dart';
import 'package:watch_store/data/repo/cart_repo.dart';
import 'package:watch_store/my_http_overrides.dart';
import 'package:watch_store/routes/names.dart';
import 'package:watch_store/routes/routes.dart';
import 'package:watch_store/screens/auth/cubit/auth_cubit.dart';
import 'package:watch_store/screens/auth/send_sms_screen.dart';
import 'package:watch_store/screens/mainScreen/main_screen.dart';
import 'package:watch_store/utils/shared_preferences_manager.dart';
import 'package:watch_store/screens/cart/bloc/cart_bloc.dart';

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthCubit()),
        BlocProvider(
          create: (_) {
            final cartBloc = CartBloc(cartRepository);
            cartBloc.add(CartInitEvent());
            cartBloc.add(CartItemCountEvent());
            return cartBloc;
          },
        ),
      ],
      child: MaterialApp(
        title: 'Watch Store',
        debugShowCheckedModeBanner: false,
        theme: lightTheme(),
        routes: routes,
        home: BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is LoggedOutState) {
              Navigator.of(
                context,
              ).pushReplacementNamed(ScreenNames.sendSmsScreen);
            }
          },
          child: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is LoggedInState) {
                return MainScreen();
              } else {
                return SendSmsScreen();
              }
            },
          ),
        ),
      ),
    );
  }
}
