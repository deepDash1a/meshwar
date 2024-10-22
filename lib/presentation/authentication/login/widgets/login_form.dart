import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meshwar/business_logic/authentication/cubit/cubit.dart';
import 'package:meshwar/core/routing/routes.dart';
import 'package:meshwar/core/shared/functions/functions.dart';
import 'package:meshwar/core/shared/notification_helper/notification_helper.dart';
import 'package:meshwar/core/shared/shared_preferences/shared_preferences.dart';
import 'package:meshwar/core/shared/shared_preferences/shared_preferences_keys.dart';
import 'package:meshwar/core/shared/widgets/button.dart';
import 'package:meshwar/core/shared/widgets/custom_text_form_field.dart';
import 'package:meshwar/core/theme/colors/colors.dart';
import 'package:meshwar/core/theme/images/images.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthenticationAppCubit>();
    var loginFormKey = GlobalKey<FormState>();

    return BlocConsumer<AuthenticationAppCubit, AuthenticationAppStates>(
      listener: (context, state) {
        if (state is SuccessLoginAppState) {
          customSnackBar(
            context: context,
            text: 'تم تسجيل الدخول بنجاح',
            color: ColorsManager.green,
          );
          if (cubit.loginUserModel!.body!.status != 'تم الموافقة') {
            Navigator.pushNamed(context, Routes.layout);
            cubit.sendFcmToken(FCMNotificationService().fcmToken);
          } else {
            SharedPreferencesService.removeData(
                key: SharedPreferencesKeys.userToken);
            Navigator.pushNamed(context, Routes.waiting);
          }
          cubit.loginEmailController.clear();
          cubit.loginPasswordController.clear();
        }
        if (state is ErrorLoginAppState) {
          customSnackBar(
            context: context,
            text: 'حدث خطأ ما، حاول مرة أخرى',
            color: ColorsManager.red,
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: loginFormKey,
          child: Column(
            children: [
              CustomTextFormField(
                controller: cubit.loginEmailController,
                appRegex: cubit.emailAppRegex,
                textInputType: TextInputType.emailAddress,
                label: 'البريد الإلكتروني ',
                prefixIcon: Image.asset(ImagesManager.email),
                validatorText: 'هذا الحقل مطلوب',
                regexValidateText: 'من فضلك أدخل بريدك بشكل صحيح',
              ),
              SizedBox(height: 20.00.h),
              CustomTextFormField(
                controller: cubit.loginPasswordController,
                appRegex: cubit.passwordRegex,
                textInputType: TextInputType.name,
                obscureText: cubit.loginObscureText,
                label: 'كلمة المرور',
                prefixIcon: Image.asset(
                  ImagesManager.lock,
                ),
                validatorText: 'هذا الحقل مطلوب',
                regexValidateText: 'من فضلك أدخل كلمة المرور بشكل صحيح',
                suffixIcon: IconButton(
                  onPressed: () {
                    cubit.changeLoginPasswordVisibility();
                  },
                  icon: Image.asset(
                    cubit.loginObscureText == true
                        ? ImagesManager.visible
                        : ImagesManager.invisible,
                  ),
                ),
              ),
              SizedBox(height: 40.00.h),
              state is LoadingLoginAppState
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: ColorsManager.mainAppColor,
                      ),
                    )
                  : CustomButton(
                      text: 'سجل',
                      onPressed: () {
                        if (loginFormKey.currentState!.validate()) {
                          cubit.attemptLogin(context);
                        }
                      },
                    ),
            ],
          ),
        );
      },
    );
  }
}
