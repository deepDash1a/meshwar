import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meshwar/business_logic/trip_cubit/trip_cubit.dart';
import 'package:meshwar/core/shared/widgets/custom_button.dart';
import 'package:meshwar/core/shared/widgets/custom_text.dart';
import 'package:meshwar/core/theme/colors/colors.dart';
import 'package:meshwar/core/theme/fonts/fonts.dart';
import 'package:meshwar/presentation/home/passenger/widget/passenger_trips/passenger_request_trips/widgets/step_one.dart';
import 'package:meshwar/presentation/home/passenger/widget/passenger_trips/passenger_request_trips/widgets/step_three.dart';
import 'package:meshwar/presentation/home/passenger/widget/passenger_trips/passenger_request_trips/widgets/step_two.dart';

class PassengerRequestTrips extends StatefulWidget {
  const PassengerRequestTrips({super.key});

  @override
  State<PassengerRequestTrips> createState() => _PassengerRequestTripsState();
}

class _PassengerRequestTripsState extends State<PassengerRequestTrips> {
  Widget buildStepContent() {
    var cubit = context.read<TripCubit>();

    switch (cubit.passengerBuildTripCurrentStep) {
      case 0:
        return const BuildPassengerTripStepOne();
      case 1:
        return const BuildPassengerTripStepTwo();
      case 2:
        return const BuildPassengerTripStepThree();

      default:
        return const Center(
          child: CustomText(
            text: 'Unknown Step',
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<TripCubit>();

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: ColorsManager.white,
            size: 20.00,
          ),
        ),
        titleSpacing: 0.00,
        title: CustomText(
          text: 'إنشاء رحلة جديدة',
          fontSize: 16.00.sp,
          fontFamily: FontManager.bold,
          color: ColorsManager.white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.00.w,
          vertical: 16.00.h,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerRight,
                child: CustomText(
                  textAlign: TextAlign.end,
                  color: ColorsManager.darkOrange,
                  text: cubit.passengerBuildTripCurrentStep == 0
                      ? 'المرحلة الأولى، ضع نقطة الإلتقاء'
                      : cubit.passengerBuildTripCurrentStep == 1
                          ? 'المرحلة الثانية، قم بوضع وجهاتك على الخريطة بعناية بحد أقصى أربع وجهات'
                          : 'المرحلة الأخيرة، قم بإدخال تفاصيل الرحلة',
                ),
              ),
              SizedBox(height: 20.00.h),
              LinearProgressIndicator(
                value: cubit.progressValue(),
              ),
              SizedBox(height: 20.00.h),
              Row(
                children: [
                  cubit.passengerBuildTripCurrentStep == 0
                      ? const SizedBox()
                      : CustomButton(
                          text: 'الرجوع',
                          onPressed: () {
                            setState(() {
                              cubit.previousStep();
                            });
                          },
                        ),
                  const Spacer(),
                  cubit.passengerBuildTripCurrentStep != 3
                      ? CustomButton(
                          text: 'التالي',
                          onPressed: () {
                            setState(() {
                              cubit.nextStep();
                            });
                          },
                        )
                      : CustomButton(
                          text: 'إرسال',
                          onPressed: () {},
                        ),
                ],
              ),
              SizedBox(height: 20.00.h),
              buildStepContent(),
            ],
          ),
        ),
      ),
    );
  }
}
