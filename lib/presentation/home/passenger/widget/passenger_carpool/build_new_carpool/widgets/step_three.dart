import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meshwar/business_logic/carpool_cubit/carpool_cubit.dart';
import 'package:meshwar/core/shared/widgets/custom_drop_down.dart';
import 'package:meshwar/core/shared/widgets/custom_text.dart';
import 'package:meshwar/core/shared/widgets/custom_text_form_field.dart';
import 'package:meshwar/core/theme/images/images.dart';

class BuildPassengerDetailsCarpoolStepThree extends StatefulWidget {
  const BuildPassengerDetailsCarpoolStepThree({super.key});

  @override
  State<BuildPassengerDetailsCarpoolStepThree> createState() =>
      _BuildPassengerDetailsCarpoolStepThreeState();
}

class _BuildPassengerDetailsCarpoolStepThreeState
    extends State<BuildPassengerDetailsCarpoolStepThree> {
  @override
  Widget build(BuildContext context) {
    var cubit = context.read<CarpoolCubit>();
    return BlocConsumer<CarpoolCubit, CarpoolState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Form(
          key: cubit.passengerNewCarpoolStepThreeFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CustomText(text: 'اختر أيام الأسبوع'),
                  SizedBox(height: 20.00.h),
                  SizedBox(
                    height: 70.0,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: cubit.daysOfWeek.entries.map((entry) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              CustomText(
                                text: entry.key,
                                textAlign: TextAlign.center,
                              ),
                              Checkbox(
                                value: entry.value,
                                onChanged: (bool? value) {
                                  cubit.updateDaySelection(
                                      entry.key, value ?? false);
                                },
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.00.h),
              const CustomText(text: 'مقدار الزمن الزائد المقبول لك'),
              Row(
                children: [
                  Expanded(
                    child: Slider(
                      min: 00.00,
                      max: 20.00,
                      value:
                          cubit.passengerNewCarpoolStepThreeAmountOfExtraTime,
                      onChanged: (value) {
                        setState(() {
                          cubit.passengerNewCarpoolStepThreeAmountOfExtraTime =
                              value;
                        });
                      },
                    ),
                  ),
                  CustomText(
                    text: cubit.passengerNewCarpoolStepThreeAmountOfExtraTime
                        .toStringAsFixed(1),
                  ),
                  const CustomText(
                    text: 'دقيقة ',
                  ),
                ],
              ),
              SizedBox(height: 20.00.h),
              const CustomText(text: 'مقدار المسافة الزائدة المقبولة لك'),
              Row(
                children: [
                  Expanded(
                    child: Slider(
                      min: 00.00,
                      max: 5.00,
                      value: cubit
                          .passengerNewCarpoolStepThreeAmountOfExtraDistance,
                      onChanged: (value) {
                        setState(() {
                          cubit.passengerNewCarpoolStepThreeAmountOfExtraDistance =
                              value;
                        });
                      },
                    ),
                  ),
                  CustomText(
                    text: cubit
                        .passengerNewCarpoolStepThreeAmountOfExtraDistance
                        .toStringAsFixed(1),
                  ),
                  const CustomText(
                    text: 'كـم ',
                  ),
                ],
              ),
              SizedBox(height: 20.00.h),
              const CustomText(text: 'مقدار المشي الزائد المقبول لك'),
              Row(
                children: [
                  Expanded(
                    child: Slider(
                      min: 00.00,
                      max: 500.00,
                      value: cubit
                          .passengerNewCarpoolStepThreeAmountOfExtraWalking,
                      onChanged: (value) {
                        setState(() {
                          cubit.passengerNewCarpoolStepThreeAmountOfExtraWalking =
                              value;
                        });
                      },
                    ),
                  ),
                  CustomText(
                    text: cubit.passengerNewCarpoolStepThreeAmountOfExtraWalking
                        .toStringAsFixed(1),
                  ),
                  const CustomText(
                    text: 'متر ',
                  ),
                ],
              ),
              SizedBox(height: 20.00.h),
              const CustomText(text: 'أيهما أفضل بالنسبة لك ؟'),
              SizedBox(height: 10.00.h),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Radio(
                            value: 'before',
                            groupValue: cubit
                                .passengerNewCarpoolStepThreeWantIncreasingWhen,
                            onChanged: (value) {
                              setState(() {
                                cubit.passengerNewCarpoolStepThreeWantIncreasingWhen =
                                    value;
                              });
                            }),
                        const CustomText(text: 'الإلتزام بموعد البدء')
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Radio(
                            value: 'after',
                            groupValue: cubit
                                .passengerNewCarpoolStepThreeWantIncreasingWhen,
                            onChanged: (value) {
                              setState(() {
                                cubit.passengerNewCarpoolStepThreeWantIncreasingWhen =
                                    value;
                              });
                            }),
                        const CustomText(text: 'الإلتزام بموعد الوصول')
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.00.h),
              CustomDropDownButton(
                hint: const CustomText(
                  text: 'اختر عدد المقاعد',
                ),
                value: cubit.passengerNewCarpoolStepThreeSeatNumberValue,
                items: cubit.passengerNewCarpoolStepThreeSeatNumberList,
                validatorText: 'من فضلك اختر عدد المقاعد',
                onChanged: (value) {
                  setState(() {
                    cubit.passengerNewCarpoolStepThreeSeatNumberValue = value!;
                  });
                },
              ),
              SizedBox(height: 20.00.h),
              cubit.passengerNewCarpoolStepThreeSeatNumberValue == 1
                  ? const SizedBox()
                  : cubit.passengerNewCarpoolStepThreeSeatNumberValue == 2
                      ? Column(
                          children: [
                            const CustomText(
                                text: 'أدخل بيانات المرافق الثاني'),
                            SizedBox(height: 20.00.h),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomTextFormField(
                                    hintText: 'الاسم الأول',
                                    prefixIcon: SvgPicture.asset(
                                      ImagesManager.person,
                                      height: 10.00.h,
                                    ),
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'من فضلك هذا الحقل مطلوب';
                                      }
                                      return null;
                                    },
                                    controller: cubit
                                        .passengerNewCarpoolStepThreeFirstNameOfSecondCompanionController,
                                    inputType: TextInputType.name,
                                  ),
                                ),
                                SizedBox(width: 10.00.w),
                                Expanded(
                                  child: CustomTextFormField(
                                    hintText: 'الاسم الأخير',
                                    prefixIcon: SvgPicture.asset(
                                      ImagesManager.person,
                                      height: 10.00.h,
                                    ),
                                    validator: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'من فضلك هذا الحقل مطلوب';
                                      }
                                      return null;
                                    },
                                    controller: cubit
                                        .passengerNewCarpoolStepThreeLastNameOfSecondCompanionController,
                                    inputType: TextInputType.name,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.00.h),
                            CustomTextFormField(
                              hintText: 'رقم الهاتف',
                              prefixIcon: SvgPicture.asset(
                                ImagesManager.phone,
                                height: 10.00.h,
                              ),
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'من فضلك هذا الحقل مطلوب';
                                } else if (cubit.egyptPhoneRegExp
                                    .hasMatch(value)) {
                                  return 'من فضلك أدخل رقمًا صحيحًا';
                                }
                                return null;
                              },
                              controller: cubit
                                  .passengerNewCarpoolStepThreePhoneOfSecondCompanionController,
                              inputType: TextInputType.name,
                            ),
                            SizedBox(height: 20.00.h),
                            CustomTextFormField(
                              hintText: 'البريد الإلكتروني',
                              prefixIcon: SvgPicture.asset(
                                ImagesManager.mail,
                                height: 10.00.h,
                              ),
                              validator: (String? value) {
                                if (value!.isEmpty) {
                                  return 'من فضلك هذا الحقل مطلوب';
                                } else if (cubit.emailRegex.hasMatch(value)) {
                                  return 'من فضلك أدخل بريدًا صحيحًا';
                                }
                                return null;
                              },
                              controller: cubit
                                  .passengerNewCarpoolStepThreeEmailOfSecondCompanionController,
                              inputType: TextInputType.name,
                            ),
                          ],
                        )
                      : cubit.passengerNewCarpoolStepThreeSeatNumberValue == 3
                          ? Column(
                              children: [
                                const CustomText(
                                    text: 'أدخل بيانات المرافق الثاني'),
                                SizedBox(height: 20.00.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextFormField(
                                        hintText: 'الاسم الأول',
                                        prefixIcon: SvgPicture.asset(
                                          ImagesManager.person,
                                          height: 10.00.h,
                                        ),
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'من فضلك هذا الحقل مطلوب';
                                          }
                                          return null;
                                        },
                                        controller: cubit
                                            .passengerNewCarpoolStepThreeFirstNameOfSecondCompanionController,
                                        inputType: TextInputType.name,
                                      ),
                                    ),
                                    SizedBox(width: 10.00.w),
                                    Expanded(
                                      child: CustomTextFormField(
                                        hintText: 'الاسم الأخير',
                                        prefixIcon: SvgPicture.asset(
                                          ImagesManager.person,
                                          height: 10.00.h,
                                        ),
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'من فضلك هذا الحقل مطلوب';
                                          }
                                          return null;
                                        },
                                        controller: cubit
                                            .passengerNewCarpoolStepThreeLastNameOfSecondCompanionController,
                                        inputType: TextInputType.name,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.00.h),
                                CustomTextFormField(
                                  hintText: 'رقم الهاتف',
                                  prefixIcon: SvgPicture.asset(
                                    ImagesManager.phone,
                                    height: 10.00.h,
                                  ),
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'من فضلك هذا الحقل مطلوب';
                                    } else if (cubit.egyptPhoneRegExp
                                        .hasMatch(value)) {
                                      return 'من فضلك أدخل رقمًا صحيحًا';
                                    }
                                    return null;
                                  },
                                  controller: cubit
                                      .passengerNewCarpoolStepThreePhoneOfSecondCompanionController,
                                  inputType: TextInputType.name,
                                ),
                                SizedBox(height: 20.00.h),
                                CustomTextFormField(
                                  hintText: 'البريد الإلكتروني',
                                  prefixIcon: SvgPicture.asset(
                                    ImagesManager.mail,
                                    height: 10.00.h,
                                  ),
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'من فضلك هذا الحقل مطلوب';
                                    } else if (cubit.emailRegex
                                        .hasMatch(value)) {
                                      return 'من فضلك أدخل بريدًا صحيحًا';
                                    }
                                    return null;
                                  },
                                  controller: cubit
                                      .passengerNewCarpoolStepThreeEmailOfSecondCompanionController,
                                  inputType: TextInputType.name,
                                ),
                                SizedBox(height: 20.00.h),
                                const CustomText(
                                    text: 'أدخل بيانات المرافق الثالث'),
                                SizedBox(height: 20.00.h),
                                Row(
                                  children: [
                                    Expanded(
                                      child: CustomTextFormField(
                                        hintText: 'الاسم الأول',
                                        prefixIcon: SvgPicture.asset(
                                          ImagesManager.person,
                                          height: 10.00.h,
                                        ),
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'من فضلك هذا الحقل مطلوب';
                                          }
                                          return null;
                                        },
                                        controller: cubit
                                            .passengerNewCarpoolStepThreeFirstNameOfThirdCompanionController,
                                        inputType: TextInputType.name,
                                      ),
                                    ),
                                    SizedBox(width: 10.00.w),
                                    Expanded(
                                      child: CustomTextFormField(
                                        hintText: 'الاسم الأخير',
                                        prefixIcon: SvgPicture.asset(
                                          ImagesManager.person,
                                          height: 10.00.h,
                                        ),
                                        validator: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'من فضلك هذا الحقل مطلوب';
                                          }
                                          return null;
                                        },
                                        controller: cubit
                                            .passengerNewCarpoolStepThreeLastNameOfThirdCompanionController,
                                        inputType: TextInputType.name,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.00.h),
                                CustomTextFormField(
                                  hintText: 'رقم الهاتف',
                                  prefixIcon: SvgPicture.asset(
                                    ImagesManager.phone,
                                    height: 10.00.h,
                                  ),
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'من فضلك هذا الحقل مطلوب';
                                    } else if (cubit.egyptPhoneRegExp
                                        .hasMatch(value)) {
                                      return 'من فضلك أدخل رقمًا صحيحًا';
                                    }
                                    return null;
                                  },
                                  controller: cubit
                                      .passengerNewCarpoolStepThreePhoneOfThirdCompanionController,
                                  inputType: TextInputType.name,
                                ),
                                SizedBox(height: 20.00.h),
                                CustomTextFormField(
                                  hintText: 'البريد الإلكتروني',
                                  prefixIcon: SvgPicture.asset(
                                    ImagesManager.mail,
                                    height: 10.00.h,
                                  ),
                                  validator: (String? value) {
                                    if (value!.isEmpty) {
                                      return 'من فضلك هذا الحقل مطلوب';
                                    } else if (cubit.emailRegex
                                        .hasMatch(value)) {
                                      return 'من فضلك أدخل بريدًا صحيحًا';
                                    }
                                    return null;
                                  },
                                  controller: cubit
                                      .passengerNewCarpoolStepThreeEmailOfThirdCompanionController,
                                  inputType: TextInputType.name,
                                ),
                              ],
                            )
                          : cubit.passengerNewCarpoolStepThreeSeatNumberValue ==
                                  4
                              ? Column(
                                  children: [
                                    const CustomText(
                                        text: 'أدخل بيانات المرافق الثاني'),
                                    SizedBox(height: 20.00.h),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CustomTextFormField(
                                            hintText: 'الاسم الأول',
                                            prefixIcon: SvgPicture.asset(
                                              ImagesManager.person,
                                              height: 10.00.h,
                                            ),
                                            validator: (String? value) {
                                              if (value!.isEmpty) {
                                                return 'من فضلك هذا الحقل مطلوب';
                                              }
                                              return null;
                                            },
                                            controller: cubit
                                                .passengerNewCarpoolStepThreeFirstNameOfSecondCompanionController,
                                            inputType: TextInputType.name,
                                          ),
                                        ),
                                        SizedBox(width: 10.00.w),
                                        Expanded(
                                          child: CustomTextFormField(
                                            hintText: 'الاسم الأخير',
                                            prefixIcon: SvgPicture.asset(
                                              ImagesManager.person,
                                              height: 10.00.h,
                                            ),
                                            validator: (String? value) {
                                              if (value!.isEmpty) {
                                                return 'من فضلك هذا الحقل مطلوب';
                                              }
                                              return null;
                                            },
                                            controller: cubit
                                                .passengerNewCarpoolStepThreeLastNameOfSecondCompanionController,
                                            inputType: TextInputType.name,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20.00.h),
                                    CustomTextFormField(
                                      hintText: 'رقم الهاتف',
                                      prefixIcon: SvgPicture.asset(
                                        ImagesManager.phone,
                                        height: 10.00.h,
                                      ),
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'من فضلك هذا الحقل مطلوب';
                                        } else if (cubit.egyptPhoneRegExp
                                            .hasMatch(value)) {
                                          return 'من فضلك أدخل رقمًا صحيحًا';
                                        }
                                        return null;
                                      },
                                      controller: cubit
                                          .passengerNewCarpoolStepThreePhoneOfSecondCompanionController,
                                      inputType: TextInputType.name,
                                    ),
                                    SizedBox(height: 20.00.h),
                                    CustomTextFormField(
                                      hintText: 'البريد الإلكتروني',
                                      prefixIcon: SvgPicture.asset(
                                        ImagesManager.mail,
                                        height: 10.00.h,
                                      ),
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'من فضلك هذا الحقل مطلوب';
                                        } else if (cubit.emailRegex
                                            .hasMatch(value)) {
                                          return 'من فضلك أدخل بريدًا صحيحًا';
                                        }
                                        return null;
                                      },
                                      controller: cubit
                                          .passengerNewCarpoolStepThreeEmailOfSecondCompanionController,
                                      inputType: TextInputType.name,
                                    ),
                                    SizedBox(height: 20.00.h),
                                    const CustomText(
                                        text: 'أدخل بيانات المرافق الثالث'),
                                    SizedBox(height: 20.00.h),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CustomTextFormField(
                                            hintText: 'الاسم الأول',
                                            prefixIcon: SvgPicture.asset(
                                              ImagesManager.person,
                                              height: 10.00.h,
                                            ),
                                            validator: (String? value) {
                                              if (value!.isEmpty) {
                                                return 'من فضلك هذا الحقل مطلوب';
                                              }
                                              return null;
                                            },
                                            controller: cubit
                                                .passengerNewCarpoolStepThreeFirstNameOfThirdCompanionController,
                                            inputType: TextInputType.name,
                                          ),
                                        ),
                                        SizedBox(width: 10.00.w),
                                        Expanded(
                                          child: CustomTextFormField(
                                            hintText: 'الاسم الأخير',
                                            prefixIcon: SvgPicture.asset(
                                              ImagesManager.person,
                                              height: 10.00.h,
                                            ),
                                            validator: (String? value) {
                                              if (value!.isEmpty) {
                                                return 'من فضلك هذا الحقل مطلوب';
                                              }
                                              return null;
                                            },
                                            controller: cubit
                                                .passengerNewCarpoolStepThreeLastNameOfThirdCompanionController,
                                            inputType: TextInputType.name,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20.00.h),
                                    CustomTextFormField(
                                      hintText: 'رقم الهاتف',
                                      prefixIcon: SvgPicture.asset(
                                        ImagesManager.phone,
                                        height: 10.00.h,
                                      ),
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'من فضلك هذا الحقل مطلوب';
                                        } else if (cubit.egyptPhoneRegExp
                                            .hasMatch(value)) {
                                          return 'من فضلك أدخل رقمًا صحيحًا';
                                        }
                                        return null;
                                      },
                                      controller: cubit
                                          .passengerNewCarpoolStepThreePhoneOfThirdCompanionController,
                                      inputType: TextInputType.name,
                                    ),
                                    SizedBox(height: 20.00.h),
                                    CustomTextFormField(
                                      hintText: 'البريد الإلكتروني',
                                      prefixIcon: SvgPicture.asset(
                                        ImagesManager.mail,
                                        height: 10.00.h,
                                      ),
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'من فضلك هذا الحقل مطلوب';
                                        } else if (cubit.emailRegex
                                            .hasMatch(value)) {
                                          return 'من فضلك أدخل بريدًا صحيحًا';
                                        }
                                        return null;
                                      },
                                      controller: cubit
                                          .passengerNewCarpoolStepThreeEmailOfThirdCompanionController,
                                      inputType: TextInputType.name,
                                    ),
                                    SizedBox(height: 20.00.h),
                                    const CustomText(
                                        text: 'أدخل بيانات المرافق الرابع'),
                                    SizedBox(height: 20.00.h),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: CustomTextFormField(
                                            hintText: 'الاسم الأول',
                                            prefixIcon: SvgPicture.asset(
                                              ImagesManager.person,
                                              height: 10.00.h,
                                            ),
                                            validator: (String? value) {
                                              if (value!.isEmpty) {
                                                return 'من فضلك هذا الحقل مطلوب';
                                              }
                                              return null;
                                            },
                                            controller: cubit
                                                .passengerNewCarpoolStepThreeFirstNameOfFourthCompanionController,
                                            inputType: TextInputType.name,
                                          ),
                                        ),
                                        SizedBox(width: 10.00.w),
                                        Expanded(
                                          child: CustomTextFormField(
                                            hintText: 'الاسم الأخير',
                                            prefixIcon: SvgPicture.asset(
                                              ImagesManager.person,
                                              height: 10.00.h,
                                            ),
                                            validator: (String? value) {
                                              if (value!.isEmpty) {
                                                return 'من فضلك هذا الحقل مطلوب';
                                              }
                                              return null;
                                            },
                                            controller: cubit
                                                .passengerNewCarpoolStepThreeLastNameOfFourthCompanionController,
                                            inputType: TextInputType.name,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20.00.h),
                                    CustomTextFormField(
                                      hintText: 'رقم الهاتف',
                                      prefixIcon: SvgPicture.asset(
                                        ImagesManager.phone,
                                        height: 10.00.h,
                                      ),
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'من فضلك هذا الحقل مطلوب';
                                        } else if (cubit.egyptPhoneRegExp
                                            .hasMatch(value)) {
                                          return 'من فضلك أدخل رقمًا صحيحًا';
                                        }
                                        return null;
                                      },
                                      controller: cubit
                                          .passengerNewCarpoolStepThreePhoneOfFourthCompanionController,
                                      inputType: TextInputType.name,
                                    ),
                                    SizedBox(height: 20.00.h),
                                    CustomTextFormField(
                                      hintText: 'البريد الإلكتروني',
                                      prefixIcon: SvgPicture.asset(
                                        ImagesManager.mail,
                                        height: 10.00.h,
                                      ),
                                      validator: (String? value) {
                                        if (value!.isEmpty) {
                                          return 'من فضلك هذا الحقل مطلوب';
                                        } else if (cubit.emailRegex
                                            .hasMatch(value)) {
                                          return 'من فضلك أدخل بريدًا صحيحًا';
                                        }
                                        return null;
                                      },
                                      controller: cubit
                                          .passengerNewCarpoolStepThreeEmailOfFourthCompanionController,
                                      inputType: TextInputType.name,
                                    ),
                                  ],
                                )
                              : const SizedBox(),
              SizedBox(height: 20.00.h),
              Row(
                children: [
                  Checkbox(
                    value: cubit.passengerNewCarpoolStepThreeIAgreeWithRoles,
                    onChanged: (bool? value) {
                      cubit.changeVisibilityTrueOrFalse(
                          currentVisibility:
                              cubit.passengerNewCarpoolStepThreeIAgreeWithRoles,
                          updateVisibility: (vale) {
                            cubit.passengerNewCarpoolStepThreeIAgreeWithRoles =
                                vale;
                          });
                    },
                  ),
                  const Expanded(
                    child: CustomText(
                        textAlign: TextAlign.end,
                        text:
                            'أقر بأني ملتزم بالمواعيد والأماكن المقررة من وقت الإتفاق ولمدة أسبوع تجدد أسبوعيًا في حالة عدم إيقاف الدورة من خلال أحد الطرفين'),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
