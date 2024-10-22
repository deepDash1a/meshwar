import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meshwar/core/shared/widgets/app_background.dart';
import 'package:meshwar/core/shared/widgets/texts.dart';
import 'package:meshwar/core/theme/colors/colors.dart';
import 'package:meshwar/core/theme/images/images.dart';
import 'package:meshwar/presentation/authentication/login/widgets/do_not_have_an_account.dart';
import 'package:meshwar/presentation/authentication/login/widgets/login_form.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                      const ExtraBoldText25dark(text: 'تسجيل الدخول'),
                      SizedBox(height: 20.00.h),
                      Image.asset(
                        ImagesManager.meshwarLogo,
                        height: 150.00.h,
                        width: double.infinity.w,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(height: 20.00.h),
                      const LoginForm(),
                      SizedBox(height: 20.00.h),
                      Divider(
                          color: ColorsManager.mainAppColor.withOpacity(0.5)),
                      SizedBox(height: 20.00.h),
                      const DoNotHaveAnAccount(),
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
