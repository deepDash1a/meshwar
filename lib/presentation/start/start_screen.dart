import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meshwar/core/routing/routes.dart';
import 'package:meshwar/core/shared/shared_preferences/shared_preferences.dart';
import 'package:meshwar/core/shared/shared_preferences/shared_preferences_keys.dart';
import 'package:meshwar/core/shared/widgets/custom_button.dart';
import 'package:meshwar/core/shared/widgets/custom_text.dart';
import 'package:meshwar/core/theme/images/images.dart';

import '../../core/theme/fonts/fonts.dart';

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
          child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 16.00.w, vertical: 16.00.h),
            child: Column(
              children: [
                CustomText(
                  text: 'مرحبًا بك قم بأداء مشوارك بسهولة وسرعة',
                  fontSize: 16.5.sp,
                  fontFamily: FontManager.extraBold,
                ),
                SizedBox(height: 20.00.h),
                SvgPicture.asset(
                  ImagesManager.startScreen,
                  width: 400.0.w,
                  height: 400.0.h,
                  fit: BoxFit.cover,
                ),
                SizedBox(height: 20.00.h),
                CustomButton(
                  text: 'إبدأ الآن',
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.loginScreen);
                    SharedPreferencesService.saveData(
                      key: SharedPreferencesKeys.startScreen,
                      value: 'true',
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
