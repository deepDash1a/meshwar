import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meshwar/business_logic/layout/cubit/cubit.dart';
import 'package:meshwar/core/shared/functions/functions.dart';
import 'package:meshwar/core/shared/widgets/button.dart';
import 'package:meshwar/core/shared/widgets/custom_drop_down.dart';
import 'package:meshwar/core/shared/widgets/custom_text_button.dart';
import 'package:meshwar/core/shared/widgets/custom_text_form_field.dart';
import 'package:meshwar/core/shared/widgets/texts.dart';
import 'package:meshwar/core/theme/colors/colors.dart';
import 'package:meshwar/core/theme/images/images.dart';

class ShiftScreen extends StatelessWidget {
  const ShiftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<LayoutAppCubit>();
    var formKey = GlobalKey<FormState>();
    return SafeArea(
      child: BlocConsumer<LayoutAppCubit, LayoutAppStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Center(
                        child: ExtraBoldText20dark(
                            text: 'مرحبًا، قم ببداية وردية جديدة')),
                    SizedBox(height: 20.00.h),
                    // choose type of car
                    // cubit.getAllCars == null
                    //     ? const Center(
                    //         child: CircularProgressIndicator(),
                    //       )
                    //     : CustomDropDownButton<int>(
                    //         hint: const BoldText16dark(
                    //           text: 'اختر السيارة',
                    //         ),
                    //         value: cubit.selectedCarTypeValue,
                    //         items: cubit.getAllCars?.body?.map((e) {
                    //           return DropdownMenuItem<int>(
                    //             value: e.carTypeId,
                    //             child: RegularText16dark(
                    //               text: e.carType.toString(),
                    //             ),
                    //           );
                    //         }).toList(),
                    //         validatorText: 'من فضلك اختر السيارة',
                    //         onChanged: (value) {
                    //           cubit.selectedCarTypeValue = value;
                    //           if (kDebugMode) {
                    //             print(cubit.selectedCarTypeValue);
                    //           }
                    //         },
                    //       ),
                    CustomDropDownButton<int>(
                      hint: const BoldText16dark(
                        text: 'اختر السيارة',
                      ),
                      value: cubit.selectedCarTypeValue,
                      items: const [
                        DropdownMenuItem(
                          value: 1,
                          child: BoldText16dark(text: 'BMW'),
                        ),
                        DropdownMenuItem(
                          value: 2,
                          child: BoldText16dark(text: 'RENO'),
                        ),
                        DropdownMenuItem(
                          value: 3,
                          child: BoldText16dark(text: 'MG'),
                        ),
                        DropdownMenuItem(
                          value: 4,
                          child: BoldText16dark(text: 'PYD'),
                        ),
                      ],
                      validatorText: 'من فضلك اختر السيارة',
                      onChanged: (value) {
                        cubit.selectedCarTypeValue = value;
                        if (kDebugMode) {
                          print(cubit.selectedCarTypeValue);
                        }
                      },
                    ),
                    SizedBox(height: 20.00.h),
                    CustomTextButton(
                      text: 'أضِف صورة العداد',
                      function: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                                content: Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                    onPressed: () async {
                                      cubit.odometerImage = await cubit
                                          .pickImage(ImageSource.camera);
                                      if (context.mounted) {
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    child: Image.asset(ImagesManager.camera),
                                  ),
                                ),
                                Expanded(
                                  child: TextButton(
                                    onPressed: () async {
                                      cubit.odometerImage = await cubit
                                          .pickImage(ImageSource.gallery);
                                      if (context.mounted) {
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    child: Image.asset(ImagesManager.gallery),
                                  ),
                                ),
                              ],
                            ));
                          },
                        );
                      },
                    ),
                    cubit.odometerImage == null
                        ? Column(
                            children: [
                              SizedBox(height: 50.00.h),
                              const Center(
                                  child: BoldText14dark(
                                      text: 'لا توجد صور للعداد')),
                            ],
                          )
                        : Container(
                            width: double.infinity.w,
                            height: 300.00.h,
                            margin: EdgeInsets.symmetric(
                                vertical: 5.00.h, horizontal: 5.00.w),
                            decoration: BoxDecoration(
                              color: ColorsManager.mainAppColor,
                              borderRadius: BorderRadius.circular(10.00.r),
                              boxShadow: [
                                BoxShadow(
                                  color:
                                      ColorsManager.deepOrange.withOpacity(0.4),
                                  blurRadius: 10.00.r,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                              image: DecorationImage(
                                image: FileImage(
                                  File(
                                    cubit.odometerImage!.path,
                                  ),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                    SizedBox(height: 20.00.h),
                    CustomTextFormField(
                      controller: cubit.carOdometerStart,
                      label: 'أكتب بداية العداد',
                      validatorText: 'من فضلك اكتب بداية العداد',
                      appRegex: r'^[0-9]+$',
                      textInputType: TextInputType.number,
                    ),
                    SizedBox(height: 30.00.h),
                    Center(
                      child: CustomButton(
                        text: 'بداية',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            if (cubit.odometerImage == null) {
                              customSnackBar(
                                  context: context,
                                  text: 'من فضلك أدرج صورة العداد',
                                  color: ColorsManager.red);
                            } else {
                              cubit.startShift();
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(height: 50.00.h),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
