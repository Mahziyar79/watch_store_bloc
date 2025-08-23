import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:meta/meta.dart';
import 'package:watch_store/data/constants.dart';
import 'package:watch_store/data/model/user.dart';
import 'package:watch_store/utils/shared_preferences_keys.dart';
import 'package:watch_store/utils/shared_preferences_manager.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  final Dio _dio = Dio();

  pickLocation({required context}) async {
    await showSimplePickerLocation(
      isDismissible: true,
      title: 'انتخاب موقعیت مکانی',
      textCancelPicker: 'لغو',
      textConfirmPicker: 'تایید',
      zoomOption: ZoomOption(initZoom: 8),
      // initCurrentUserPosition: UserTrackingOption.withoutUserPosition(),
      initPosition: GeoPoint(latitude: 47.4358055, longitude: 8.4737),
      radius: 8.0,
      context: context,
    ).then((value) {
      emit(LocationPickedState(location: value));
    });
  }

  register({required User user}) async {
    emit(LoadingState());
    try {
      String? token = SharedPreferencesManager().getString(
        SharedPreferencesKeys.token,
      );
      _dio.options.headers['Authorization'] = "Bearer $token";
      print(user.toMap());

      await _dio
          .post(Endpoints.register, data: FormData.fromMap(user.toMap()))
          .then((value) {
            if (value.statusCode == 201) {
              emit(SuccessResponseState());
            } else {
              emit(ErrorState());
            }
          });
    } catch (e) {
      emit(ErrorState());
    }
  }
}
