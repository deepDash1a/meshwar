import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meshwar/core/shared/widgets/app_background.dart';
import 'package:meshwar/core/shared/widgets/custom_text_button.dart';
import 'package:meshwar/core/shared/widgets/texts.dart';
import 'package:meshwar/core/theme/colors/colors.dart';
import 'package:meshwar/core/theme/images/images.dart';
import 'package:meshwar/presentation/authentication/register/widgets/already_have_an_account.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            const AppBackground(),
            Container(
              padding:
                  EdgeInsets.symmetric(vertical: 20.0.h, horizontal: 16.0.w),
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: CustomTextButton(
                          text: 'رجوع'.toUpperCase(),
                          function: () {
                            Navigator.pop(context);
                          },
                          color: ColorsManager.mainAppColor,
                        ),
                      ),
                      SizedBox(height: 100.00.h),
                      const ExtraBoldText25dark(text: 'تسجيل حساب جديد'),
                      SizedBox(height: 20.00.h),
                      Image.asset(
                        ImagesManager.meshwarLogo,
                        height: 150.00.h,
                        width: double.infinity.w,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 20.00.h),
                      // const RegisterForm(),
                      SizedBox(height: 20.00.h),
                      Divider(
                          color: ColorsManager.mainAppColor.withOpacity(0.5)),
                      SizedBox(height: 20.00.h),
                      const AlreadyHaveAnAccountScreen(),
                      SizedBox(height: 20.00.h),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
