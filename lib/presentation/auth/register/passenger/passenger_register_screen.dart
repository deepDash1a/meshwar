import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meshwar/business_logic/auth_cubit/auth_cubit.dart';
import 'package:meshwar/core/shared/functions/functions.dart';
import 'package:meshwar/core/shared/widgets/custom_button.dart';
import 'package:meshwar/core/shared/widgets/custom_text.dart';
import 'package:meshwar/core/shared/widgets/custom_text_form_field.dart';
import 'package:meshwar/core/theme/colors/colors.dart';
import 'package:meshwar/core/theme/images/images.dart';

// ignore: must_be_immutable
class PassengerRegisterScreen extends StatelessWidget {
  const PassengerRegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();

    Widget buildPassengerRegistrationStepOne() {
      return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Form(
            key: cubit.passengerRegisterStepOneFormKey,
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 70.00.r,
                      backgroundColor: ColorsManager.grey,
                      backgroundImage: cubit.profileImage != null
                          ? FileImage(File(cubit.profileImage!.path))
                          : null,
                      child: cubit.profileImage == null
                          ? Center(
                              child: CustomText(
                                text: 'لا توجد صورة',
                                fontSize: 10.00.sp,
                              ),
                            )
                          : null, // No text if image exists
                    ),
                    Positioned(
                      bottom: 10.00.h,
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const CustomText(
                                text: 'أضِف صورة شخصية',
                                textAlign: TextAlign.center,
                              ),
                              content: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: IconButton(
                                      onPressed: () {
                                        ImagePicker()
                                            .pickImage(
                                          source: ImageSource.camera,
                                          imageQuality: 50,
                                        )
                                            .then((value) {
                                          cubit.profileImage =
                                              cubit.pickImageFromDevice(
                                                  cubit.profileImage, value!);
                                        });
                                        Navigator.pop(context);
                                      },
                                      icon: SvgPicture.asset(
                                        ImagesManager.camera,
                                        height: 30.h,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: IconButton(
                                      onPressed: () {
                                        ImagePicker()
                                            .pickImage(
                                          source: ImageSource.gallery,
                                          imageQuality: 50,
                                        )
                                            .then((value) {
                                          cubit.profileImage =
                                              cubit.pickImageFromDevice(
                                                  cubit.profileImage, value!);
                                        });
                                        Navigator.pop(context);
                                      },
                                      icon: SvgPicture.asset(
                                        ImagesManager.gallery,
                                        height: 30.h,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: ColorsManager.white.withOpacity(0.5),
                          radius: 20.00.r,
                          child: SvgPicture.asset(
                            ImagesManager.image,
                            height: 30.h,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
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
                        controller: cubit.passengerRegisterFirstNameController,
                        inputType: TextInputType.text,
                      ),
                    ),
                    SizedBox(width: 20.00.w),
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
                        controller: cubit.passengerRegisterLastNameController,
                        inputType: TextInputType.text,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.00.h),
                CustomTextFormField(
                  hintText: 'البريد الإلكتروني',
                  prefixIcon:
                      SvgPicture.asset(ImagesManager.mail, height: 10.00.w),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'من فضلك هذا الحقل مطلوب';
                    } else if (!cubit.emailRegex.hasMatch(value)) {
                      return 'من فضلك أدخل عنوانًا صحيحًا';
                    }
                    return null;
                  },
                  controller: cubit.passengerRegisterEmailController,
                  inputType: TextInputType.emailAddress,
                ),
                SizedBox(height: 20.00.h),
                CustomTextFormField(
                  hintText: 'كلمة المرور',
                  prefixIcon: SvgPicture.asset(
                    ImagesManager.lock,
                    height: 10.00.w,
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'من فضلك هذا الحقل مطلوب';
                    } else if (!cubit.passwordRegex.hasMatch(value)) {
                      return 'يجب ان تحتوي على أحرف وألا تقل عن 8 خانات';
                    }
                    return null;
                  },
                  obscureText: cubit.passengerRegisterPasswordObSecure,
                  suffixIcon: IconButton(
                    onPressed: () {
                      cubit.changeVisibilityTrueOrFalse(
                        currentVisibility:
                            cubit.passengerRegisterPasswordObSecure,
                        updateVisibility: (value) {
                          cubit.passengerRegisterPasswordObSecure = value;
                        },
                      );
                    },
                    icon: SvgPicture.asset(
                      cubit.passengerRegisterPasswordObSecure == true
                          ? ImagesManager.visible
                          : ImagesManager.invisible,
                      height: 30.00.h,
                    ),
                  ),
                  controller: cubit.passengerRegisterPasswordController,
                  inputType: TextInputType.visiblePassword,
                ),
                SizedBox(height: 20.00.h),
                CustomTextFormField(
                  hintText: 'تأكيد كلمة المرور',
                  prefixIcon: SvgPicture.asset(
                    ImagesManager.lock,
                    height: 10.00.w,
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'من فضلك هذا الحقل مطلوب';
                    } else if (!cubit.passwordRegex.hasMatch(value)) {
                      return 'يجب ان تحتوي على أحرف وألا تقل عن 8 خانات';
                    }
                    return null;
                  },
                  obscureText: cubit.passengerRegisterConfirmPasswordObSecure,
                  suffixIcon: IconButton(
                    onPressed: () {
                      cubit.changeVisibilityTrueOrFalse(
                        currentVisibility:
                            cubit.passengerRegisterConfirmPasswordObSecure,
                        updateVisibility: (value) {
                          cubit.passengerRegisterConfirmPasswordObSecure =
                              value;
                        },
                      );
                    },
                    icon: SvgPicture.asset(
                      cubit.passengerRegisterConfirmPasswordObSecure == true
                          ? ImagesManager.visible
                          : ImagesManager.invisible,
                      height: 30.00.h,
                    ),
                  ),
                  controller: cubit.passengerRegisterConfirmPasswordController,
                  inputType: TextInputType.visiblePassword,
                ),
                SizedBox(height: 20.00.h),
                CustomTextFormField(
                  hintText: 'رقم هاتف',
                  prefixIcon: SvgPicture.asset(
                    ImagesManager.phone,
                    height: 10.00.h,
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'من فضلك هذا الحقل مطلوب';
                    } else if (!cubit.egyptPhoneRegExp.hasMatch(value)) {
                      return 'من فضلك أدخل رقمًا صحيحًا';
                    }
                    return null;
                  },
                  controller: cubit.passengerRegisterPhoneNumberController,
                  inputType: TextInputType.phone,
                ),
                SizedBox(height: 20.00.h),
                CustomTextFormField(
                  hintText: 'رقم واتساب',
                  prefixIcon: SvgPicture.asset(
                    ImagesManager.phone,
                    height: 10.00.h,
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'من فضلك هذا الحقل مطلوب';
                    } else if (!cubit.egyptPhoneRegExp.hasMatch(value)) {
                      return 'من فضلك أدخل رقمًا صحيحًا';
                    }
                    return null;
                  },
                  controller: cubit.passengerRegisterWhatsAppNumberController,
                  inputType: TextInputType.phone,
                ),
              ],
            ),
          );
        },
      );
    }

    Widget buildPassengerRegistrationStepTwo() {
      return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Form(
            key: cubit.passengerRegisterStepTwoFormKey,
            child: Column(
              children: [
                CustomTextFormField(
                  hintText: 'المحافظة',
                  prefixIcon: SvgPicture.asset(
                    ImagesManager.governorate,
                    height: 10.00.h,
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'من فضلك هذا الحقل مطلوب';
                    }
                    return null;
                  },
                  controller: cubit.passengerRegisterGovernorateController,
                  inputType: TextInputType.text,
                ),
                SizedBox(height: 20.00.h),
                CustomTextFormField(
                  hintText: 'المنطقة السكنية',
                  prefixIcon: SvgPicture.asset(
                    ImagesManager.residentialArea,
                    height: 10.00.h,
                  ),
                  controller: cubit.passengerRegisterResidentialAreaController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'من فضلك هذا الحقل مطلوب';
                    }
                    return null;
                  },
                  inputType: TextInputType.text,
                ),
                SizedBox(height: 20.00.h),
                CustomTextFormField(
                  hintText: 'الحي',
                  prefixIcon: SvgPicture.asset(
                    ImagesManager.neighborhood,
                    height: 10.00.h,
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'من فضلك هذا الحقل مطلوب';
                    }
                    return null;
                  },
                  controller: cubit.passengerRegisterNeighborhoodController,
                  inputType: TextInputType.text,
                ),
                SizedBox(height: 20.00.h),
                CustomTextFormField(
                  hintText: 'الشارع',
                  prefixIcon: SvgPicture.asset(
                    ImagesManager.street,
                    height: 10.00.h,
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'من فضلك هذا الحقل مطلوب';
                    }
                    return null;
                  },
                  controller: cubit.passengerRegisterStreetController,
                  inputType: TextInputType.text,
                ),
                SizedBox(height: 20.00.h),
                CustomTextFormField(
                  hintText: 'العمارة',
                  prefixIcon: SvgPicture.asset(
                    ImagesManager.building,
                    height: 10.00.h,
                  ),
                  controller: cubit.passengerRegisterBuildingController,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'من فضلك هذا الحقل مطلوب';
                    }
                    return null;
                  },
                  inputType: TextInputType.text,
                ),
                SizedBox(height: 20.00.h),
                CustomTextFormField(
                  hintText: 'علامة مميزة',
                  prefixIcon: SvgPicture.asset(
                    ImagesManager.distinctiveMark,
                    height: 10.00.h,
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'من فضلك هذا الحقل مطلوب';
                    }
                    return null;
                  },
                  controller: cubit.passengerRegisterDistinctiveMarkController,
                  inputType: TextInputType.text,
                ),
              ],
            ),
          );
        },
      );
    }

    Widget buildPassengerRegistrationStepThree() {
      return BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Form(
            key: cubit.passengerRegisterStepThreeFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CustomText(text: 'وجهة البطاقة الشخصية'),
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200.0.h,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        color: ColorsManager.grey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12.0.r),
                      ),
                      child: cubit.passengerRegisterIdCardFace != null
                          ? Image.file(
                              File(cubit.passengerRegisterIdCardFace!.path),
                              fit: BoxFit.cover,
                            )
                          : const Center(
                              child: CustomText(text: 'لا توجد صورة'),
                            ), // You can replace this with a placeholder if needed
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const CustomText(
                                text: 'أضِف وجه البطاقة الشخصية',
                                textAlign: TextAlign.center,
                              ),
                              content: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: IconButton(
                                      onPressed: () {
                                        ImagePicker()
                                            .pickImage(
                                          source: ImageSource.camera,
                                          imageQuality: 50,
                                        )
                                            .then((value) {
                                          cubit.passengerRegisterIdCardFace =
                                              cubit.pickImageFromDevice(
                                                  cubit
                                                      .passengerRegisterIdCardFace,
                                                  value!);
                                        });
                                        Navigator.pop(context);
                                      },
                                      icon: SvgPicture.asset(
                                        ImagesManager.camera,
                                        height: 30.h,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: IconButton(
                                      onPressed: () {
                                        ImagePicker()
                                            .pickImage(
                                          source: ImageSource.gallery,
                                          imageQuality: 50,
                                        )
                                            .then((value) {
                                          cubit.passengerRegisterIdCardFace =
                                              cubit.pickImageFromDevice(
                                                  cubit
                                                      .passengerRegisterIdCardFace,
                                                  value!);
                                        });
                                        Navigator.pop(context);
                                      },
                                      icon: SvgPicture.asset(
                                        ImagesManager.gallery,
                                        height: 30.h,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: ColorsManager.white.withOpacity(0.5),
                          radius: 20.00.r,
                          child: SvgPicture.asset(
                            ImagesManager.image,
                            height: 30.h,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20.00.h),
                const CustomText(text: 'خلفية البطاقة الشخصية'),
                Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 200.0.h,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        color: ColorsManager.grey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12.0.r),
                      ),
                      child: cubit.passengerRegisterIdCardBack != null
                          ? Image.file(
                              File(cubit.passengerRegisterIdCardBack!.path),
                              fit: BoxFit.cover,
                            )
                          : const Center(
                              child: CustomText(text: 'لا توجد صورة'),
                            ), // You can replace this with a placeholder if needed
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const CustomText(
                                text: 'أضِف خلفية البطاقة الشخصية',
                                textAlign: TextAlign.center,
                              ),
                              content: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Expanded(
                                    child: IconButton(
                                      onPressed: () {
                                        ImagePicker()
                                            .pickImage(
                                          source: ImageSource.camera,
                                          imageQuality: 50,
                                        )
                                            .then((value) {
                                          cubit.passengerRegisterIdCardBack =
                                              cubit.pickImageFromDevice(
                                                  cubit
                                                      .passengerRegisterIdCardBack,
                                                  value!);
                                        });
                                        Navigator.pop(context);
                                      },
                                      icon: SvgPicture.asset(
                                        ImagesManager.camera,
                                        height: 30.h,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: IconButton(
                                      onPressed: () {
                                        ImagePicker()
                                            .pickImage(
                                          source: ImageSource.gallery,
                                          imageQuality: 50,
                                        )
                                            .then((value) {
                                          cubit.passengerRegisterIdCardBack =
                                              cubit.pickImageFromDevice(
                                                  cubit
                                                      .passengerRegisterIdCardBack,
                                                  value!);
                                        });
                                        Navigator.pop(context);
                                      },
                                      icon: SvgPicture.asset(
                                        ImagesManager.gallery,
                                        height: 30.h,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: CircleAvatar(
                          backgroundColor: ColorsManager.white.withOpacity(0.5),
                          radius: 20.00.r,
                          child: SvgPicture.asset(
                            ImagesManager.image,
                            height: 30.h,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 20.00.h),
                CustomTextFormField(
                  hintText: 'تاريخ نهاية البطاقة الشخصية',
                  prefixIcon: SvgPicture.asset(
                    ImagesManager.date,
                    height: 10.h,
                  ),
                  controller: cubit.passengerRegisterIdCardExpireController,
                  inputType: TextInputType.text,
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return 'من فضلك هذا الحقل مطلوب';
                    }
                    return null;
                  },
                  readOnly: true,
                  onTap: () {
                    cubit.selectFutureDate(
                        context, cubit.passengerRegisterIdCardExpireController);
                  },
                ),
                SizedBox(height: 20.00.h),
                Row(
                  children: [
                    Checkbox(
                      value: cubit.passengerRegisterIsCorrectData,
                      onChanged: (value) {
                        cubit.changeVisibilityTrueOrFalse(
                          currentVisibility:
                              cubit.passengerRegisterIsCorrectData,
                          updateVisibility: (value) {
                            cubit.passengerRegisterIsCorrectData = value;
                          },
                        );
                      },
                    ),
                    Flexible(
                      child: CustomText(
                        fontSize: 12.00.sp,
                        text:
                            'أقر أن كل المعلومات المذكورة صحيحة وأنى مسؤول عنها',
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: cubit.passengerRegisterNoSmoking,
                      onChanged: (value) {
                        cubit.changeVisibilityTrueOrFalse(
                          currentVisibility: cubit.passengerRegisterNoSmoking,
                          updateVisibility: (value) {
                            cubit.passengerRegisterNoSmoking = value;
                          },
                        );
                      },
                    ),
                    Flexible(
                      child: CustomText(
                        fontSize: 12.00.sp,
                        text: 'أقر أنني لن أدخن أثناء الرحلة',
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: cubit.passengerRegisterPunctual,
                      onChanged: (value) {
                        cubit.changeVisibilityTrueOrFalse(
                          currentVisibility: cubit.passengerRegisterPunctual,
                          updateVisibility: (value) {
                            cubit.passengerRegisterPunctual = value;
                          },
                        );
                      },
                    ),
                    Flexible(
                      child: CustomText(
                        fontSize: 12.00.sp,
                        text:
                            'أقر أنني سأكون ملتزم بالمواعيد الخاصة بي من رحلات ودورات',
                      ),
                    )
                  ],
                ),
              ],
            ),
          );
        },
      );
    }

    Widget buildStepContent() {
      switch (cubit.passengerRegisterCurrentStep) {
        case 0:
          return buildPassengerRegistrationStepOne();
        case 1:
          return buildPassengerRegistrationStepTwo();
        case 2:
          return buildPassengerRegistrationStepThree();

        default:
          return const Center(
            child: CustomText(
              text: 'Unknown Step',
            ),
          );
      }
    }

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.00.w,
                vertical: 16.00.h,
              ),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      cubit.passengerRegisterCurrentStep == 0
                          ? CustomText(
                              text: 'مرحبًا بك في رحلتك مع التطبيق كـ راكب',
                              fontSize: 17.00.sp,
                              color: ColorsManager.darkOrange,
                            )
                          : const SizedBox(),
                      SizedBox(height: 20.00.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: CustomText(
                          color: ColorsManager.darkOrange,
                          text: cubit.passengerRegisterCurrentStep == 0
                              ? 'المرحلة الأولى، قم بإدخال بياناتك الشخصية'
                              : cubit.passengerRegisterCurrentStep == 1
                                  ? 'المرحلة الثانية، قم بإدخال موقعك'
                                  : 'المرحلة الأخيرة، قم بإدخال البيانات المطلوبة',
                        ),
                      ),
                      SizedBox(height: 20.00.h),
                      LinearProgressIndicator(
                        value: cubit.progressValue(),
                      ),
                      SizedBox(
                        height: 20.00.h,
                      ),
                      buildStepContent(),
                      SizedBox(height: 20.00.h),
                      Row(
                        children: [
                          cubit.passengerRegisterCurrentStep == 0
                              ? const SizedBox()
                              : CustomButton(
                                  text: 'الرجوع',
                                  onPressed: () {
                                    cubit.previousStep();
                                  },
                                ),
                          const Spacer(),
                          cubit.passengerRegisterCurrentStep == 2
                              ? state is LoadingPassengerRegistrationAppState
                                  ? const Center(
                                      child: CircularProgressIndicator(),
                                    )
                                  : CustomButton(
                                      text: 'تسجيل',
                                      onPressed: () {
                                        if (cubit
                                            .checkPassengerRegistrationValid()) {
                                          cubit.passengerRegister();
                                        } else if (cubit
                                                .passengerRegisterCurrentStep ==
                                            2) {
                                          if (cubit
                                                  .passengerRegisterIdCardFace ==
                                              null) {
                                            customSnackBar(
                                              context: context,
                                              text:
                                                  'من فضلك أضف وجه البطاقة الشخصية',
                                              color: ColorsManager.red,
                                            );
                                          } else if (cubit
                                                  .passengerRegisterIdCardBack ==
                                              null) {
                                            customSnackBar(
                                              context: context,
                                              text:
                                                  'من فضلك أضف خلفية البطاقة الشخصية',
                                              color: ColorsManager.red,
                                            );
                                          } else if (cubit
                                                      .passengerRegisterIsCorrectData ==
                                                  false ||
                                              cubit.passengerRegisterNoSmoking ==
                                                  false ||
                                              cubit.passengerRegisterPunctual ==
                                                  false) {
                                            customSnackBar(
                                              context: context,
                                              text:
                                                  'من فضلك قم بإقرار المذكور للحفاظ على سلامتك',
                                              color: ColorsManager.red,
                                            );
                                          }
                                        }
                                      },
                                    )
                              : CustomButton(
                                  text: 'التالي',
                                  onPressed: () {
                                    if (cubit
                                        .checkPassengerRegistrationValid()) {
                                      cubit.nextStep();
                                    } else if (cubit
                                            .passengerRegisterCurrentStep ==
                                        0) {
                                      if (cubit.profileImage == null) {
                                        customSnackBar(
                                          context: context,
                                          text: 'قم بإضافة صورة شخصية',
                                          color: ColorsManager.red,
                                        );
                                      } else if (cubit
                                              .passengerRegisterPasswordController
                                              .text !=
                                          cubit
                                              .passengerRegisterConfirmPasswordController
                                              .text) {
                                        customSnackBar(
                                          context: context,
                                          text: 'كلمتا المرور غير متطابقتين',
                                          color: ColorsManager.red,
                                        );
                                      }
                                    }
                                  },
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
