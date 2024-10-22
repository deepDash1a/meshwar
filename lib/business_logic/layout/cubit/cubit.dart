import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meshwar/core/theme/colors/colors.dart';
import 'package:meshwar/data/layout/models/home/notifications_model.dart';
import 'package:meshwar/data/layout/models/maps/place_details_model.dart';
import 'package:meshwar/data/layout/models/perosnal/profile_model.dart';
import 'package:meshwar/data/layout/remote_data_source/remote_data_source.dart';
import 'package:meshwar/presentation/layout/widgets/home/screens/home.dart';
import 'package:meshwar/presentation/layout/widgets/maps/screens/maps.dart';
import 'package:meshwar/presentation/layout/widgets/personal/screens/personal_screen.dart';
import 'package:meshwar/presentation/layout/widgets/shift/screens/shift.dart';

part 'states.dart';

class LayoutAppCubit extends Cubit<LayoutAppStates> {
  final LayoutRemoteDataSource layoutRemoteDataSource;

  LayoutAppCubit(this.layoutRemoteDataSource) : super(InitializeAppState());
  final String emailAppRegex =
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
  final String passwordRegex = r'^(?=.*[a-zA-Z]).{7,}$';

  // layout (general)
  int selectedIndex = 0;
  final List<Widget> pages = [
    const HomeScreen(),
    const ShiftScreen(),
    const MapScreen(),
    const PersonalScreen()
  ];

  void onItemTapped(int index) {
    selectedIndex = index;
    emit(OnItemTappedAppState());
  }

  Future<void> pickImageAndAssign(ImageSource source, XFile? newImage) async {
    final ImagePicker picker = ImagePicker();

    final XFile? pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      newImage = pickedImage;
      emit(SuccessPickImageAppState());
    } else {
      emit(ErrorPickImageAppState());
    }
  }

  // home
  GetAllNotificationsModel? getAllNotifications;
  List<Notifications> tripNotifications = [];
  List<Notifications> messagesNotifications = [];

  getNotifications() async {
    emit(LoadingNotificationsAppState());
    try {
      await layoutRemoteDataSource.getNotifications().then(
        (value) {
          getAllNotifications = GetAllNotificationsModel.fromJson(value.data);

          tripNotifications = getAllNotifications!.body!.where((notification) {
            return notification.data?.tripId != null;
          }).toList();

          messagesNotifications =
              getAllNotifications!.body!.where((notification) {
            return notification.data?.content != null;
          }).toList();

          print(messagesNotifications);
        },
      );
      emit(SuccessNotificationsAppState());
    } catch (error) {
      emit(ErrorNotificationsAppState(error: error.toString()));
    }
  }

  acceptTrip() async {
    emit(LoadingAcceptTripAppState());
    try {
      await layoutRemoteDataSource.acceptTrip();
      emit(SuccessAcceptTripAppState());
    } catch (error) {
      emit(ErrorAcceptTripAppState(error: error.toString()));
    }
  }

  startTrip() async {
    emit(LoadingStartTripAppState());
    try {
      await layoutRemoteDataSource.startTrip();
      emit(SuccessStartTripAppState());
    } catch (error) {
      emit(ErrorStartTripAppState(error: error.toString()));
    }
  }

  // shift

  startShift() async {
    emit(LoadingStartShiftAppState());
    try {
      // layoutRemoteDataSource
      //     .startShift(
      //       odometerImage,
      //       carTypeId: carTypeId,
      //       odometerStart: odometerStart,
      //       locationName: locationName,
      //       latitude: latitude,
      //       longitude: longitude,
      //     )
      //     .then((value) {})
      //     .catchError((error) {});

      emit(SuccessStartShiftAppState());
    } catch (error) {
      emit(ErrorStartShiftAppState(error: error.toString()));
    }
  }

  // maps
  void emitSuggestions(String place) {
    layoutRemoteDataSource.getSuggestions(place).then((value) {
      emit(PlacesLoaded(value));
    });
  }

  void emitPlaceLocation(String placeId) {
    layoutRemoteDataSource.getPlaceLocation(placeId).then((value) {
      emit(PlaceDetailsLoaded(value));
    });
  }

  Future<Map<String, dynamic>> buildMarkersAndPolylinesForDestinations(
      List<String?> destinationAddresses) async {
    Set<Marker> markers = {};
    Set<Polyline> polylines = {};
    List<LatLng> polylinePoints = [];

    for (int i = 0; i < destinationAddresses.length; i++) {
      if (destinationAddresses[i] != null &&
          destinationAddresses[i]!.isNotEmpty) {
        LatLng? position = await getLatLngFromAddress(destinationAddresses[i]!);

        markers.add(
          Marker(
            markerId: MarkerId('destination_$i'),
            position: position!,
            infoWindow: InfoWindow(
              title: 'Destination ${i + 1}',
              snippet: destinationAddresses[i],
            ),
          ),
        );

        polylinePoints.add(position);
      }
    }

    if (polylinePoints.length > 1) {
      polylines.add(
        Polyline(
          polylineId: const PolylineId('route'),
          points: polylinePoints,
          color: ColorsManager.blue,
          width: 5,
        ),
      );
    }

    return {
      'markers': markers,
      'polylines': polylines,
    };
  }

  Future<LatLng?> getLatLngFromAddress(String address) async {
    return getCoordinatesFromAddress(address);
  }

  Future<LatLng?> getCoordinatesFromAddress(String address) async {
    try {
      List<dynamic> locations =
          await locationFromAddress(address); // Replace with actual API call
      if (locations.isNotEmpty) {
        return LatLng(locations.first.latitude, locations.first.longitude);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
    }
    return null;
  }

  // personal
  ProfileModel? profileModel;

  var personalFirstNameController = TextEditingController();
  var personalLastNameController = TextEditingController();
  var personalWhatsappController = TextEditingController();
  var personalAnotherNumberController = TextEditingController();
  var personalEmailController = TextEditingController();
  var personalAddressController = TextEditingController();
  XFile? personalImage;

  getProfileData() async {
    emit(LoadingProfileDataAppState());
    try {
      await layoutRemoteDataSource.getProfileData().then((value) {
        profileModel = ProfileModel.fromJson(value.data);
        personalFirstNameController.text = '${profileModel!.body!.firstName}';
        personalLastNameController.text = '${profileModel!.body!.lastName}';
        personalWhatsappController.text =
            '${profileModel!.body!.whatsappNumber}';
        personalAnotherNumberController.text =
            '${profileModel!.body!.anotherNumber}';
        personalEmailController.text = '${profileModel!.body!.email}';
        personalAddressController.text = '${profileModel!.body!.address}';
      });
      emit(SuccessProfileDataAppState());
    } catch (error) {
      emit(ErrorProfileDataAppState(error: error.toString()));
    }
  }

  updateProfileData() async {
    emit(LoadingUpdateProfileDataAppState());
    try {
      await layoutRemoteDataSource.updateProfile(
        personalImage,
        firstName: personalFirstNameController.text,
        lastName: personalLastNameController.text,
        email: personalEmailController.text,
        whatsAppNumber: personalWhatsappController.text,
        anotherNumber: personalAnotherNumberController.text,
        address: personalAddressController.text,
      );
      emit(SuccessUpdateProfileDataAppState());
    } catch (error) {
      emit(ErrorUpdateProfileDataAppState(error: error.toString()));
    }
  }
}
