import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:watch_store/data/constants.dart';
import 'package:watch_store/utils/shared_preferences_keys.dart';
import 'package:watch_store/utils/shared_preferences_manager.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial()) {
    emit(LoggedOutState());
  }
  Dio dio = Dio();

  sendSms(String mobile) async {
    emit(LoadingState());
    try {
      final response = await dio.post(
        Endpoints.sendSms,
        data: {"mobile": mobile},
      );
      debugPrint(response.toString());
      if (response.statusCode == 201) {
        emit(SentState(mobile: mobile));
      } else {
        emit(
          ErrorState(
            response.data['message'] ??
                "خطا در ارسال پیامک: کد ${response.statusCode}",
          ),
        );
      }
    } catch (e, s) {
      debugPrint("sendSms error: $e\n$s");
      emit(ErrorState(e.toString()));
    }
  }

  verifySms(String mobile, String code) async {
    emit(LoadingState());
    try {
      await dio
          .post(Endpoints.checkSmsCode, data: {"mobile": mobile, "code": code})
          .then((value) {
            debugPrint(value.toString());
            if (value.statusCode == 201) {
              SharedPreferencesManager().saveString(
                SharedPreferencesKeys.token,
                value.data["data"]["token"],
              );
              if (value.data["data"]["is_registered"]) {
                emit(VerifiedIsRegisterState());
              } else {
                emit(VerifiedNotRegisteState());
              }
            } else {
              emit(ErrorState(value.data['message'] ?? "خطایی رخ داده است"));
            }
          });
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }
}
