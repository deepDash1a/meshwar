part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class LoadingProfileAppState extends HomeState {}

final class SuccessProfileDataAppState extends HomeState {
  final ProfileModel profileModel;

  SuccessProfileDataAppState({required this.profileModel});
}

final class ErrorProfileDataAppState extends HomeState {
  final String error;

  ErrorProfileDataAppState({required this.error});
}

final class changeVisibilityTrueOrFalseAppState extends HomeState {}

final class UploadImageState extends HomeState {}

final class SelectDateAppState extends HomeState {}
