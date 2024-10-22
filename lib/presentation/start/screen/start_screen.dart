import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meshwar/core/routing/routes.dart';
import 'package:meshwar/core/shared/shared_preferences/shared_preferences.dart';
import 'package:meshwar/core/shared/shared_preferences/shared_preferences_keys.dart';
import 'package:meshwar/core/shared/widgets/app_background.dart';
import 'package:meshwar/core/shared/widgets/button.dart';
import 'package:meshwar/core/shared/widgets/texts.dart';
import 'package:meshwar/core/theme/images/images.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
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
                    children: [
                      SizedBox(height: 60.00.h),
                      const ExtraBoldText25dark(text: 'إبدأ مشوارك الآن'),
                      SizedBox(height: 20.00.h),
                      Image.asset(
                        ImagesManager.meshwarLogo,
                        height: 150.00.h,
                        width: double.infinity.w,
                        fit: BoxFit.cover,
                      ),
                      CustomButton(
                        text: 'إبدأ الآن',
                        onPressed: () {
                          SharedPreferencesService.saveData(
                              key: SharedPreferencesKeys.start, value: 1);
                          Navigator.pushReplacementNamed(context, Routes.login);
                        },
                      ),
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
