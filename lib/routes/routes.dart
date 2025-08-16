import 'package:flutter/widgets.dart';
import 'package:watch_store/routes/names.dart';
import 'package:watch_store/screens/get_otp_screen.dart';
import 'package:watch_store/screens/mainScreen/main_screen.dart';
import 'package:watch_store/screens/product_list_screen.dart';
import 'package:watch_store/screens/product_single_screen.dart';
import 'package:watch_store/screens/register_screen.dart';
import 'package:watch_store/screens/send_otp_screen.dart';

Map<String, Widget Function(BuildContext)> routes = {
  ScreenNames.root: (context) => SendOtpScreen(),
  ScreenNames.getOtpScreen: (context) => GetOtpScreen(),
  ScreenNames.registerScreen: (context) => RegisterScreen(),
  ScreenNames.mainScreen: (context) => MainScreen(),
  ScreenNames.productListScreen: (context) => ProductListScreen(),
  ScreenNames.productSingleScreen: (context) => ProductSingleScreen(),
};
