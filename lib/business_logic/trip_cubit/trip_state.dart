part of 'trip_cubit.dart';

sealed class TripState {}

final class TripInitial extends TripState {}

final class IncreasePassengerTripStep extends TripState {}

final class DecreasePassengerTripStep extends TripState {}

class PlacesLoaded extends TripState {
  final List<Place> placeList;

  PlacesLoaded({required this.placeList});
}

class PlacesError extends TripState {
  final String error;

  PlacesError({required this.error});
}
