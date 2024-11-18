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

class BuildPassengerNewCarpoolStepOne extends StatefulWidget {
  const BuildPassengerNewCarpoolStepOne({super.key});

  @override
  State<BuildPassengerNewCarpoolStepOne> createState() =>
      _BuildPassengerNewCarpoolStepOneState();
}

class _BuildPassengerNewCarpoolStepOneState
    extends State<BuildPassengerNewCarpoolStepOne> {
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<CarpoolCubit>();
    return BlocConsumer<CarpoolCubit, CarpoolState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Form(
          key: cubit.passengerNewCarpoolStepOneFormKey,
          child: Column(
            children: [
              CustomTextFormField(
                hintText: 'ابحث عن المكان',
                prefixIcon: SvgPicture.asset(
                  ImagesManager.location,
                  height: 10.00.h,
                ),
                controller: cubit.passengerNewCarpoolStepOneSearchMapController,
                inputType: TextInputType.text,
                onChanged: (value) {
                  if (value.isNotEmpty ||
                      cubit.passengerNewCarpoolStepOneSearchMapController
                              .text ==
                          '') {
                    cubit.getSuggestions(
                      value,
                      cubit.passengerNewCarpoolStepOnePlaceLoaded,
                    );
                  }
                },
              ),
              cubit.passengerNewCarpoolStepOnePlaceLoaded.isEmpty
                  ? const SizedBox()
                  : SizedBox(height: 20.00.h),
              cubit.passengerNewCarpoolStepOnePlaceLoaded.isNotEmpty
                  ? ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => InkWell(
                        onTap: () async {
                          setState(() {
                            cubit.passengerNewCarpoolStepOneNewLatLng = LatLng(
                              cubit.passengerNewCarpoolStepOnePlaceLoaded[index]
                                  .geometry!.location!.lat!,
                              cubit.passengerNewCarpoolStepOnePlaceLoaded[index]
                                  .geometry!.location!.lng!,
                            );

                            cubit.passengerNewCarpoolStepOneNewAddress = cubit
                                .passengerNewCarpoolStepOnePlaceLoaded[index]
                                .formattedAddress;
                            cubit.passengerNewCarpoolStepOneMarkerSet.clear();
                            cubit.passengerNewCarpoolStepOneMarkerSet.add(
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

                            cubit.passengerNewCarpoolStepOnePlaceLoaded = [];
                            cubit.passengerNewCarpoolStepOneSearchMapController
                                .clear();
                          });

                          final GoogleMapController controller = await cubit
                              .passengerNewCarpoolStepOneMapCompleter.future;
                          controller.animateCamera(
                            CameraUpdate.newLatLng(
                              cubit.passengerNewCarpoolStepOneNewLatLng!,
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
                                            '${cubit.passengerNewCarpoolStepOnePlaceLoaded[index].name}',
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.00.h),
                                CustomText(
                                  text:
                                      '${cubit.passengerNewCarpoolStepOnePlaceLoaded[index].formattedAddress}',
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
                          cubit.passengerNewCarpoolStepOnePlaceLoaded.length,
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
                    target: cubit.passengerNewCarpoolStepOneInitialPosition,
                    zoom: 13.5,
                  ),
                  markers: cubit.passengerNewCarpoolStepOneMarkerSet,
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
                      cubit.passengerNewCarpoolStepOneNewLatLng = LatLng(
                        point.latitude,
                        point.longitude,
                      );
                      cubit.passengerNewCarpoolStepOneNewAddress =
                          '${place.street}, ${place.subLocality}, '
                          '${place.locality}, ${place.postalCode}, ${place.country}';

                      cubit.passengerNewCarpoolStepOneMarkerSet.clear();

                      cubit.passengerNewCarpoolStepOneMarkerSet.add(
                        Marker(
                          markerId: const MarkerId('PassengerNewCarpool'),
                          position: LatLng(
                              cubit.passengerNewCarpoolStepOneNewLatLng!
                                  .latitude,
                              cubit.passengerNewCarpoolStepOneNewLatLng!
                                  .longitude),
                          infoWindow: InfoWindow(
                            title: cubit.passengerNewCarpoolStepOneNewAddress,
                          ),
                        ),
                      );

                      cubit.passengerNewCarpoolStepOnePlaceLoaded = [];
                      cubit.passengerNewCarpoolStepOneSearchMapController
                          .clear();
                    });
                  },
                  onMapCreated: (controller) {
                    cubit.passengerNewCarpoolStepOneMapCompleter
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
                    cubit.passengerNewCarpoolStepOneGovernorateController,
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
                    cubit.passengerNewCarpoolStepOneResidentialAreaController,
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
                    cubit.passengerNewCarpoolStepOneNeighborhoodController,
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
                controller: cubit.passengerNewCarpoolStepOneStreetController,
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
                controller: cubit.passengerNewCarpoolStepOneBuildingController,
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
                    cubit.passengerNewCarpoolStepOneDistinctiveMarkController,
                inputType: TextInputType.text,
              ),
              SizedBox(height: 20.00.h),
              CustomTextFormField(
                hintText: 'اختر تاريخ بداية الرحلة',
                prefixIcon: SvgPicture.asset(
                  ImagesManager.date,
                  height: 10.h,
                ),
                controller: cubit.passengerNewCarpoolStepOneStartDateController,
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
                      cubit.passengerNewCarpoolStepOneStartDateController);
                },
              ),
              SizedBox(height: 20.00.h),
              CustomTextFormField(
                hintText: 'اختر توقيت بداية الرحلة',
                prefixIcon: SvgPicture.asset(
                  ImagesManager.time,
                  height: 10.h,
                ),
                controller: cubit.passengerNewCarpoolStepOneStartTimeController,
                inputType: TextInputType.text,
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return 'من فضلك هذا الحقل مطلوب';
                  }
                  return null;
                },
                readOnly: true,
                onTap: () {
                  cubit.selectFormattedTime(context,
                      cubit.passengerNewCarpoolStepOneStartTimeController);
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
