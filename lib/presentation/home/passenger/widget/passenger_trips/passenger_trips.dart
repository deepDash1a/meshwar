import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meshwar/core/routing/routes.dart';
import 'package:meshwar/core/shared/widgets/custom_text.dart';
import 'package:meshwar/core/theme/colors/colors.dart';
import 'package:meshwar/core/theme/fonts/fonts.dart';
import 'package:meshwar/core/theme/images/images.dart';

class PassengerTrips extends StatefulWidget {
  const PassengerTrips({super.key});

  @override
  State<PassengerTrips> createState() => _PassengerTripsState();
}

class _PassengerTripsState extends State<PassengerTrips> {
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
          text: 'رحلات',
          fontSize: 16.00.sp,
          fontFamily: FontManager.bold,
          color: ColorsManager.white,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.00.w,
              vertical: 16.00.h,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: passengerTripItem(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, Routes.passengerRequestTrips);
                        },
                        image: ImagesManager.newCarpool,
                        title: 'الطلبات',
                      ),
                    ),
                    SizedBox(width: 15.00.w),
                    Expanded(
                      child: passengerTripItem(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, Routes.passengerAcceptedTrips);
                        },
                        image: ImagesManager.accepted,
                        title: 'الرحلات المقبولة',
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.00.h),
                passengerTripItem(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.passengerFinishedTrips);
                  },
                  image: ImagesManager.finished,
                  title: 'الرحلات المنتهية',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InkWell passengerTripItem({
    required Function onPressed,
    required String image,
    required String title,
  }) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      child: Card(
        color: ColorsManager.white,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 20.00.w,
            vertical: 10.00.h,
          ),
          child: Column(
            children: [
              SvgPicture.asset(
                image,
                height: 50.0.h,
              ),
              SizedBox(height: 10.00.h),
              CustomText(
                text: title,
                fontSize: 16.00.sp,
                color: ColorsManager.darkOrange,
              ),
              SizedBox(height: 10.00.h),
            ],
          ),
        ),
      ),
    );
  }
}
