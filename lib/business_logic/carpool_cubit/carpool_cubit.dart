import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meshwar/core/shared/widgets/custom_text.dart';
import 'package:meshwar/data/models/carpool_model/place_location.dart';
import 'package:meshwar/data/remote_data_source/carpool_remote_data_source/passenger_carpool_remote_data_source/passenger_carpool_remote_data_source.dart';

part 'carpool_state.dart';

class CarpoolCubit extends Cubit<CarpoolState> {
  final PassengerCarpoolRemoteDataSource passengerCarpoolRemoteDataSource;

  CarpoolCubit(this.passengerCarpoolRemoteDataSource) : super(CarpoolInitial());

  // general
  int passengerBuildNewCarpoolCurrentStep = 0;
  int passengerBuildNewCarpoolTotalSteps = 3;
  final emailRegex =
      RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
  final passwordRegex = RegExp(r'^(?=.*[A-Za-z]).{6,}$');
  final egyptPhoneRegExp = RegExp(r'^(?:\+20|0)?1[0125]\d{8}$');

  // step one
  var passengerNewCarpoolStepOneSearchMapController = TextEditingController();
  final Set<Marker> passengerNewCarpoolStepOneMarkerSet = {};
  LatLng passengerNewCarpoolStepOneInitialPosition =
      const LatLng(30.033333, 31.233334); // default cairo
  Completer<GoogleMapController> passengerNewCarpoolStepOneMapCompleter =
      Completer();
  LatLng? passengerNewCarpoolStepOneNewLatLng;
  String? passengerNewCarpoolStepOneNewAddress;

  // others of step one
  var passengerNewCarpoolStepOneFormKey = GlobalKey<FormState>();
  var passengerNewCarpoolStepOneGovernorateController = TextEditingController();
  var passengerNewCarpoolStepOneResidentialAreaController =
      TextEditingController();
  var passengerNewCarpoolStepOneNeighborhoodController =
      TextEditingController();
  var passengerNewCarpoolStepOneStreetController = TextEditingController();
  var passengerNewCarpoolStepOneBuildingController = TextEditingController();
  var passengerNewCarpoolStepOneDistinctiveMarkController =
      TextEditingController();
  var passengerNewCarpoolStepOneStartDateController = TextEditingController();
  var passengerNewCarpoolStepOneStartTimeController = TextEditingController();

  // step two
  var passengerNewCarpoolStepTwoSearchMapController = TextEditingController();
  final Set<Marker> passengerNewCarpoolStepTwoMarkerSet = {};
  LatLng passengerNewCarpoolSteTwoInitialPosition =
      const LatLng(30.033333, 31.233334); // default cairo
  Completer<GoogleMapController> passengerNewCarpoolStepTwoMapCompleter =
      Completer();
  LatLng? passengerNewCarpoolStepTwoNewLatLng;
  String? passengerNewCarpoolStepTwoNewAddress;

  // others of step two
  var passengerNewCarpoolStepTwoFormKey = GlobalKey<FormState>();
  var passengerNewCarpoolStepTwoGovernorateController = TextEditingController();
  var passengerNewCarpoolStepTwoResidentialAreaController =
      TextEditingController();
  var passengerNewCarpoolStepTwoNeighborhoodController =
      TextEditingController();
  var passengerNewCarpoolStepTwoStreetController = TextEditingController();
  var passengerNewCarpoolStepTwoBuildingController = TextEditingController();
  var passengerNewCarpoolStepTwoDistinctiveMarkController =
      TextEditingController();
  var passengerNewCarpoolStepTwoStartDateController = TextEditingController();
  var passengerNewCarpoolStepTwoStartTimeController = TextEditingController();

  // step three
  var passengerNewCarpoolStepThreeFormKey = GlobalKey<FormState>();
  bool passengerNewCarpoolStepThreeIsWeekly = false;
  Map<String, bool> daysOfWeek = {
    'السبت': false,
    'الأحد': false,
    'الإثنين': false,
    'الثلاثاء': false,
    'الأربعاء': false,
    'الخميس': false,
    'الجمعة': false,
  };
  List<String> passengerNewCarpoolStepThreeSelectedDaysOfWeek = [];
  double passengerNewCarpoolStepThreeAmountOfExtraTime = 00.00;
  double passengerNewCarpoolStepThreeAmountOfExtraDistance = 00.00;
  double passengerNewCarpoolStepThreeAmountOfExtraWalking = 00.00;
  String? passengerNewCarpoolStepThreeWantIncreasingWhen;
  List<DropdownMenuItem<int>> passengerNewCarpoolStepThreeSeatNumberList = [
    const DropdownMenuItem(
      value: 1,
      child: CustomText(
        text: 'مقعد', // Seat
      ),
    ),
    const DropdownMenuItem(
      value: 2,
      child: CustomText(
        text: 'مقعدان', // Two seats
      ),
    ),
    const DropdownMenuItem(
      value: 3,
      child: CustomText(
        text: 'ثلاثة مقاعد', // Three seats
      ),
    ),
    const DropdownMenuItem(
      value: 4,
      child: CustomText(
        text: 'أربعة مقاعد', // Four seats
      ),
    ),
  ];
  int? passengerNewCarpoolStepThreeSeatNumberValue;

