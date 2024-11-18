import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meshwar/core/routing/routes.dart';
import 'package:meshwar/core/shared/shared_preferences/shared_preferences.dart';
import 'package:meshwar/core/shared/shared_preferences/shared_preferences_keys.dart';
import 'package:meshwar/core/shared/widgets/custom_button.dart';
import 'package:meshwar/core/shared/widgets/custom_text.dart';
import 'package:meshwar/core/theme/colors/colors.dart';
import 'package:meshwar/core/theme/fonts/fonts.dart';

class AskUserRole extends StatefulWidget {
  const AskUserRole({super.key});

  @override
  State<AskUserRole> createState() => _AskUserRoleState();
}

class _AskUserRoleState extends State<AskUserRole> {
  String role = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.00.w, vertical: 16.00.h),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CustomText(
                    text: 'من فضلك إختر ما تريد',
                    fontSize: 17.00.sp,
                    fontFamily: FontManager.extraBold,
                    color: ColorsManager.darkOrange,
                  ),
                  SizedBox(height: 20.0.h),
                  InkWell(
                    onTap: () {
                      setState(() {
                        role = 'passenger';
                        SharedPreferencesService.saveData(
                            key: SharedPreferencesKeys.userRole, value: role);

                        print(SharedPreferencesService.getData(
                            key: SharedPreferencesKeys.userRole));
                      });
                    },
                    child: Container(
                      width: double.infinity.w,
                      height: 100.00.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.00.r),
                        border: Border.all(
                          width: 2.00.w,
                          color: role == 'passenger'
                              ? ColorsManager.darkOrange
                              : ColorsManager.grey,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.00.w),
                        child: Row(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 13.00.r,
                                  backgroundColor: role == 'passenger'
                                      ? ColorsManager.darkOrange
                                      : ColorsManager.grey,
                                ),
                                CircleAvatar(
                                  radius: 10.00.r,
                                  backgroundColor: ColorsManager.white,
                                ),
                              ],
                            ),
                            Expanded(
                              child: Center(
                                child: CustomText(
                                  text: 'إنشاء حساب كـ راكب',
                                  fontSize: 17.00.sp,
                                  color: role == 'passenger'
                                      ? ColorsManager.darkOrange
                                      : ColorsManager.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0.h),
                  InkWell(
                    onTap: () {
                      setState(() {
                        role = 'captain';
                        SharedPreferencesService.saveData(
                            key: SharedPreferencesKeys.userRole, value: role);
                      });

                      print(SharedPreferencesService.getData(
                          key: SharedPreferencesKeys.userRole));
                    },
                    child: Container(
                      width: double.infinity.w,
                      height: 100.00.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.00.r),
                        border: Border.all(
                          width: 2.00.w,
                          color: role == 'captain'
                              ? ColorsManager.darkOrange
                              : ColorsManager.grey,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.00.w),
                        child: Row(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 13.00.r,
                                  backgroundColor: role == 'captain'
                                      ? ColorsManager.darkOrange
                                      : ColorsManager.grey,
                                ),
                                CircleAvatar(
                                  radius: 10.00.r,
                                  backgroundColor: ColorsManager.white,
                                ),
                              ],
                            ),
                            Expanded(
                              child: Center(
                                child: CustomText(
                                  text: 'إنشاء حساب كـ سائق',
                                  fontSize: 17.00.sp,
                                  color: role == 'captain'
                                      ? ColorsManager.darkOrange
                                      : ColorsManager.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0.h),
                  CustomButton(
                    text: 'إنشاء حساب',
                    onPressed: () {
                      role == 'captain'
                          ? Navigator.pushNamed(context, Routes.captainRegister)
                          : Navigator.pushNamed(
                              context, Routes.passengerRegister);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
