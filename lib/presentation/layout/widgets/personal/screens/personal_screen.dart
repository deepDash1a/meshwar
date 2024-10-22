import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meshwar/business_logic/layout/cubit/cubit.dart';
import 'package:meshwar/core/shared/functions/functions.dart';
import 'package:meshwar/core/shared/widgets/custom_text_button.dart';
import 'package:meshwar/core/shared/widgets/custom_text_form_field.dart';
import 'package:meshwar/core/shared/widgets/texts.dart';
import 'package:meshwar/core/theme/colors/colors.dart';
import 'package:meshwar/core/theme/images/images.dart';

class PersonalScreen extends StatelessWidget {
  const PersonalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<LayoutAppCubit>();

    return BlocConsumer<LayoutAppCubit, LayoutAppStates>(
      listener: (context, state) {
        if (state is SuccessLogoutAppState) {
          customSnackBar(
            context: context,
            text: 'تم تسجيل الخروج بنجاح',
            color: ColorsManager.green,
          );
        }
        if (state is SuccessUpdateProfileDataAppState) {
          customSnackBar(
            context: context,
            text: 'تم التعديل بنجاح',
            color: ColorsManager.green,
          );

          cubit.getProfileData();
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: cubit.profileModel == null
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 62.00.r,
                              backgroundColor: ColorsManager.mainAppColor,
                            ),
                            CircleAvatar(
                              radius: 60.00.r,
                              backgroundImage: const NetworkImage(
                                  'https://img.freepik.com/premium-photo/man-with-beard-wearing-blue-plaid-shirt-with-watch-his-left-arm_1249303-7421.jpg?w=740'),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.00.h),
                        ExtraBoldText16dark(
                            text:
                                '${cubit.profileModel!.body!.firstName} ${cubit.profileModel!.body!.lastName}'),
                        SizedBox(height: 5.00.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              ImagesManager.starUser,
                              width: 25.00.w,
                              height: 25.00.h,
                              color: ColorsManager.grey.withOpacity(0.8),
                            ),
                            SizedBox(
                              width: 10.00.w,
                            ),
                            Flexible(
                              child: RegularText14dark(
                                  text: '${cubit.profileModel!.body!.status}'),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.00.h),
                        Container(
                          width: double.infinity.w,
                          padding: EdgeInsets.symmetric(
                              vertical: 20.00.h, horizontal: 10.00),
                          margin: EdgeInsets.symmetric(
                              vertical: 10.00.h, horizontal: 10.00),
                          decoration: BoxDecoration(
                            color: ColorsManager.white,
                            borderRadius: BorderRadius.circular(10.00.r),
                            boxShadow: [
                              BoxShadow(
                                color:
                                    ColorsManager.mainAppColor.withOpacity(0.4),
                                blurRadius: 10.00.r,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.asset(
                                    ImagesManager.person,
                                    width: 25.00.w,
                                    height: 25.00.h,
                                    color: ColorsManager.grey.withOpacity(0.8),
                                  ),
                                  SizedBox(width: 10.00.w),
                                  Flexible(
                                    child: CustomTextFormField(
                                      controller:
                                          cubit.personalFirstNameController,
                                      label: 'الاسم الأول',
                                      validatorText: 'من فضلك أدخل الاسم صحيح',
                                      regexValidateText: 'أدخل اسمًا صحيحًا',
                                    ),
                                  ),
                                  SizedBox(width: 10.00.w),
                                  Flexible(
                                    child: CustomTextFormField(
                                      controller:
                                          cubit.personalLastNameController,
                                      label: 'الاسم الأخير',
                                      validatorText: 'من فضلك أدخل الاسم صحيح',
                                      regexValidateText: 'أدخل اسمًا صحيحًا',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.00.h),
                              Row(
                                children: [
                                  Image.asset(
                                    ImagesManager.email,
                                    width: 25.00.w,
                                    height: 25.00.h,
                                    color: ColorsManager.grey.withOpacity(0.8),
                                  ),
                                  SizedBox(width: 10.00.w),
                                  Flexible(
                                    child: CustomTextFormField(
                                      controller: cubit.personalEmailController,
                                      label: 'البريد الإلكتروني',
                                      appRegex: cubit.emailAppRegex,
                                      validatorText: 'من فضلك أدخل الاسم صحيح',
                                      regexValidateText: 'أدخل اسمًا صحيحًا',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.00.h),
                              Row(
                                children: [
                                  Image.asset(
                                    ImagesManager.phone,
                                    width: 25.00.w,
                                    height: 25.00.h,
                                    color: ColorsManager.grey.withOpacity(0.8),
                                  ),
                                  SizedBox(width: 10.00.w),
                                  Flexible(
                                    child: CustomTextFormField(
                                      controller:
                                          cubit.personalWhatsappController,
                                      label: 'رقم الواتساب',
                                      validatorText:
                                          'من فضلك أدخل الرقم بشكل صحيح',
                                      regexValidateText: 'أدخل رقمًا صحيحًا',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.00.h),
                              Row(
                                children: [
                                  Image.asset(
                                    ImagesManager.phone,
                                    width: 25.00.w,
                                    height: 25.00.h,
                                    color: ColorsManager.grey.withOpacity(0.8),
                                  ),
                                  SizedBox(width: 10.00.w),
                                  Flexible(
                                    child: CustomTextFormField(
                                      controller:
                                          cubit.personalAnotherNumberController,
                                      label: 'رقم الهاتف الآخر',
                                      validatorText:
                                          'من فضلك أدخل الرقم بشكل صحيح',
                                      regexValidateText: 'أدخل رقمًا صحيحًا',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.00.h),
                              Row(
                                children: [
                                  Image.asset(
                                    ImagesManager.address,
                                    width: 25.00.w,
                                    height: 25.00.h,
                                    color: ColorsManager.grey.withOpacity(0.8),
                                  ),
                                  SizedBox(width: 10.00.w),
                                  Flexible(
                                    child: CustomTextFormField(
                                      controller:
                                          cubit.personalAddressController,
                                      label: 'العنوان بالتفصيل',
                                      validatorText:
                                          'من فضلك أدخل العنوان بشكل صحيح',
                                      regexValidateText: 'أدخل عنوانًا صحيحًا',
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.00.h),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: state is LoadingUpdateProfileDataAppState
                                    ? const CircularProgressIndicator()
                                    : CustomTextButton(
                                        text: 'تعديل',
                                        function: () {
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const BoldText18dark(
                                                  text: 'تأكيد',
                                                ),
                                                content: const BoldText14dark(
                                                    color: ColorsManager.black,
                                                    text:
                                                        'هل انت متأكد من أنك تريد تعديل بياناتك؟'),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop(); // Close the dialog
                                                    },
                                                    child: const BoldText14dark(
                                                      text: 'لا',
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      cubit.updateProfileData();
                                                      Navigator.of(context)
                                                          .pop(); // Close the dialog
                                                    },
                                                    child: const BoldText14dark(
                                                      text: 'نعم',
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                      ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(height: 20.00.h),
                        state is LoadingLogoutAppState
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : CustomTextButton(
                                text: 'تسجيل الخروج',
                                function: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const BoldText18dark(
                                          text: 'تأكيد',
                                        ),
                                        content: const BoldText14dark(
                                            color: ColorsManager.black,
                                            text:
                                                'هل انت متأكد من أنك تريد تسجيل الخروج؟'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Close the dialog
                                            },
                                            child: const BoldText14dark(
                                              text: 'لا',
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              cubit.logout(context);
                                              Navigator.of(context)
                                                  .pop(); // Close the dialog
                                            },
                                            child: const BoldText14dark(
                                              text: 'نعم',
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                        SizedBox(height: 350.00.h),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
