part of 'profile_bloc.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileLoadingState extends ProfileState {}

final class ProfileErrorState extends ProfileState {}

final class ProfileLoadedState extends ProfileState {
  final User userInfoList;
  const ProfileLoadedState(this.userInfoList);
  @override
  List<Object> get props => [userInfoList];
}
