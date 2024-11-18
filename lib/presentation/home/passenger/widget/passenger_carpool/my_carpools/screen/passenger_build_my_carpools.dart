import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meshwar/core/shared/functions/functions.dart';
import 'package:meshwar/core/shared/widgets/custom_text.dart';
import 'package:meshwar/core/theme/colors/colors.dart';
import 'package:meshwar/core/theme/fonts/fonts.dart';

class PassengerBuildMyCarpools extends StatelessWidget {
  const PassengerBuildMyCarpools({super.key});

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
          text: 'دورات كاربول',
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
            text: 'هنفتح بس الصبر',
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
                      text: '012302',
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
                      text: 'موعد بدء الدورة',
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
                      text: 'موعد نهاية الدورة',
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
                      text: 'سعر الدورة للفرد',
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
                      text: '150\$',
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
