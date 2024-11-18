part of 'auth_cubit.dart';

sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class changeVisibilityTrueOrFalseAppState extends AuthState {}

final class LoadingLoginAppState extends AuthState {}

final class SuccessLoginAppState extends AuthState {
  final UserModel userModel;

  SuccessLoginAppState({required this.userModel});
}

final class ErrorLoginAppState extends AuthState {
  final String error;

  ErrorLoginAppState({required this.error});
}

// forgetPassword
final class LoadingForgetPasswordAppState extends AuthState {}

final class SuccessForgetPasswordAppState extends AuthState {}

final class ErrorForgetPasswordAppState extends AuthState {
  final String error;

  ErrorForgetPasswordAppState({required this.error});
}

// registration
final class IncreaseStepsRegistrationAppState extends AuthState {}

final class DecreaseStepsRegistrationAppState extends AuthState {}

final class RefreshScreen extends AuthState {}

final class UploadImageState extends AuthState {}

final class SelectDateAppState extends AuthState {}

// passenger registration states
final class LoadingPassengerRegistrationAppState extends AuthState {}

final class SuccessPassengerRegistrationAppState extends AuthState {}

final class ErrorPassengerRegistrationAppState extends AuthState {
  final String error;

  ErrorPassengerRegistrationAppState({required this.error});
}
