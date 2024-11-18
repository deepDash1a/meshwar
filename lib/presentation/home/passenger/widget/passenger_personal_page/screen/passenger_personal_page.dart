import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meshwar/business_logic/home_cubit/home_cubit.dart';
import 'package:meshwar/core/shared/widgets/custom_button.dart';
import 'package:meshwar/core/shared/widgets/custom_text.dart';
import 'package:meshwar/core/shared/widgets/custom_text_form_field.dart';
import 'package:meshwar/core/theme/colors/colors.dart';
import 'package:meshwar/core/theme/fonts/fonts.dart';
import 'package:meshwar/core/theme/images/images.dart';

class PassengerPersonalPage extends StatelessWidget {
  const PassengerPersonalPage({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<HomeCubit>();
    var expireDateController = TextEditingController(
        text:
            '${cubit.profileModel!.body!.passenger!.expirationNationalIdDate}');
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
          text: 'الصفحة الشخصية',
          fontSize: 16.00.sp,
          fontFamily: FontManager.bold,
          color: ColorsManager.white,
        ),
      ),
      body: BlocConsumer<HomeCubit, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0.w,
                vertical: 16.00.h,
              ),
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
                                  color: ColorsManager.white,
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
                            backgroundColor:
                                ColorsManager.white.withOpacity(0.5),
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
                    hintText: 'الاسم بالكامل',
                    prefixIcon: SvgPicture.asset(
                      ImagesManager.person,
                      height: 10.h,
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'من فضلك هذا الحقل مطلوب';
                      }
                      return null;
                    },
                    controller: TextEditingController(
                        text: '${cubit.profileModel!.body!.name}'),
                    inputType: TextInputType.text,
                  ),
                  SizedBox(height: 20.00.h),
                  CustomTextFormField(
                    hintText: 'البريد الإلكتروني',
                    prefixIcon: SvgPicture.asset(
                      ImagesManager.mail,
                      height: 10.h,
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'من فضلك هذا الحقل مطلوب';
                      } else if (!cubit.emailRegex.hasMatch(value)) {
                        return 'من فضلك أدخل بريدًا صحيحًا';
                      }
                      return null;
                    },
                    controller: TextEditingController(
                        text: '${cubit.profileModel!.body!.email}'),
                    inputType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20.00.h),
                  CustomTextFormField(
                    hintText: 'رقم الواتساب',
                    prefixIcon: SvgPicture.asset(
                      ImagesManager.phone,
                      height: 10.h,
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'من فضلك هذا الحقل مطلوب';
                      } else if (!cubit.egyptPhoneRegExp.hasMatch(value)) {
                        return 'من فضلك أدخل بريدًا صحيحًا';
                      }
                      return null;
                    },
                    controller: TextEditingController(
                        text: '${cubit.profileModel!.body!.whatsappNumber}'),
                    inputType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20.00.h),
                  CustomTextFormField(
                    hintText: 'رقم الهاتف',
                    prefixIcon: SvgPicture.asset(
                      ImagesManager.phone,
                      height: 10.h,
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'من فضلك هذا الحقل مطلوب';
                      } else if (!cubit.egyptPhoneRegExp.hasMatch(value)) {
                        return 'من فضلك أدخل بريدًا صحيحًا';
                      }
                      return null;
                    },
                    controller: TextEditingController(
                        text: '${cubit.profileModel!.body!.anotherNumber}'),
                    inputType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20.00.h),
                  CustomTextFormField(
                    hintText: 'المحافظة',
                    prefixIcon: SvgPicture.asset(
                      ImagesManager.governorate,
                      height: 10.h,
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'من فضلك هذا الحقل مطلوب';
                      } else if (!cubit.egyptPhoneRegExp.hasMatch(value)) {
                        return 'من فضلك أدخل بريدًا صحيحًا';
                      }
                      return null;
                    },
                    controller: TextEditingController(
                        text:
                            '${cubit.profileModel!.body!.passenger!.province}'),
                    inputType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20.00.h),
                  CustomTextFormField(
                    hintText: 'المنطقة السكنية',
                    prefixIcon: SvgPicture.asset(
                      ImagesManager.residentialArea,
                      height: 10.h,
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'من فضلك هذا الحقل مطلوب';
                      } else if (!cubit.egyptPhoneRegExp.hasMatch(value)) {
                        return 'من فضلك أدخل بريدًا صحيحًا';
                      }
                      return null;
                    },
                    controller: TextEditingController(
                        text:
                            '${cubit.profileModel!.body!.passenger!.district}'),
                    inputType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20.00.h),
                  CustomTextFormField(
                    hintText: 'الحي',
                    prefixIcon: SvgPicture.asset(
                      ImagesManager.neighborhood,
                      height: 10.h,
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'من فضلك هذا الحقل مطلوب';
                      } else if (!cubit.egyptPhoneRegExp.hasMatch(value)) {
                        return 'من فضلك أدخل بريدًا صحيحًا';
                      }
                      return null;
                    },
                    controller: TextEditingController(
                        text:
                            '${cubit.profileModel!.body!.passenger!.subDistrict}'),
                    inputType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20.00.h),
                  CustomTextFormField(
                    hintText: 'الشارع',
                    prefixIcon: SvgPicture.asset(
                      ImagesManager.street,
                      height: 10.h,
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'من فضلك هذا الحقل مطلوب';
                      } else if (!cubit.egyptPhoneRegExp.hasMatch(value)) {
                        return 'من فضلك أدخل بريدًا صحيحًا';
                      }
                      return null;
                    },
                    controller: TextEditingController(
                        text: '${cubit.profileModel!.body!.passenger!.street}'),
                    inputType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20.00.h),
                  CustomTextFormField(
                    hintText: 'العمارة',
                    prefixIcon: SvgPicture.asset(
                      ImagesManager.building,
                      height: 10.h,
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'من فضلك هذا الحقل مطلوب';
                      } else if (!cubit.egyptPhoneRegExp.hasMatch(value)) {
                        return 'من فضلك أدخل بريدًا صحيحًا';
                      }
                      return null;
                    },
                    controller: TextEditingController(
                        text:
                            '${cubit.profileModel!.body!.passenger!.building}'),
                    inputType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20.00.h),
                  CustomTextFormField(
                    hintText: 'العلامة المميزة',
                    prefixIcon: SvgPicture.asset(
                      ImagesManager.distinctiveMark,
                      height: 10.h,
                    ),
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'من فضلك هذا الحقل مطلوب';
                      } else if (!cubit.egyptPhoneRegExp.hasMatch(value)) {
                        return 'من فضلك أدخل بريدًا صحيحًا';
                      }
                      return null;
                    },
                    controller: TextEditingController(
                        text:
                            '${cubit.profileModel!.body!.passenger!.landmark}'),
                    inputType: TextInputType.emailAddress,
                  ),
                  SizedBox(height: 20.00.h),
                  CustomTextFormField(
                    hintText: 'تعديل تاريخ نهاية البطاقة الشخصية',
                    prefixIcon: SvgPicture.asset(
                      ImagesManager.date,
                      height: 10.h,
                    ),
                    controller: expireDateController,
                    inputType: TextInputType.text,
                    validator: (String? value) {
                      if (value!.isEmpty) {
                        return 'من فضلك هذا الحقل مطلوب';
                      }
                      return null;
                    },
                    readOnly: true,
                    onTap: () {
                      cubit.selectFutureDate(context, expireDateController);
                    },
                  ),
                  SizedBox(height: 40.00.h),
                  CustomButton(
                    text: 'تعديل البيانات',
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
