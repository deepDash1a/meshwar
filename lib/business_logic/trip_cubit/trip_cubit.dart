import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meshwar/data/models/carpool_model/place_location.dart';
import 'package:meshwar/data/remote_data_source/trip_remote_data_source/trip_remote_data_source.dart';

part 'trip_state.dart';

class TripCubit extends Cubit<TripState> {
  final PassengerTripRemoteDataSource passengerTripRemoteDataSource;

  TripCubit(this.passengerTripRemoteDataSource) : super(TripInitial());

  // in general
  int passengerBuildTripCurrentStep = 0;
  int passengerBuildTripTotalSteps = 4;
  final emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  final passwordRegex = RegExp(r'^(?=.*[A-Za-z]).{6,}$');
  final egyptPhoneRegExp = RegExp(r'^(?:\+20|0)?1[0125]\d{8}$');

  // step one
  var passengerRequestTripStepOneSearchMapController = TextEditingController();
  final Set<Marker> passengerRequestTripStepOneMarkerSet = {};
  LatLng passengerRequestTripInitialPosition =
      const LatLng(30.033333, 31.233334); // default cairo
  Completer<GoogleMapController> passengerRequestTripMapCompleter =
      Completer();
  LatLng? passengerRequestTripStepOneNewLatLng;
  String? passengerRequestTripStepOneNewAddress;

  // step two
  var passengerRequestTripStepTwoFormKey = GlobalKey<FormState>();
  var passengerRequestTripStepTwoSearchMapController = TextEditingController();
  final Set<Marker> passengerRequestTripStepTwoMarkerSet = {};
  List<double> passengerRequestTripStepTwoLats = [];
  List<double> passengerRequestTripStepTwoLongs = [];
  List<String> passengerRequestTripStepTwoAddresses = [];

  // functions
  double progressValue() {
    return (passengerBuildTripCurrentStep + 1) / passengerBuildTripTotalSteps;
  }

  void nextStep() {
    if (passengerBuildTripCurrentStep < passengerBuildTripTotalSteps - 1) {
      passengerBuildTripCurrentStep++;
    }
    emit(IncreasePassengerTripStep());
  }

  void previousStep() {
    if (passengerBuildTripCurrentStep > 0) {
      passengerBuildTripCurrentStep--;
    }
    emit(DecreasePassengerTripStep());
  }

  GetPlace? getPlace;
  List<Place> passengerRequestTripStepOnePlaceLoaded = [];
  List<Place> passengerRequestTripStepTwoPlaceLoaded = [];

  Future<void> getSuggestions(String place, List<Place> placeList) async {
    placeList.clear();
    try {
      Response response = await Dio().get(
        'https://maps.googleapis.com/maps/api/place/textsearch/json',
        queryParameters: {
          'query': place,
          'type': 'address',
          'components': 'country:eg',
          'key': 'AIzaSyBtpz1PYwlJoXX_OC4Mpi9-h4mDzyPZGvM',
        },
      );

      getPlace = GetPlace.fromJson(response.data);

      if (getPlace != null && getPlace!.body != null) {
        placeList.addAll(getPlace!.body!);
      }

      emit(PlacesLoaded(placeList: placeList));
    } catch (error) {
      emit(PlacesError(error: error.toString()));
    }
  }
}
