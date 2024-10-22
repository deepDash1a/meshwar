import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meshwar/business_logic/layout/cubit/cubit.dart';
import 'package:meshwar/core/shared/functions/functions.dart';
import 'package:meshwar/core/shared/widgets/custom_text_button.dart';
import 'package:meshwar/core/shared/widgets/texts.dart';
import 'package:meshwar/core/theme/colors/colors.dart';

class NotificationDetails extends StatelessWidget {
  final String notificationId;
  final List<String?> destinationAddresses;

  const NotificationDetails({
    super.key,
    required this.notificationId,
    required this.destinationAddresses,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<LayoutAppCubit>();

    return BlocConsumer<LayoutAppCubit, LayoutAppStates>(
      listener: (context, state) {
        if (state is SuccessAcceptTripAppState) {
          customSnackBar(
              context: context,
              text: 'تم قبول الرحلة بنجاح',
              color: ColorsManager.green);
        }
        if (state is SuccessStartTripAppState) {
          customSnackBar(
              context: context,
              text: 'تم بداية الرحلة بنجاح',
              color: ColorsManager.green);
        }
        if (state is ErrorAcceptTripAppState) {
          customSnackBar(
              context: context,
              text: 'تم قبول هذه الرحلة من قبل',
              color: ColorsManager.red);
        }
        if (state is ErrorStartTripAppState) {
          customSnackBar(
              context: context,
              text: 'يجب أن تقبل الرحلة أولًا',
              color: ColorsManager.red);
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context); // Go back to the previous screen
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                size: 20.0,
                color: ColorsManager.white,
              ),
            ),
            title: const BoldText16dark(
              text: 'تفاصيل الرحلة',
              color: ColorsManager.white,
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 20.0.h,
              horizontal: 16.0.w,
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 500.0.h,
                      margin: EdgeInsets.symmetric(
                        horizontal: 2.0.h,
                        vertical: 2.0.h,
                      ),
                      decoration: BoxDecoration(
                        color: ColorsManager.white,
                        boxShadow: [
                          BoxShadow(
                            color: ColorsManager.mainAppColor.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: FutureBuilder<Map<String, dynamic>>(
                        future: cubit.buildMarkersAndPolylinesForDestinations(
                          destinationAddresses,
                        ),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                              child: Text('Error: ${snapshot.error}'),
                            );
                          } else if (snapshot.hasData) {
                            Set<Marker> markers = snapshot.data!['markers'];
                            Set<Polyline> polylines =
                                snapshot.data!['polylines'];

                            return GoogleMap(
                              gestureRecognizers: {
                                Factory<OneSequenceGestureRecognizer>(
                                    () => EagerGestureRecognizer())
                              },
                              mapType: MapType.normal,
                              initialCameraPosition: const CameraPosition(
                                target: LatLng(30.0444, 31.2357),
                                zoom: 13.5,
                              ),
                              markers: markers,
                              polylines: polylines,
                            );
                          } else {
                            return const Center(
                              child: Text("No destinations available"),
                            );
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 20.0.h),
                    const BoldText16dark(text: 'نقطة الإلتقاء'),
                    const RegularText16dark(
                      text: 'هنا هحط الداتا اللي جاية',
                      color: ColorsManager.black,
                    ),
                    SizedBox(height: 20.0.h),
                    for (int i = 0; i < destinationAddresses.length; i++)
                      if (destinationAddresses[i] != null) ...[
                        BoldText16dark(
                          text: 'الوجهة ${i + 1}',
                          color: ColorsManager.green,
                        ),
                        RegularText16dark(
                          text: destinationAddresses[i] ?? 'No data available',
                          color: ColorsManager.black,
                        ),
                        SizedBox(height: 10.0.h),
                      ],
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: state is LoadingAcceptTripAppState
                              ? const Center(child: CircularProgressIndicator())
                              : CustomTextButton(
                                  text: 'قبول الرحلة',
                                  color: ColorsManager.amber,
                                  function: () {
                                    cubit.acceptTrip();
                                  },
                                ),
                        ),
                        Expanded(
                          child: state is LoadingStartTripAppState
                              ? const Center(child: CircularProgressIndicator())
                              : CustomTextButton(
                                  text: 'بداية الرحلة',
                                  color: ColorsManager.blue,
                                  function: () {
                                    cubit.startTrip();
                                  },
                                ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