  // second companion
  var passengerNewCarpoolStepThreeFirstNameOfSecondCompanionController =
      TextEditingController();

  var passengerNewCarpoolStepThreeLastNameOfSecondCompanionController =
      TextEditingController();

  var passengerNewCarpoolStepThreePhoneOfSecondCompanionController =
      TextEditingController();

  var passengerNewCarpoolStepThreeEmailOfSecondCompanionController =
      TextEditingController();

  // third companion
  var passengerNewCarpoolStepThreeFirstNameOfThirdCompanionController =
      TextEditingController();

  var passengerNewCarpoolStepThreeLastNameOfThirdCompanionController =
      TextEditingController();

  var passengerNewCarpoolStepThreePhoneOfThirdCompanionController =
      TextEditingController();

  var passengerNewCarpoolStepThreeEmailOfThirdCompanionController =
      TextEditingController();

  // forth companion
  var passengerNewCarpoolStepThreeFirstNameOfFourthCompanionController =
      TextEditingController();

  var passengerNewCarpoolStepThreeLastNameOfFourthCompanionController =
      TextEditingController();

  var passengerNewCarpoolStepThreePhoneOfFourthCompanionController =
      TextEditingController();

  var passengerNewCarpoolStepThreeEmailOfFourthCompanionController =
      TextEditingController();
  bool passengerNewCarpoolStepThreeIAgreeWithRoles = false;

  // function
  double progressValue() {
    return (passengerBuildNewCarpoolCurrentStep + 1) /
        passengerBuildNewCarpoolTotalSteps;
  }

  void nextStep() {
    if (passengerBuildNewCarpoolCurrentStep <
        passengerBuildNewCarpoolTotalSteps - 1) {
      passengerBuildNewCarpoolCurrentStep++;
    }
  }

  void previousStep() {
    if (passengerBuildNewCarpoolCurrentStep > 0) {
      passengerBuildNewCarpoolCurrentStep--;
    }
  }

  GetPlace? getPlace;
  List<Place> passengerNewCarpoolStepOnePlaceLoaded = [];
  List<Place> passengerNewCarpoolStepTwoPlaceLoaded = [];

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

  Future<void> selectFormattedTime(
      BuildContext context, TextEditingController controller) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null) {
      final period = picked.period == DayPeriod.am ? 'ص' : 'م';

      final formattedTime =
          "${picked.hourOfPeriod.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')} $period";

      controller.text = formattedTime;
      emit(SelectTimeAppState());
    }
  }

  Future<void> selectFutureDate(
      BuildContext context, TextEditingController controller) async {
    DateTime? piked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2050),
    );

    if (piked != null) {
      controller.text = piked.toString().split(" ")[0];
      emit(SelectDateAppState());
    }
  }

  // step three
  void changeVisibilityTrueOrFalse({
    required bool currentVisibility,
    required void Function(bool) updateVisibility,
  }) {
    final newVisibility = !currentVisibility;

    updateVisibility(newVisibility);

    emit(changeVisibilityTrueOrFalseAppState());
  }

  void updateDaySelection(String day, bool isSelected) {
    daysOfWeek[day] = isSelected;

    if (isSelected) {
      if (!passengerNewCarpoolStepThreeSelectedDaysOfWeek.contains(day)) {
        passengerNewCarpoolStepThreeSelectedDaysOfWeek.add(day);
      }
    } else {
      passengerNewCarpoolStepThreeSelectedDaysOfWeek.remove(day);
    }
    print(passengerNewCarpoolStepThreeSelectedDaysOfWeek);
    emit(PassengerNewCarpoolStateUpdated());
  }

  passengerCreateNewCarpoolTripValid() {
    switch (passengerBuildNewCarpoolCurrentStep) {
      case 0:
        return passengerNewCarpoolStepOneFormKey.currentState!.validate() &&
            passengerNewCarpoolStepOneMarkerSet.isNotEmpty;
      case 1:
        return passengerNewCarpoolStepTwoFormKey.currentState!.validate() &&
            passengerNewCarpoolStepTwoMarkerSet.isNotEmpty;
      case 2:
        return passengerNewCarpoolStepThreeFormKey.currentState!.validate() &&
            passengerNewCarpoolStepThreeIAgreeWithRoles == true &&
            passengerNewCarpoolStepThreeSelectedDaysOfWeek.length > 2;
    }
  }
}
