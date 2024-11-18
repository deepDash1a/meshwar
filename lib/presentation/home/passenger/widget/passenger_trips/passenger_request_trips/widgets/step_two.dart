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
import 'package:meshwar/core/shared/widgets/custom_text_button.dart';
import 'package:meshwar/core/shared/widgets/custom_text_form_field.dart';
import 'package:meshwar/core/theme/colors/colors.dart';
import 'package:meshwar/core/theme/images/images.dart';

class BuildPassengerTripStepTwo extends StatefulWidget {
  const BuildPassengerTripStepTwo({super.key});

  @override
  State<BuildPassengerTripStepTwo> createState() =>
      _BuildPassengerTripStepTwoState();
}

class _BuildPassengerTripStepTwoState extends State<BuildPassengerTripStepTwo> {
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<TripCubit>();
    return BlocConsumer<TripCubit, TripState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Form(
          key: cubit.passengerRequestTripStepTwoFormKey,
          child: Column(
            children: [
              CustomTextFormField(
                hintText: 'ابحث عن نقطة الإلتقاء',
                prefixIcon: SvgPicture.asset(
                  ImagesManager.location,
                  height: 10.0.h,
                ),
                onChanged: (value) {
                  if (value.isNotEmpty ||
                      cubit.passengerRequestTripStepTwoSearchMapController
                              .text ==
                          '') {
                    cubit.getSuggestions(
                      value,
                      cubit.passengerRequestTripStepTwoPlaceLoaded,
                    );
                  }
                },
                controller:
                    cubit.passengerRequestTripStepTwoSearchMapController,
                inputType: TextInputType.text,
              ),
              cubit.passengerRequestTripStepTwoPlaceLoaded.isEmpty
                  ? const SizedBox()
                  : SizedBox(height: 20.00.h),
              cubit.passengerRequestTripStepTwoPlaceLoaded.isNotEmpty
                  ? ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          if (cubit
                                  .passengerRequestTripStepTwoMarkerSet.length <
                              4) {
                            setState(() {
                              final place =
                                  cubit.passengerRequestTripStepTwoPlaceLoaded[
                                      index];
                              final lat = place.geometry!.location!.lat!;
                              final lng = place.geometry!.location!.lng!;
                              final address = place.formattedAddress!;

                              cubit.passengerRequestTripStepTwoLats.add(lat);
                              cubit.passengerRequestTripStepTwoLongs.add(lng);
                              cubit.passengerRequestTripStepTwoAddresses
                                  .add(address);

                              final marker = Marker(
                                markerId: MarkerId('point-$lat-$lng'),
                                position: LatLng(lat, lng),
                                infoWindow: InfoWindow(
                                  title: place.name,
                                  snippet: address,
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => AlertDialog(
                                        title: const CustomText(
                                            text: 'إزالة الوجهة'),
                                        content: CustomText(
                                            text:
                                                'هل تريد إزالة الوجهة $address؟'),
                                        actions: [
                                          CustomTextButton(
                                            onPressed: () {
                                              setState(() {
                                                cubit
                                                    .passengerRequestTripStepTwoLats
                                                    .remove(lat);
                                                cubit
                                                    .passengerRequestTripStepTwoLongs
                                                    .remove(lng);
                                                cubit
                                                    .passengerRequestTripStepTwoAddresses
                                                    .remove(address);
                                                cubit
                                                    .passengerRequestTripStepTwoMarkerSet
                                                    .removeWhere(
                                                  (m) =>
                                                      m.markerId.value ==
                                                      'point-$lat-$lng',
                                                );
                                              });
                                              Navigator.of(context).pop();
                                            },
                                            text: 'نعم',
                                          ),
                                          CustomTextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(),
                                            text: 'لا',
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              );

                              cubit.passengerRequestTripStepTwoMarkerSet
                                  .add(marker);

                              cubit.passengerRequestTripStepTwoPlaceLoaded = [];
                            });
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) => const AlertDialog(
                                title: CustomText(
                                    text: 'تم الوصول إلى عدد الوجهات المحدد'),
                              ),
                            );
                            cubit.passengerRequestTripStepTwoPlaceLoaded = [];
                          }
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
                                        text:
                                            '${cubit.passengerRequestTripStepTwoPlaceLoaded[index].name}',
                                        textAlign: TextAlign.end,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 5.00.h),
                                CustomText(
                                  text:
                                      '${cubit.passengerRequestTripStepTwoPlaceLoaded[index].formattedAddress}',
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 5.h),
                      itemCount:
                          cubit.passengerRequestTripStepTwoPlaceLoaded.length,
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
                  markers: cubit.passengerRequestTripStepTwoMarkerSet.toSet(),
                  gestureRecognizers: {
                    Factory<OneSequenceGestureRecognizer>(
                        () => EagerGestureRecognizer()),
                  },
                  myLocationEnabled: true,
                  mapType: MapType.normal,
                  onTap: (point) async {
                    if (cubit.passengerRequestTripStepTwoMarkerSet.length < 4) {
                      List<Placemark> placeMarks =
                          await placemarkFromCoordinates(
                        point.latitude,
                        point.longitude,
                      );
                      Placemark place = placeMarks.first;
                      String address =
                          "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";

                      setState(() {
                        cubit.passengerRequestTripStepTwoLats
                            .add(point.latitude);
                        cubit.passengerRequestTripStepTwoLongs
                            .add(point.longitude);
                        cubit.passengerRequestTripStepTwoAddresses.add(address);

                        final marker = Marker(
                          markerId: MarkerId(
                              'point-${point.latitude}-${point.longitude}'),
                          position: point,
                          infoWindow: InfoWindow(
                            title: 'وجهة جديدة',
                            snippet: address,
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: const CustomText(text: 'إزالة الوجهة'),
                                  content: CustomText(
                                      text: 'هل تريد إزالة الوجهة $address؟'),
                                  actions: [
                                    CustomTextButton(
                                      onPressed: () {
                                        setState(() {
                                          cubit.passengerRequestTripStepTwoLats
                                              .remove(point.latitude);
                                          cubit.passengerRequestTripStepTwoLongs
                                              .remove(point.longitude);
                                          cubit
                                              .passengerRequestTripStepTwoAddresses
                                              .remove(address);
                                          cubit
                                              .passengerRequestTripStepTwoMarkerSet
                                              .removeWhere(
                                            (m) =>
                                                m.markerId.value ==
                                                'point-${point.latitude}-${point.longitude}',
                                          );
                                        });
                                        Navigator.of(context).pop();
                                      },
                                      text: 'نعم',
                                    ),
                                    CustomTextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      text: 'لا',
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        );

                        cubit.passengerRequestTripStepTwoMarkerSet.add(marker);
                      });
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => const AlertDialog(
                          title: CustomText(
                              text: 'تم الوصول إلى عدد الوجهات المحدد'),
                        ),
                      );
                    }
                  },
                  onMapCreated: (controller) {
                    cubit.passengerRequestTripMapCompleter.complete(controller);
                  },
                ),
              ),
              SizedBox(height: 20.00.h),
              cubit.passengerRequestTripStepTwoAddresses.isEmpty
                  ? const SizedBox()
                  : ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: index == 0
                                ? 'الوجهة الأولى'
                                : index == 1
                                    ? 'الوجهة الثانية'
                                    : index == 2
                                        ? 'الوجهة الثالثة'
                                        : 'الوجهة الرابعة',
                            color: ColorsManager.darkOrange,
                          ),
                          CustomText(
                            textAlign: TextAlign.end,
                            text: cubit
                                .passengerRequestTripStepTwoAddresses[index],
                          ),
                        ],
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 20.h,
                      ),
                      itemCount:
                          cubit.passengerRequestTripStepTwoAddresses.length,
                    )
            ],
          ),
        );
      },
    );
  }
}
