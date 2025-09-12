import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:watch_store/data/constants.dart';
import 'package:watch_store/utils/shared_preferences_keys.dart';
import 'package:watch_store/utils/shared_preferences_manager.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  String? _serverCode;
  String? get serverCode => _serverCode;
  AuthCubit() : super(AuthInitial()) {
    String? token = SharedPreferencesManager().getString(
      SharedPreferencesKeys.token,
    );
    if (token == null) {
      emit(LoggedOutState());
    } else {
      emit(LoggedInState());
    }
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
        _serverCode = response.data["data"]["code"].toString();
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

  //Timer
  Timer? _timer;
  int _totalTime = 120;

  void startTimer() {
    _timer?.cancel();
    _totalTime = 120;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_totalTime == 0) {
        timer.cancel();
        emit(TimerFinishedState());
      } else {
        _totalTime--;
        emit(TimerTickState(_totalTime));
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
  }

  Future<void> logout() async {
    await SharedPreferencesManager().remove(SharedPreferencesKeys.token);
    emit(LoggedOutState());
  }
}
