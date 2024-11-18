import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meshwar/business_logic/carpool_cubit/carpool_cubit.dart';
import 'package:meshwar/core/shared/widgets/custom_text.dart';
import 'package:meshwar/core/shared/widgets/custom_text_form_field.dart';
import 'package:meshwar/core/theme/colors/colors.dart';
import 'package:meshwar/core/theme/images/images.dart';

class BuildPassengerEndCarpoolStepTwo extends StatefulWidget {
  const BuildPassengerEndCarpoolStepTwo({super.key});

  @override
  State<BuildPassengerEndCarpoolStepTwo> createState() =>
      _BuildPassengerEndCarpoolStepTwoState();
}

class _BuildPassengerEndCarpoolStepTwoState
    extends State<BuildPassengerEndCarpoolStepTwo> {
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<CarpoolCubit>();
    return BlocConsumer<CarpoolCubit, CarpoolState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Form(
          key: cubit.passengerNewCarpoolStepTwoFormKey,
          child: Column(
            children: [
              CustomTextFormField(
                hintText: 'ابحث عن المكان',
                prefixIcon: SvgPicture.asset(
                  ImagesManager.location,
                  height: 10.00.h,
                ),
                controller: cubit.passengerNewCarpoolStepTwoSearchMapController,
                inputType: TextInputType.text,
                onChanged: (value) {
                  if (value.isNotEmpty ||
                      cubit.passengerNewCarpoolStepTwoSearchMapController
                              .text ==
                          '') {
                    cubit.getSuggestions(
                      value,
                      cubit.passengerNewCarpoolStepTwoPlaceLoaded,
                    );
                  }
                },
              ),
              cubit.passengerNewCarpoolStepTwoPlaceLoaded.isEmpty
                  ? const SizedBox()
                  : SizedBox(height: 20.00.h),
              cubit.passengerNewCarpoolStepTwoPlaceLoaded.isNotEmpty
                  ? ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => InkWell(
                        onTap: () async {
                          setState(() {
                            cubit.passengerNewCarpoolStepTwoNewLatLng = LatLng(
                              cubit.passengerNewCarpoolStepOnePlaceLoaded[index]
                                  .geometry!.location!.lat!,
                              cubit.passengerNewCarpoolStepOnePlaceLoaded[index]
                                  .geometry!.location!.lng!,
                            );

                            cubit.passengerNewCarpoolStepTwoNewAddress = cubit
                                .passengerNewCarpoolStepTwoPlaceLoaded[index]
                                .formattedAddress;
                            cubit.passengerNewCarpoolStepTwoMarkerSet.clear();
                            cubit.passengerNewCarpoolStepTwoMarkerSet.add(
                              Marker(
                                markerId: const MarkerId('PassengerNewCarpool'),
                                position: LatLng(
                                    cubit.passengerNewCarpoolStepOneNewLatLng!
                                        .latitude,
                                    cubit.passengerNewCarpoolStepOneNewLatLng!
                                        .longitude),
                                infoWindow: InfoWindow(
                                  title: cubit
                                      .passengerNewCarpoolStepOneNewAddress,
                                ),
                              ),
                            );

                            cubit.passengerNewCarpoolStepTwoPlaceLoaded = [];
                            cubit.passengerNewCarpoolStepTwoSearchMapController
                                .clear();
                          });

                          final GoogleMapController controller = await cubit
                              .passengerNewCarpoolStepTwoMapCompleter.future;
                          controller.animateCamera(
                            CameraUpdate.newLatLng(
                              cubit.passengerNewCarpoolStepTwoNewLatLng!,
                            ),
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
                                            '${cubit.passengerNewCarpoolStepTwoPlaceLoaded[index].name}',
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.00.h),
                                CustomText(
                                  text:
                                      '${cubit.passengerNewCarpoolStepTwoPlaceLoaded[index].formattedAddress}',
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
                          cubit.passengerNewCarpoolStepTwoPlaceLoaded.length,
                    )
                  : const SizedBox(),
              SizedBox(height: 20.00.h),
              Container(
                width: double.infinity.w,
                height: 400.00.h,
                clipBehavior: Clip.antiAliasWithSaveLayer,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0.r),
                ),
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: cubit.passengerNewCarpoolSteTwoInitialPosition,
                    zoom: 13.5,
                  ),
                  markers: cubit.passengerNewCarpoolStepTwoMarkerSet,
                  gestureRecognizers: {
                    Factory<OneSequenceGestureRecognizer>(
                        () => EagerGestureRecognizer())
                  },
                  myLocationEnabled: true,
                  mapType: MapType.normal,
                  onTap: (point) async {
                    // get new address
                    List<Placemark> placeMarks = await placemarkFromCoordinates(
                        point.latitude, point.longitude);
                    Placemark place = placeMarks.first;

                    setState(() {
                      cubit.passengerNewCarpoolStepTwoNewLatLng = LatLng(
                        point.latitude,
                        point.longitude,
                      );
                      cubit.passengerNewCarpoolStepTwoNewAddress =
                          '${place.street}, ${place.subLocality}, '
                          '${place.locality}, ${place.postalCode}, ${place.country}';

                      cubit.passengerNewCarpoolStepTwoMarkerSet.clear();

                      cubit.passengerNewCarpoolStepTwoMarkerSet.add(
                        Marker(
                          markerId: const MarkerId('PassengerEndCarpool'),
                          position: LatLng(
                              cubit.passengerNewCarpoolStepTwoNewLatLng!
                                  .latitude,
                              cubit.passengerNewCarpoolStepTwoNewLatLng!
                                  .longitude),
                          infoWindow: InfoWindow(
                            title: cubit.passengerNewCarpoolStepOneNewAddress,
                          ),
                        ),
                      );

                      cubit.passengerNewCarpoolStepTwoPlaceLoaded = [];
                      cubit.passengerNewCarpoolStepTwoSearchMapController
                          .clear();
                    });
                  },
                  onMapCreated: (controller) {
                    cubit.passengerNewCarpoolStepTwoMapCompleter
                        .complete(controller);
                  },
                ),
              ),
              SizedBox(height: 20.00.h),
              CustomTextFormField(
                hintText: 'المحافظة',
                prefixIcon: SvgPicture.asset(
                  ImagesManager.governorate,
                  height: 10.0.h,
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'من فضلك هذا الحقل مطلوب';
                  }
                  return null;
                },
                controller:
                    cubit.passengerNewCarpoolStepTwoGovernorateController,
                inputType: TextInputType.text,
              ),
              SizedBox(height: 20.00.h),
              CustomTextFormField(
                hintText: 'المنطقة السكنية',
                prefixIcon: SvgPicture.asset(
                  ImagesManager.residentialArea,
                  height: 10.0.h,
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'من فضلك هذا الحقل مطلوب';
                  }
                  return null;
                },
                controller:
                    cubit.passengerNewCarpoolStepTwoResidentialAreaController,
                inputType: TextInputType.text,
              ),
              SizedBox(height: 20.00.h),
              CustomTextFormField(
                hintText: 'الحي',
                prefixIcon: SvgPicture.asset(
                  ImagesManager.neighborhood,
                  height: 10.0.h,
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'من فضلك هذا الحقل مطلوب';
                  }
                  return null;
                },
                controller:
                    cubit.passengerNewCarpoolStepTwoNeighborhoodController,
                inputType: TextInputType.text,
              ),
              SizedBox(height: 20.00.h),
              CustomTextFormField(
                hintText: 'الشارع',
                prefixIcon: SvgPicture.asset(
                  ImagesManager.street,
                  height: 10.0.h,
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'من فضلك هذا الحقل مطلوب';
                  }
                  return null;
                },
                controller: cubit.passengerNewCarpoolStepTwoStreetController,
                inputType: TextInputType.text,
              ),
              SizedBox(height: 20.00.h),
              CustomTextFormField(
                hintText: 'العمارة',
                prefixIcon: SvgPicture.asset(
                  ImagesManager.building,
                  height: 10.0.h,
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'من فضلك هذا الحقل مطلوب';
                  }
                  return null;
                },
                controller: cubit.passengerNewCarpoolStepTwoBuildingController,
                inputType: TextInputType.text,
              ),
              SizedBox(height: 20.00.h),
              CustomTextFormField(
                hintText: 'علامة مميزة',
                prefixIcon: SvgPicture.asset(
                  ImagesManager.distinctiveMark,
                  height: 10.0.h,
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'من فضلك هذا الحقل مطلوب';
                  }
                  return null;
                },
                controller:
                    cubit.passengerNewCarpoolStepTwoDistinctiveMarkController,
                inputType: TextInputType.text,
              ),
              SizedBox(height: 20.00.h),
              CustomTextFormField(
                hintText: 'اختر تاريخ نهاية الرحلة',
                prefixIcon: SvgPicture.asset(
                  ImagesManager.date,
                  height: 10.h,
                ),
                controller: cubit.passengerNewCarpoolStepTwoStartDateController,
                inputType: TextInputType.text,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'من فضلك هذا الحقل مطلوب';
                  }
                  return null;
                },
                readOnly: true,
                onTap: () {
                  cubit.selectFutureDate(context,
                      cubit.passengerNewCarpoolStepTwoStartDateController);
                },
              ),
              SizedBox(height: 20.00.h),
              CustomTextFormField(
                hintText: 'اختر توقيت نهاية الرحلة',
                prefixIcon: SvgPicture.asset(
                  ImagesManager.time,
                  height: 10.h,
                ),
                controller: cubit.passengerNewCarpoolStepTwoStartTimeController,
                inputType: TextInputType.text,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'من فضلك هذا الحقل مطلوب';
                  }
                  return null;
                },
                readOnly: true,
                onTap: () {
                  cubit.selectFormattedTime(
                    context,
                    cubit.passengerNewCarpoolStepTwoStartTimeController,
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
