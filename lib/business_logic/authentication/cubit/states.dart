part of 'cubit.dart';

abstract class AuthenticationAppStates {}

class InitializeAppState extends AuthenticationAppStates {}

// login states

class LoadingLoginAppState extends AuthenticationAppStates {}

class SuccessLoginAppState extends AuthenticationAppStates {}

class ErrorLoginAppState extends AuthenticationAppStates {
  final String error;

  ErrorLoginAppState({required this.error});
}

class ChangeLoginPasswordVisibilityAppState extends AuthenticationAppStates {}

// register states

class LoadingRegisterAppState extends AuthenticationAppStates {}

class SuccessRegisterAppState extends AuthenticationAppStates {}

class ErrorRegisterAppState extends AuthenticationAppStates {
  final String error;

  ErrorRegisterAppState({required this.error});
}

// sending fcm states

class LoadingSendingFCMTokenAppState extends AuthenticationAppStates {}

class SuccessSendingFCMTokenAppState extends AuthenticationAppStates {}

class ErrorSendingFCMTokenAppState extends AuthenticationAppStates {
  final String error;

  ErrorSendingFCMTokenAppState({required this.error});
}

// logout

class LoadingLogoutAppState extends AuthenticationAppStates {}

class SuccessLogoutAppState extends AuthenticationAppStates {}

class ErrorLogoutAppState extends AuthenticationAppStates {
  final String error;

  ErrorLogoutAppState({required this.error});
}
