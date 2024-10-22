import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meshwar/business_logic/layout/cubit/cubit.dart';
import 'package:meshwar/core/shared/widgets/texts.dart';
import 'package:meshwar/core/theme/colors/colors.dart';
import 'package:meshwar/core/theme/images/images.dart';
import 'package:meshwar/data/layout/models/home/notifications_model.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<LayoutAppCubit>();
    return BlocConsumer<LayoutAppCubit, LayoutAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0.00,
            title: const BoldText16dark(
              text: 'رسائلك',
              color: ColorsManager.white,
            ),
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
          ),
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 20.0.h,
                    horizontal: 16.0.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      cubit.messagesNotifications.isEmpty
                          ? Column(
                              children: [
                                Image.asset(
                                  width: double.infinity.w,
                                  height: 300.00.h,
                                  ImagesManager.noData,
                                ),
                                SizedBox(height: 10.00.h),
                                const BoldText16dark(
                                  text: 'لا توجد رسائل لعرضها',
                                )
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
                                  buildMessagesNotificationItem(
                                context,
                                cubit.messagesNotifications[index],
                              ),
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 5.00.h),
                              itemCount: cubit.messagesNotifications.length,
                            ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildMessagesNotificationItem(
      BuildContext context, Notifications notifications) {
    return Container(
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
          ExtraBoldText14dark(
            textAlign: TextAlign.start,
            text: '${notifications.data!.content!.content}',
          ),
          SizedBox(height: 10.00.h),
          Align(
            alignment: Alignment.centerLeft,
            child: ExtraBoldText14dark(
              textAlign: TextAlign.start,
              text:
                  '${notifications.data!.content!.createdAt}'.substring(0, 10),
              color: ColorsManager.grey,
            ),
          ),
        ],
      ),
    );
  }
}
