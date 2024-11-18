part of 'carpool_cubit.dart';

sealed class CarpoolState {}

final class CarpoolInitial extends CarpoolState {}

final class IncreaseStepsPassengerBuildNewCarpoolAppState
    extends CarpoolState {}

final class DecreaseStepsPassengerBuildNewCarpoolAppState
    extends CarpoolState {}

class PlacesLoaded extends CarpoolState {
  final List<Place> placeList;

  PlacesLoaded({required this.placeList});
}

class PlacesError extends CarpoolState {
  final String error;

  PlacesError({required this.error});
}

final class SelectTimeAppState extends CarpoolState {}

final class SelectDateAppState extends CarpoolState {}

final class changeVisibilityTrueOrFalseAppState extends CarpoolState {}

final class PassengerNewCarpoolStateUpdated extends CarpoolState {}
