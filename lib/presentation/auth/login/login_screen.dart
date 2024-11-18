import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meshwar/business_logic/auth_cubit/auth_cubit.dart';
import 'package:meshwar/core/routing/routes.dart';
import 'package:meshwar/core/shared/functions/functions.dart';
import 'package:meshwar/core/shared/shared_preferences/shared_preferences.dart';
import 'package:meshwar/core/shared/shared_preferences/shared_preferences_keys.dart';
import 'package:meshwar/core/shared/widgets/custom_button.dart';
import 'package:meshwar/core/shared/widgets/custom_text.dart';
import 'package:meshwar/core/shared/widgets/custom_text_button.dart';
import 'package:meshwar/core/shared/widgets/custom_text_form_field.dart';
import 'package:meshwar/core/theme/colors/colors.dart';
import 'package:meshwar/core/theme/fonts/fonts.dart';
import 'package:meshwar/core/theme/images/images.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  var loginFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  EdgeInsets.symmetric(vertical: 16.00.h, horizontal: 16.00.w),
              child: BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is SuccessLoginAppState) {
                    if (state.userModel.body!.role == 'passenger') {
                      if (state.userModel.body!.status == 'Approved') {
                        Navigator.pushReplacementNamed(
                            context, Routes.passengerHome);
                        customSnackBar(
                          context: context,
                          text: 'تم تسجيل الدخول كـ راكب، مرحبًا بك',
                          color: ColorsManager.green,
                        );
                      } else {
                        Navigator.pushNamed(context, Routes.waitingScreen);
                        SharedPreferencesService.removeData(
                          key: SharedPreferencesKeys.userToken,
                        );
                        customSnackBar(
                          context: context,
                          text:
                              'برجاء الإنتظار لحين الانتهاء من مراجعة بياناتك',
                          color: ColorsManager.amber,
                        );
                      }
                    }
                  }
                  if (state is SuccessForgetPasswordAppState) {
                    customSnackBar(
                      context: context,
                      text: 'تم الإرسال بنجاح',
                      color: ColorsManager.green,
                    );
                  }
                  if (state is ErrorLoginAppState) {
                    customSnackBar(
                        context: context,
                        text: 'قم بمراجعة بياناتك مرة أخرى، وتحقق من الإنترنت',
                        color: ColorsManager.red);
                  }
                },
                builder: (context, state) {
                  var cubit = context.read<AuthCubit>();
                  return Form(
                    key: loginFormKey,
                    child: Column(
                      children: [
                        CustomText(
                          text: 'مرحبًا بك، قم بتسجيل الدخول',
                          fontSize: 17.00.sp,
                          fontFamily: FontManager.extraBold,
                          color: ColorsManager.darkOrange,
                        ),
                        SizedBox(height: 20.00.h),
                        CustomTextFormField(
                          hintText: 'البريد الإلكتروني',
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'من فضلك هذا الحقل مطلوب';
                            } else if (!cubit.emailRegex.hasMatch(value)) {
                              return 'أدخل بريد إلكتروني صحيح';
                            }
                            return null;
                          },
                          prefixIcon: SvgPicture.asset(
                            ImagesManager.mail,
                            height: 10.h,
                          ),
                          controller: cubit.loginEmailController,
                          inputType: TextInputType.emailAddress,
                        ),
                        SizedBox(height: 20.00.h),
                        CustomTextFormField(
                          hintText: 'كلمة المرور',
                          prefixIcon: SvgPicture.asset(
                            ImagesManager.lock,
                            height: 10.h,
                          ),
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'من فضلك هذا الحقل مطلوب';
                            } else if (!cubit.passwordRegex.hasMatch(value)) {
                              return 'يجب أن تحتوي كلمة المرور على أحرف وألا تقل عن 6 خانات';
                            }
                            return null;
                          },
                          suffixIcon: IconButton(
                            onPressed: () {
                              cubit.changeVisibilityTrueOrFalse(
                                currentVisibility: cubit.isLoginPasswordVisible,
                                updateVisibility: (value) {
                                  cubit.isLoginPasswordVisible = value;
                                },
                              );
                            },
                            icon: cubit.isLoginPasswordVisible == true
                                ? SvgPicture.asset(
                                    ImagesManager.visible,
                                    height: 30.h,
                                  )
                                : SvgPicture.asset(
                                    ImagesManager.invisible,
                                    height: 30.h,
                                  ),
                          ),
                          controller: cubit.loginPasswordController,
                          inputType: TextInputType.visiblePassword,
                          obscureText: cubit.isLoginPasswordVisible,
                        ),
                        SizedBox(height: 10.00.h),
                        Align(
                          alignment: Alignment.centerRight,
                          child: CustomTextButton(
                            text: 'نسيت كلمة المرور؟',
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor: ColorsManager.white,
                                  title: const CustomText(
                                      text: 'قم بإدخال بريدك الإلكتروني'),
                                  content: Row(
                                    children: [
                                      Expanded(
                                        child: CustomTextFormField(
                                          hintText: 'البريد الإلكتروني',
                                          prefixIcon: SvgPicture.asset(
                                            ImagesManager.mail,
                                            height: 10.00.h,
                                          ),
                                          controller: cubit
                                              .forgetPasswordEmailController,
                                          inputType: TextInputType.emailAddress,
                                        ),
                                      )
                                    ],
                                  ),
                                  actions: [
                                    CustomTextButton(
                                      text: 'تراجع',
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                    CustomTextButton(
                                      text: 'إرسال',
                                      onPressed: () {
                                        if (cubit.forgetPasswordEmailController
                                                .text.isEmpty ||
                                            !cubit.emailRegex.hasMatch(cubit
                                                .forgetPasswordEmailController
                                                .text)) {
                                          customSnackBar(
                                              context: context,
                                              text: cubit
                                                      .forgetPasswordEmailController
                                                      .text
                                                      .isEmpty
                                                  ? 'من فضلك أدخل البريد الإلكتروني'
                                                  : 'أدخل بريدًا إلكترونيًا صحيحًا',
                                              color: ColorsManager.red);
                                        } else {
                                          cubit.forgetPassword();
                                          Navigator.pop(context);
                                          cubit.forgetPasswordEmailController
                                              .clear();
                                        }
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 30.00.h),
                        state is LoadingLoginAppState
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : CustomButton(
                                text: 'تسجيل الدخول',
                                onPressed: () {
                                  if (loginFormKey.currentState!.validate()) {
                                    cubit.login();
                                  }
                                },
                              ),
                        SizedBox(height: 20.00.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CustomText(text: '،ليس لدي حساب'),
                            CustomTextButton(
                              text: 'إنشاء حساب',
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.askUserRole,
                                );
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
