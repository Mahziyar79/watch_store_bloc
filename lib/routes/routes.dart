import 'package:flutter/widgets.dart';
import 'package:watch_store/routes/names.dart';
import 'package:watch_store/screens/auth/verify_code_screen.dart';
import 'package:watch_store/screens/mainScreen/main_screen.dart';
import 'package:watch_store/screens/product_list_screen.dart';
import 'package:watch_store/screens/product_single_screen.dart';
import 'package:watch_store/screens/register/register_screen.dart';
import 'package:watch_store/screens/auth/send_sms_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  ScreenNames.verifyCodeScreen: (context) => VerifyCodeScreen(),
  ScreenNames.sendSmsScreen: (context) => SendSmsScreen(),
  ScreenNames.registerScreen: (context) => RegisterScreen(),
  ScreenNames.mainScreen: (context) => MainScreen(),
  ScreenNames.productListScreen: (context) => ProductListScreen(),
  ScreenNames.productSingleScreen: (context) => ProductSingleScreen(),
};
