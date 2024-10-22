import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:meshwar/business_logic/layout/cubit/cubit.dart';
import 'package:meshwar/core/shared/location_helper/location_helper.dart';
import 'package:meshwar/core/theme/colors/colors.dart';
import 'package:meshwar/core/theme/fonts/fonts.dart';
import 'package:meshwar/core/theme/images/images.dart';
import 'package:meshwar/data/layout/models/maps/place_details_model.dart';
import 'package:meshwar/data/layout/models/maps/place_suggestions.dart';
import 'package:meshwar/presentation/layout/widgets/maps/widgets/place_item.dart';
import 'package:url_launcher/url_launcher.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  static final CameraPosition myCurrentCameraPosition = CameraPosition(
    bearing: 0.00,
    tilt: 0.00,
    zoom: 15.00,
    target: LatLng(
      LocationHelper.currentPosition!.latitude,
      LocationHelper.currentPosition!.longitude,
    ),
  );
  Completer<GoogleMapController> completer = Completer();

  FloatingSearchBarController floatingSearchBarController =
      FloatingSearchBarController();
  List<dynamic> places = [];

  // these vars for get place location
  Set<Marker> markers = {};
  late PlacesSuggestion placesSuggestion;
  late Place selectedPlace;
  late Marker searchedPlaceMarker;
  late Marker currentLocationMarker;
  late CameraPosition goToSearchedForPlace;

  void buildCameraNewPosition() {
    goToSearchedForPlace = CameraPosition(
      bearing: 0.00,
      tilt: 0.00,
      zoom: 15.00,
      target: LatLng(
        selectedPlace.result.geometry.location.lat,
        selectedPlace.result.geometry.location.lng,
      ),
    );
  }

  Widget buildMap() {
    return GoogleMap(
      mapType: MapType.normal,
      myLocationEnabled: true,
      zoomControlsEnabled: false,
      myLocationButtonEnabled: false,
      markers: markers,
      initialCameraPosition: myCurrentCameraPosition,
      onMapCreated: (GoogleMapController googleMapController) {
        completer.complete(googleMapController);
      },
    );
  }

  Future<void> goToMyCurrentLocation() async {
    final GoogleMapController googleMapController = await completer.future;

    googleMapController.animateCamera(
      CameraUpdate.newCameraPosition(
        myCurrentCameraPosition,
      ),
    );
  }

  // search for place
  Widget buildFloatingSearchBar() {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      controller: floatingSearchBarController,
      hint: 'ابحث ... ',
      hintStyle: const TextStyle(
        fontSize: 16,
        fontFamily: FontNamesManager.bold,
        color: ColorsManager.mainAppColor,
      ),
      queryStyle: const TextStyle(
        fontSize: 16,
        fontFamily: FontNamesManager.bold,
        color: ColorsManager.mainAppColor,
      ),
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 600),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        getPlacesSuggestions(query);
      },
      onFocusChanged: (_) {},
      transition: CircularFloatingSearchBarTransition(),
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(10.00.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              buildSuggestionsPlacesBloc(),
              buildSelectedLocationBloc(),
            ],
          ),
        );
      },
      actions: [],
      automaticallyImplyBackButton: false,
    );
  }

  Widget buildSuggestionsPlacesBloc() {
    return BlocBuilder<LayoutAppCubit, LayoutAppStates>(
      builder: (context, state) {
        if (state is PlacesLoaded) {
          places = (state).placesSuggestion;

          if (places.isNotEmpty) {
            return buildPlacesList();
          } else {
            return Container();
          }
        } else {
          return Container();
        }
      },
    );
  }

  Widget buildPlacesList() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            floatingSearchBarController.close();
          },
          child: InkWell(
            onTap: () {
              placesSuggestion = places[index];
              floatingSearchBarController.close();
              getSelectedPlaceLocation();
            },
            child: PlaceItem(
              suggestion: places[index],
            ),
          ),
        );
      },
      itemCount: places.length,
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
    );
  }

  void getPlacesSuggestions(String query) {
    context.read<LayoutAppCubit>().emitSuggestions(query);
  }

  // get place and set markers
  void getSelectedPlaceLocation() {
    context.read<LayoutAppCubit>().emitPlaceLocation(
          placesSuggestion.placeId,
        );
  }

  Widget buildSelectedLocationBloc() {
    return BlocListener<LayoutAppCubit, LayoutAppStates>(
      listener: (context, state) {
        if (state is PlaceDetailsLoaded) {
          selectedPlace = (state).placeLocation;
          gotoSearchedForLocation();
        }
      },
      child: Container(),
    );
  }

  Future<void> gotoSearchedForLocation() async {
    buildCameraNewPosition();
    GoogleMapController controller = await completer.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        goToSearchedForPlace,
      ),
    );
    buildSearchedPlaceMarker();
  }

  void buildSearchedPlaceMarker() {
    searchedPlaceMarker = Marker(
      position: goToSearchedForPlace.target,
      markerId: const MarkerId('2'),
      onTap: () {
        launchDefaultMapApp();
      },
      infoWindow: InfoWindow(
        title: placesSuggestion.description,
      ),
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRed,
      ),
    );
    addMarkerToMarkersAndUpdateUI(searchedPlaceMarker);
  }

  void addMarkerToMarkersAndUpdateUI(Marker marker) {
    setState(() {
      markers.add(marker);
    });
  }

  void launchDefaultMapApp() async {
    try {
      final Uri geoUri = Uri(
        scheme: 'geo',
        path:
            '${selectedPlace.result.geometry.location.lat},${selectedPlace.result.geometry.location.lng}',
        queryParameters: {
          'q':
              '${selectedPlace.result.geometry.location.lat},${selectedPlace.result.geometry.location.lng}'
        },
      );

      if (await canLaunchUrl(geoUri)) {
        await launchUrl(geoUri, mode: LaunchMode.externalApplication);
      } else {
        throw 'Could not launch maps for location $geoUri';
      }
    } catch (e) {
      debugPrint('Error launching map: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          LocationHelper.currentPosition == null
              ? const Center(child: CircularProgressIndicator())
              : buildMap(),
          buildFloatingSearchBar(),
          Positioned(
            bottom: 120,
            right: 20,
            child: CircleAvatar(
              radius: 25.00.r,
              backgroundColor: ColorsManager.mainAppColor,
              child: IconButton(
                onPressed: () {
                  goToMyCurrentLocation();
                },
                icon: Image.asset(
                  ImagesManager.getCurrentLocation,
                  color: ColorsManager.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
