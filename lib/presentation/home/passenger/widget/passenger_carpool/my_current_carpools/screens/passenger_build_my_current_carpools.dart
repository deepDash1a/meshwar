import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meshwar/core/shared/functions/functions.dart';
import 'package:meshwar/core/shared/widgets/custom_text.dart';
import 'package:meshwar/core/theme/colors/colors.dart';
import 'package:meshwar/core/theme/fonts/fonts.dart';

class PassengerBuildMyCurrentCarpools extends StatelessWidget {
  const PassengerBuildMyCurrentCarpools({super.key});

  @override
  Widget build(BuildContext context) {
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
          text: 'دورات كاربول الحالية',
          fontSize: 16.00.sp,
          fontFamily: FontManager.bold,
          color: ColorsManager.white,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 16.00.w,
          vertical: 16.00.h,
        ),
        child: Column(
          children: [
            passengerBuildMyCarpoolItem(context),
            SizedBox(height: 20.00.h),
            passengerBuildMyCarpoolItem(context),
          ],
        ),
      ),
    );
  }

  Widget passengerBuildMyCarpoolItem(BuildContext context) {
    return InkWell(
      onTap: () {
        customSnackBar(
            context: context,
            text: 'هنفتح برضو بس الصبر',
            color: ColorsManager.green);
      },
      child: Card(
        color: ColorsManager.white,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.00.w,
            vertical: 16.00.h,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const Expanded(
                    child: CustomText(
                      text: 'رقم الدورة',
                      textAlign: TextAlign.end,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.00.w,
                      vertical: 5.00.h,
                    ),
                    decoration: BoxDecoration(
                      color: ColorsManager.amber,
                      borderRadius: BorderRadius.circular(
                        6.0.r,
                      ),
                    ),
                    child: const CustomText(
                      text: '12',
                      color: ColorsManager.white,
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.00.h),
              Row(
                children: [
                  const Expanded(
                    child: CustomText(
                      text: 'موعد بدء الدورة',
                      textAlign: TextAlign.end,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.00.w,
                      vertical: 5.00.h,
                    ),
                    decoration: BoxDecoration(
                      color: ColorsManager.red,
                      borderRadius: BorderRadius.circular(
                        6.0.r,
                      ),
                    ),
                    child: const CustomText(
                      text: 'الثلاثاء 5:38 ص',
                      color: ColorsManager.white,
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.00.h),
              Row(
                children: [
                  const Expanded(
                    child: CustomText(
                      text: 'موعد نهاية الدورة',
                      textAlign: TextAlign.end,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.00.w,
                      vertical: 5.00.h,
                    ),
                    decoration: BoxDecoration(
                      color: ColorsManager.red,
                      borderRadius: BorderRadius.circular(
                        6.0.r,
                      ),
                    ),
                    child: const CustomText(
                      text: 'الثلاثاء 7:50 ص',
                      color: ColorsManager.white,
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.00.h),
              Row(
                children: [
                  const Expanded(
                    child: CustomText(
                      text: 'عدد المقاعد المتاحة',
                      textAlign: TextAlign.end,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.00.w,
                      vertical: 5.00.h,
                    ),
                    decoration: BoxDecoration(
                      color: ColorsManager.green,
                      borderRadius: BorderRadius.circular(
                        6.0.r,
                      ),
                    ),
                    child: const CustomText(
                      text: '3',
                      color: ColorsManager.white,
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.00.h),
              Row(
                children: [
                  const Expanded(
                    child: CustomText(
                      text: 'اسم السائق',
                      textAlign: TextAlign.end,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.00.w,
                      vertical: 5.00.h,
                    ),
                    decoration: BoxDecoration(
                      color: ColorsManager.green,
                      borderRadius: BorderRadius.circular(
                        6.0.r,
                      ),
                    ),
                    child: const CustomText(
                      text: 'محمد أحمد عبدالغني',
                      color: ColorsManager.white,
                    ),
                  )
                ],
              ),
              SizedBox(height: 20.00.h),
              Row(
                children: [
                  const Expanded(
                    child: CustomText(
                      text: 'رقم هاتف السائق',
                      textAlign: TextAlign.end,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.00.w,
                      vertical: 5.00.h,
                    ),
                    decoration: BoxDecoration(
                      color: ColorsManager.green,
                      borderRadius: BorderRadius.circular(
                        6.0.r,
                      ),
                    ),
                    child: const CustomText(
                      text: '01024842018',
                      color: ColorsManager.white,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
