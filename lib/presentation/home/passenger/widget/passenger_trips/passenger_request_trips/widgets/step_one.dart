import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meshwar/business_logic/trip_cubit/trip_cubit.dart';
import 'package:meshwar/core/shared/widgets/custom_text.dart';
import 'package:meshwar/core/shared/widgets/custom_text_form_field.dart';
import 'package:meshwar/core/theme/colors/colors.dart';
import 'package:meshwar/core/theme/images/images.dart';

class BuildPassengerTripStepOne extends StatefulWidget {
  const BuildPassengerTripStepOne({super.key});

  @override
  State<BuildPassengerTripStepOne> createState() =>
      _BuildPassengerTripStepOneState();
}

class _BuildPassengerTripStepOneState extends State<BuildPassengerTripStepOne> {
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<TripCubit>();
    return BlocConsumer<TripCubit, TripState>(
      listener: (context, state) {},
      builder: (BuildContext context, TripState state) {
        return Column(
          children: [
            CustomTextFormField(
              hintText: 'ابحث عن نقطة الإلتقاء',
              prefixIcon: SvgPicture.asset(
                ImagesManager.location,
                height: 10.0.h,
              ),
              onChanged: (value) {
                if (value.isNotEmpty ||
                    cubit.passengerRequestTripStepOneSearchMapController.text ==
                        '') {
                  cubit.getSuggestions(
                    value,
                    cubit.passengerRequestTripStepOnePlaceLoaded,
                  );
                }
              },
              controller: cubit.passengerRequestTripStepOneSearchMapController,
              inputType: TextInputType.text,
            ),
            cubit.passengerRequestTripStepOnePlaceLoaded.isEmpty
                ? const SizedBox()
                : SizedBox(height: 20.00.h),
            cubit.passengerRequestTripStepOnePlaceLoaded.isNotEmpty
                ? ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => InkWell(
                      onTap: () async {
                        final selectedPlace =
                            cubit.passengerRequestTripStepOnePlaceLoaded[index];
                        final newLatLng = LatLng(
                          selectedPlace.geometry!.location!.lat!,
                          selectedPlace.geometry!.location!.lng!,
                        );
                        final newAddress = selectedPlace.formattedAddress;

                        setState(() {
                          cubit.passengerRequestTripStepOneNewLatLng =
                              newLatLng;
                          cubit.passengerRequestTripStepOneNewAddress =
                              newAddress;

                          cubit.passengerRequestTripStepOneMarkerSet.clear();
                          cubit.passengerRequestTripStepOneMarkerSet.add(
                            Marker(
                              markerId: const MarkerId('PassengerNewCarpool'),
                              position: newLatLng,
                              infoWindow: InfoWindow(
                                title: newAddress,
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const CustomText(
                                          text: 'إزالة الوجهة'),
                                      content: CustomText(
                                          text:
                                              'هل تريد إزالة الوجهة $newAddress؟'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              cubit.passengerRequestTripStepOneNewLatLng =
                                                  null;
                                              cubit.passengerRequestTripStepOneNewAddress =
                                                  null;
                                              cubit
                                                  .passengerRequestTripStepOneMarkerSet
                                                  .clear();
                                            });
                                            Navigator.of(context).pop();
                                          },
                                          child: const CustomText(text: 'نعم'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: const CustomText(text: 'لا'),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            ),
                          );

                          cubit.passengerRequestTripStepOnePlaceLoaded = [];
                          cubit.passengerRequestTripStepOneSearchMapController
                              .clear();
                        });

                        final GoogleMapController controller =
                            await cubit.passengerRequestTripMapCompleter.future;
                        controller.animateCamera(
                          CameraUpdate.newLatLng(newLatLng),
                        );
                      },
                      child: Card(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 20.0.w, vertical: 10.h),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(
                                    Icons.location_on_outlined,
                                    color: ColorsManager.darkOrange,
                                  ),
                                  SizedBox(width: 10.00.w),
                                  Expanded(
                                    child: CustomText(
                                      textAlign: TextAlign.end,
                                      text:
                                          '${cubit.passengerRequestTripStepOnePlaceLoaded[index].name}',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 5.00.h),
                              CustomText(
                                text:
                                    '${cubit.passengerRequestTripStepOnePlaceLoaded[index].formattedAddress}',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    separatorBuilder: (context, index) => SizedBox(
                      height: 5.h,
                    ),
                    itemCount:
                        cubit.passengerRequestTripStepOnePlaceLoaded.length,
                  )
                : const SizedBox(),
            SizedBox(height: 20.00.h),
            Container(
              width: double.infinity.w,
              height: 500.h,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0.r),
              ),
              child: GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: cubit.passengerRequestTripInitialPosition,
                  zoom: 13.5,
                ),
                markers: cubit.passengerRequestTripStepOneMarkerSet,
                gestureRecognizers: {
                  Factory<OneSequenceGestureRecognizer>(
                      () => EagerGestureRecognizer())
                },
                myLocationEnabled: true,
                mapType: MapType.normal,
                onTap: (point) async {
                  List<Placemark> placeMarks = await placemarkFromCoordinates(
                      point.latitude, point.longitude);
                  Placemark place = placeMarks.first;

                  setState(() {
                    cubit.passengerRequestTripStepOneNewLatLng = LatLng(
                      point.latitude,
                      point.longitude,
                    );
                    cubit.passengerRequestTripStepOneNewAddress =
                        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
                    cubit.passengerRequestTripStepOneMarkerSet.clear();
                    cubit.passengerRequestTripStepOneMarkerSet.add(
                      Marker(
                        markerId: MarkerId(
                            'marker-${point.latitude}-${point.longitude}'),
                        position: LatLng(
                          cubit.passengerRequestTripStepOneNewLatLng!.latitude,
                          cubit.passengerRequestTripStepOneNewLatLng!.longitude,
                        ),
                        infoWindow: InfoWindow(
                          title: cubit.passengerRequestTripStepOneNewAddress,
                        ),
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const CustomText(text: 'حذف الماركر'),
                              content: CustomText(
                                text:
                                    'هل تريد حذف هذا الموقع؟\n${cubit.passengerRequestTripStepOneNewAddress}',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      cubit.passengerRequestTripStepOneMarkerSet
                                          .removeWhere(
                                        (marker) =>
                                            marker.markerId ==
                                            MarkerId(
                                              'marker-${point.latitude}-${point.longitude}',
                                            ),
                                      );
                                    });
                                    Navigator.pop(context);
                                  },
                                  child: const CustomText(text: 'حذف'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: const CustomText(text: 'إلغاء'),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    );
                  });
                },
                onMapCreated: (controller) {
                  cubit.passengerRequestTripMapCompleter.complete(controller);
                },
              ),
            ),
            SizedBox(height: 20.00.h),
          ],
        );
      },
    );
  }
}
