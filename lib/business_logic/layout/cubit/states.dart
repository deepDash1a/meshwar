part of 'cubit.dart';

abstract class LayoutAppStates {}

// general
class InitializeAppState extends LayoutAppStates {}

class OnItemTappedAppState extends LayoutAppStates {}

class SuccessPickImageAppState extends LayoutAppStates {}

class ErrorPickImageAppState extends LayoutAppStates {}

// home
class LoadingNotificationsAppState extends LayoutAppStates {}

class SuccessNotificationsAppState extends LayoutAppStates {}

class ErrorNotificationsAppState extends LayoutAppStates {
  final String error;

  ErrorNotificationsAppState({required this.error});
}

class LoadingAcceptTripAppState extends LayoutAppStates {}

class SuccessAcceptTripAppState extends LayoutAppStates {}

class ErrorAcceptTripAppState extends LayoutAppStates {
  final String error;

  ErrorAcceptTripAppState({required this.error});
}

class LoadingStartTripAppState extends LayoutAppStates {}

class SuccessStartTripAppState extends LayoutAppStates {}

class ErrorStartTripAppState extends LayoutAppStates {
  final String error;

  ErrorStartTripAppState({required this.error});
}

// shift
class LoadingStartShiftAppState extends LayoutAppStates {}

class SuccessStartShiftAppState extends LayoutAppStates {}

class ErrorStartShiftAppState extends LayoutAppStates {
  final String error;

  ErrorStartShiftAppState({required this.error});
}

class LoadingGetCarsAppState extends LayoutAppStates {}

class SuccessGetCarsAppState extends LayoutAppStates {}

class ErrorGetCarsAppState extends LayoutAppStates {
  final String error;

  ErrorGetCarsAppState({required this.error});
}

// maps
class PlacesLoaded extends LayoutAppStates {
  final List<dynamic> placesSuggestion;

  PlacesLoaded(this.placesSuggestion);
}

class PlaceDetailsLoaded extends LayoutAppStates {
  final Place placeLocation;

  PlaceDetailsLoaded(this.placeLocation);
}

class AddMarkerToMap extends LayoutAppStates {}

// personal

class LoadingProfileDataAppState extends LayoutAppStates {}

class SuccessProfileDataAppState extends LayoutAppStates {}

class ErrorProfileDataAppState extends LayoutAppStates {
  final String error;

  ErrorProfileDataAppState({required this.error});
}

class LoadingUpdateProfileDataAppState extends LayoutAppStates {}

class SuccessUpdateProfileDataAppState extends LayoutAppStates {}

class ErrorUpdateProfileDataAppState extends LayoutAppStates {
  final String error;

  ErrorUpdateProfileDataAppState({required this.error});
}

class LoadingLogoutAppState extends LayoutAppStates {}

class SuccessLogoutAppState extends LayoutAppStates {}

class ErrorLogoutAppState extends LayoutAppStates {
  final String error;

  ErrorLogoutAppState({required this.error});
}
