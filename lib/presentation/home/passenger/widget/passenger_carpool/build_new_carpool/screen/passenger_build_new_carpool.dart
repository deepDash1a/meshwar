import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meshwar/business_logic/carpool_cubit/carpool_cubit.dart';
import 'package:meshwar/core/shared/functions/functions.dart';
import 'package:meshwar/core/shared/widgets/custom_button.dart';
import 'package:meshwar/core/shared/widgets/custom_text.dart';
import 'package:meshwar/core/theme/colors/colors.dart';
import 'package:meshwar/core/theme/fonts/fonts.dart';
import 'package:meshwar/presentation/home/passenger/widget/passenger_carpool/build_new_carpool/widgets/step_one.dart';
import 'package:meshwar/presentation/home/passenger/widget/passenger_carpool/build_new_carpool/widgets/step_three.dart';
import 'package:meshwar/presentation/home/passenger/widget/passenger_carpool/build_new_carpool/widgets/step_two.dart';

// Main
class PassengerBuildNewCarpool extends StatefulWidget {
  const PassengerBuildNewCarpool({super.key});

  @override
  State<PassengerBuildNewCarpool> createState() =>
      _PassengerBuildNewCarpoolState();
}

class _PassengerBuildNewCarpoolState extends State<PassengerBuildNewCarpool> {
  Widget buildStepContent() {
    var cubit = context.read<CarpoolCubit>();

    switch (cubit.passengerBuildNewCarpoolCurrentStep) {
      case 0:
        return const BuildPassengerNewCarpoolStepOne();
      case 1:
        return const BuildPassengerEndCarpoolStepTwo();
      case 2:
        return const BuildPassengerDetailsCarpoolStepThree();

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
    var cubit = context.read<CarpoolCubit>();

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
          text: 'إنشاء دورة كاربول جديدة',
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
                  color: ColorsManager.darkOrange,
                  text: cubit.passengerBuildNewCarpoolCurrentStep == 0
                      ? 'المرحلة الأولى، بداية الرحلة'
                      : cubit.passengerBuildNewCarpoolCurrentStep == 1
                          ? 'المرحلة الثانية، نهاية الرحلة'
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
                  cubit.passengerBuildNewCarpoolCurrentStep == 0
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
                  cubit.passengerBuildNewCarpoolCurrentStep != 2
                      ? CustomButton(
                          text: 'التالي',
                          onPressed: () {
                            if (cubit.passengerCreateNewCarpoolTripValid()) {
                              setState(
                                () {
                                  cubit.nextStep();
                                },
                              );
                            } else if (cubit
                                    .passengerBuildNewCarpoolCurrentStep ==
                                0) {
                              cubit.passengerNewCarpoolStepOneMarkerSet.isEmpty
                                  ? customSnackBar(
                                      context: context,
                                      text: 'من فضلك اختر نقطة البداية',
                                      color: ColorsManager.red,
                                    )
                                  : const SizedBox();
                            } else if (cubit
                                    .passengerBuildNewCarpoolCurrentStep ==
                                1) {
                              cubit.passengerNewCarpoolStepTwoMarkerSet.isEmpty
                                  ? customSnackBar(
                                      context: context,
                                      text: 'من فضلك اختر نقطة النهاية',
                                      color: ColorsManager.red,
                                    )
                                  : const SizedBox();
                            }
                          },
                        )
                      : CustomButton(
                          text: 'إرسال',
                          onPressed: () {
                            if (cubit.passengerCreateNewCarpoolTripValid()) {
                              setState(
                                () {
                                  customSnackBar(
                                    context: context,
                                    text: 'تمت',
                                    color: ColorsManager.green,
                                  );
                                },
                              );
                            } else if (cubit
                                    .passengerNewCarpoolStepThreeSelectedDaysOfWeek
                                    .length <=
                                2) {
                              customSnackBar(
                                  context: context,
                                  text:
                                      'دورات كاربول تعمل في حالة أكثر من يومين !',
                                  color: ColorsManager.red);
                            } else if (cubit
                                    .passengerNewCarpoolStepThreeIAgreeWithRoles ==
                                false) {
                              customSnackBar(
                                  context: context,
                                  text: 'قم بإقرار الوارد',
                                  color: ColorsManager.red);
                            }
                          },
                        ),
                ],
              ),
              SizedBox(
                height: 20.00.h,
              ),
              buildStepContent(),
            ],
          ),
        ),
      ),
    );
  }
}
