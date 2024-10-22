import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meshwar/business_logic/layout/cubit/cubit.dart';
import 'package:meshwar/core/routing/routes.dart';
import 'package:meshwar/core/shared/widgets/texts.dart';
import 'package:meshwar/core/theme/colors/colors.dart';
import 'package:meshwar/core/theme/images/images.dart';
import 'package:meshwar/data/layout/models/home/notifications_model.dart';
import 'package:meshwar/presentation/layout/widgets/home/widgets/notification_details.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<LayoutAppCubit>();
    return BlocConsumer<LayoutAppCubit, LayoutAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Container(
                        width: double.infinity.w,
                        padding: EdgeInsets.symmetric(vertical: 10.00.h),
                        margin: EdgeInsets.symmetric(horizontal: 10.00.h),
                        decoration: BoxDecoration(
                          color: ColorsManager.mainAppColor,
                          borderRadius: BorderRadius.circular(10.00.r),
                          boxShadow: [
                            BoxShadow(
                              color: ColorsManager.deepOrange.withOpacity(0.4),
                              blurRadius: 10.00.r,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: cubit.profileModel == null
                            ? const Center(
                                child: CircularProgressIndicator.adaptive(),
                              )
                            : BoldText16dark(
                                text:
                                    'مرحبًا بك ك. ${cubit.profileModel!.body!.firstName} ${cubit.profileModel!.body!.lastName}',
                                color: ColorsManager.white,
                              ),
                      ),
                    ),
                    CircleAvatar(
                      backgroundColor:
                          ColorsManager.mainAppColor.withOpacity(0.5),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pushNamed(context, Routes.messages);
                        },
                        icon: Image.asset(ImagesManager.messages),
                        color: ColorsManager.white,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.00.h),
                Row(
                  children: [
                    Image.asset(
                      ImagesManager.notification,
                    ),
                    SizedBox(width: 10.00.h),
                    const ExtraBoldText16dark(text: 'رحلاتك'),
                  ],
                ),
                SizedBox(height: 10.00.h),
                cubit.getAllNotifications == null
                    ? const Center(
                        child: CircularProgressIndicator.adaptive(),
                      )
                    : cubit.getAllNotifications!.body!.isEmpty
                        ? Column(
                            children: [
                              SizedBox(height: 100.00.h),
                              Image.asset(ImagesManager.noNotifications),
                              const ExtraBoldText16dark(
                                  text: 'لا توجد إشعارات حتى الآن'),
                            ],
                          )
                        : const SizedBox(),
                cubit.getAllNotifications == null
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) =>
                            buildTripNotificationItem(
                          context,
                          cubit.tripNotifications[index],
                        ),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 5.00.h),
                        itemCount: cubit.tripNotifications.length,
                      ),
                SizedBox(height: 100.00.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildTripNotificationItem(
      BuildContext context, Notifications notifications) {
    return GestureDetector(
      onTap: () {
        List<String?> destinationAddresses = [
          notifications.data!.destinations!.a,
          notifications.data!.destinations!.b,
          notifications.data!.destinations!.c,
          notifications.data!.destinations!.d,
        ];
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NotificationDetails(
              notificationId: notifications.id!,
              destinationAddresses: destinationAddresses,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5.00.h, vertical: 5.00.h),
        padding: EdgeInsets.symmetric(horizontal: 20.00.h, vertical: 15.00.h),
        decoration: BoxDecoration(
          color: ColorsManager.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: ColorsManager.mainAppColor.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BoldText14dark(
              text: 'نقطة التلاقي:',
              color: ColorsManager.black,
            ),
            ExtraBoldText14dark(
              textAlign: TextAlign.start,
              text: '${notifications.data!.pickupPoint}',
            ),
            SizedBox(height: 10.00.h),
            const BoldText14dark(
              text: 'الوجهات الأساسية:',
              color: ColorsManager.black,
            ),
            notifications.data?.destinations?.a != null
                ? Row(
                    children: [
                      const ExtraBoldText14dark(
                        textAlign: TextAlign.start,
                        text: 'الأولى',
                        color: ColorsManager.black,
                      ),
                      SizedBox(width: 10.00.w),
                      Flexible(
                        child: ExtraBoldText14dark(
                          textAlign: TextAlign.start,
                          text: '${notifications.data!.destinations!.a}',
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
            SizedBox(height: 5.00.h),
            notifications.data?.destinations?.b != null
                ? Row(
                    children: [
                      const ExtraBoldText14dark(
                        textAlign: TextAlign.start,
                        text: 'الثانية',
                        color: ColorsManager.black,
                      ),
                      SizedBox(width: 10.00.w),
                      Flexible(
                        child: ExtraBoldText14dark(
                          textAlign: TextAlign.start,
                          text: '${notifications.data!.destinations!.b}',
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
            SizedBox(height: 5.00.h),
            notifications.data?.destinations?.c != null
                ? Row(
                    children: [
                      const ExtraBoldText14dark(
                        textAlign: TextAlign.start,
                        text: 'الثالثة',
                        color: ColorsManager.black,
                      ),
                      SizedBox(width: 10.00.w),
                      Flexible(
                        child: ExtraBoldText14dark(
                          textAlign: TextAlign.start,
                          text: '${notifications.data!.destinations!.c}',
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
            SizedBox(height: 5.00.h),
            notifications.data?.destinations?.d != null
                ? Row(
                    children: [
                      const ExtraBoldText14dark(
                        textAlign: TextAlign.start,
                        text: 'الرابعة',
                        color: ColorsManager.black,
                      ),
                      SizedBox(width: 10.00.w),
                      Flexible(
                        child: ExtraBoldText14dark(
                          textAlign: TextAlign.start,
                          text: '${notifications.data!.destinations!.d}',
                        ),
                      ),
                    ],
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
