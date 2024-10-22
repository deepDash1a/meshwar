import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meshwar/business_logic/authentication/cubit/cubit.dart';
import 'package:meshwar/core/shared/functions/functions.dart';
import 'package:meshwar/core/shared/widgets/custom_text_button.dart';
import 'package:meshwar/core/shared/widgets/texts.dart';
import 'package:meshwar/core/theme/colors/colors.dart';

class WaitingScreen extends StatelessWidget {
  const WaitingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthenticationAppCubit>();
    return BlocConsumer<AuthenticationAppCubit, AuthenticationAppStates>(
      listener: (context, state) {
        if (state is SuccessLogoutAppState) {
          customSnackBar(
            context: context,
            text: 'تم تسجيل الخروج بنجاح',
            color: ColorsManager.green,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 20.0.h,
                    horizontal: 16.0.w,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity.w,
                        height: 70.00.h,
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 5,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: const Center(
                          child: BoldText16dark(
                              text: 'تتم مراجعة بياناتك، برجاء الإنتظار'),
                        ),
                      ),
                      SizedBox(height: 20.00.h),
                      CustomTextButton(
                        text: 'تسجيل الخروج',
                        function: () {
                          logout(context);
                        },
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
}
