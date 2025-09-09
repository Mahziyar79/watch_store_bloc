import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:watch_store/data/model/user_info.dart';
import 'package:watch_store/data/repo/user_repo.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final IUserRepo _iUserRepo;

  ProfileBloc(this._iUserRepo) : super(ProfileLoadingState()) {
    on<ProfileEvent>((event, emit) async {
      if (event is ProfileInitEvent) {
        try {
          emit(ProfileLoadingState());
          final profileInfo = await _iUserRepo.getUserInfo();
          emit(ProfileLoadedState(profileInfo));
        } catch (e) {
          emit(ProfileErrorState());
        }
      }
    });
  }
}
