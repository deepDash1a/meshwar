import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meshwar/business_logic/layout/cubit/cubit.dart';
import 'package:meshwar/core/shared/widgets/app_background.dart';
import 'package:meshwar/core/shared/widgets/texts.dart';
import 'package:meshwar/core/theme/colors/colors.dart';
import 'package:meshwar/core/theme/images/images.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<LayoutAppCubit>();

    return BlocConsumer<LayoutAppCubit, LayoutAppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Stack(
              children: [
                const AppBackground(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 20.0.h,
                    horizontal: 16.0.w,
                  ),
                  child: cubit.pages[cubit.selectedIndex],
                ),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: buildNavContainer(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildNavItem(
                          Image.asset(
                            ImagesManager.home,
                            color: ColorsManager.white,
                          ),
                          'الرئيسية',
                          0,
                          context,
                        ),
                        buildNavItem(
                          Image.asset(
                            ImagesManager.shift,
                            color: ColorsManager.white,
                          ),
                          'الوردية',
                          1,
                          context,
                        ),
                        buildNavItem(
                          Image.asset(
                            ImagesManager.maps,
                            color: ColorsManager.white,
                          ),
                          'الخريطة',
                          2,
                          context,
                        ),
                        buildNavItem(
                          Image.asset(
                            ImagesManager.person,
                            color: ColorsManager.white,
                          ),
                          'الشخصية',
                          3,
                          context,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildNavItem(
    Widget icon,
    String label,
    int index,
    BuildContext context,
  ) {
    bool isSelected = context.read<LayoutAppCubit>().selectedIndex == index;
    return GestureDetector(
      onTap: () => context.read<LayoutAppCubit>().onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: isSelected
                  ? ColorsManager.white.withOpacity(0.5)
                  : ColorsManager.transparent,
              shape: BoxShape.circle,
              boxShadow: isSelected
                  ? [
                      const BoxShadow(
                        color: ColorsManager.deepOrange,
                        blurRadius: 10,
                        spreadRadius: 5,
                      ),
                    ]
                  : [],
            ),
            child: icon,
          ),
          const SizedBox(height: 5),
          ExtraBoldText12dark(
            text: label,
            color: ColorsManager.white,
          ),
        ],
      ),
    );
  }

  Widget buildNavContainer(Widget child) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.00.h),
      decoration: BoxDecoration(
        color: ColorsManager.mainAppColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20.00.r),
        boxShadow: [
          BoxShadow(
            color: ColorsManager.deepOrange.withOpacity(0.4),
            blurRadius: 10.00.r,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: child,
    );
  }
}
