import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meshwar/business_logic/home_cubit/home_cubit.dart';
import 'package:meshwar/core/routing/routes.dart';
import 'package:meshwar/core/shared/shared_preferences/shared_preferences.dart';
import 'package:meshwar/core/shared/shared_preferences/shared_preferences_keys.dart';
import 'package:meshwar/core/shared/widgets/custom_button.dart';
import 'package:meshwar/core/shared/widgets/custom_text.dart';
import 'package:meshwar/core/shared/widgets/custom_text_button.dart';
import 'package:meshwar/core/theme/colors/colors.dart';
import 'package:meshwar/core/theme/fonts/fonts.dart';
import 'package:meshwar/core/theme/images/images.dart';
import 'package:meshwar/data/models/home_models/instruction_model.dart';
import 'package:meshwar/data/models/home_models/messages_model.dart';
import 'package:meshwar/presentation/home/passenger/widget/passenger_instruction/instruction_item.dart';

//ignore: must_be_immutable
class PassengerHomeScreen extends StatelessWidget {
  PassengerHomeScreen({super.key});

  List<InstructionModel> instructionListItems = [
    InstructionModel(image: ImagesManager.car, title: 'السيارة'),
    InstructionModel(image: ImagesManager.driver, title: 'السائق'),
    InstructionModel(image: ImagesManager.passengers, title: 'الركاب'),
    InstructionModel(image: ImagesManager.info, title: 'معلومات عامة'),
  ];
  List<MessagesModel> messagesListItems = [
    MessagesModel(
      title: 'عنوان أول',
      content: 'محتوى أول',
      isRead: false,
      isFav: false,
    ),
    MessagesModel(
      title: 'عنوان ثانِ',
      content: 'محتوى ثانِ',
      isRead: false,
      isFav: false,
    ),
    MessagesModel(
      title: 'عنوان ثالث',
      content: 'محتوى ثالث',
      isRead: false,
      isFav: false,
    ),
    MessagesModel(
      title: 'عنوان رابع',
      content: 'محتوى رابع',
      isRead: false,
      isFav: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<HomeCubit>();

    Widget buildInstructionItem(InstructionModel model) {
      return SizedBox(
        width: 100.00.w,
        height: 100.00.h,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InstructionsDetails(title: model.title),
              ),
            );
          },
          child: Card(
            color: ColorsManager.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  model.image,
                  height: 40.00.h,
                ),
                SizedBox(height: 5.00.h),
                Flexible(
                  child: CustomText(
                    text: model.title,
                    color: ColorsManager.darkOrange,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget buildMessageItem(MessagesModel model) {
      return SizedBox(
        width: 100.00.w,
        child: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Card(
              color: ColorsManager.white,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(
                      text: model.title,
                      color: ColorsManager.darkOrange,
                      fontFamily: FontManager.extraBold,
                    ),
                    SizedBox(height: 5.0.h),
                    Center(child: CustomText(text: model.content)),
                    SizedBox(height: 5.0.h),
                    Row(
                      children: [
                        Checkbox(
                          value: model.isRead,
                          onChanged: (value) {
                            cubit.changeVisibilityTrueOrFalse(
                              currentVisibility: model.isRead,
                              updateVisibility: (value) {
                                model.isRead = value;
                              },
                            );
                          },
                        ),
                        const CustomText(text: 'قُرأت')
                      ],
                    )
                  ],
                ),
              ),
            );
          },
        ),
      );
    }

    Widget drawerItem(String image, String title, Function onPressed) {
      return Card(
        color: ColorsManager.white,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0.w, vertical: 10.00.h),
          child: InkWell(
            onTap: () {
              onPressed();
            },
            child: Row(
              children: [
                SvgPicture.asset(
                  image,
                  height: 30.00.h,
                ),
                Expanded(
                  child: CustomText(text: title),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {},
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            drawer: Drawer(
              backgroundColor: ColorsManager.white,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.00.w,
                  vertical: 16.00.h,
                ),
                child: Column(
                  children: [
                    cubit.profileModel == null
                        ? const Center(
                            child: CircularProgressIndicator.adaptive(),
                          )
                        : Row(
                            children: [
                              CircleAvatar(
                                radius: 30.r,
                                backgroundImage: const NetworkImage(
                                    'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?t=st=1731512488~exp=1731516088~hmac=4607d9e5fb1491cc99c0a9fd3de1bac70f4d8c8f37079e9ea3894dcc36b29457&w=1380'),
                              ),
                              SizedBox(
                                width: 20.00.w,
                              ),
                              Expanded(
                                child: CustomText(
                                  fontSize: 16.00.sp,
                                  text: '${cubit.profileModel!.body!.name}',
                                ),
                              ),
                            ],
                          ),
                    SizedBox(height: 50.00.h),
                    drawerItem(
                      ImagesManager.home,
                      'الصفحة الرئيسية',
                      () {
                        Navigator.pop(context);
                      },
                    ),
                    SizedBox(height: 20.00.h),
                    drawerItem(
                      ImagesManager.trip,
                      'الرحلات',
                      () {
                        Navigator.pop(context);
                        Navigator.pushNamed(
                          context,
                          Routes.passengerTrips,
                        );
                      },
                    ),
                    SizedBox(height: 20.00.h),
                    drawerItem(
                      ImagesManager.person,
                      'الصفحة الشخصية',
                      () {
                        Navigator.pop(context);
                        Navigator.pushNamed(
                          context,
                          Routes.passengerPersonalPage,
                        );
                      },
                    ),
                    SizedBox(height: 20.00.h),
                    drawerItem(
                      ImagesManager.logOut,
                      'تسجيل الخروج',
                      () {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const CustomText(
                                text: 'هل تريد حقًا تسجيل الخروج'),
                            actions: [
                              CustomTextButton(
                                text: 'لا',
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                              CustomTextButton(
                                text: 'نعم',
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pushReplacementNamed(
                                    context,
                                    Routes.loginScreen,
                                  );
                                  SharedPreferencesService.removeData(
                                    key: SharedPreferencesKeys.userToken,
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Builder(builder: (context) {
                          return IconButton(
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                            icon: SvgPicture.asset(
                              ImagesManager.menu,
                              height: 30.00.h,
                            ),
                          );
                        }),
                        cubit.profileModel == null
                            ? const Center(
                                child: CircularProgressIndicator.adaptive(),
                              )
                            : Expanded(
                                child: Column(
                                  children: [
                                    CustomText(
                                      text: '${cubit.profileModel!.body!.name}',
                                      color: ColorsManager.darkOrange,
                                    ),
                                    CustomText(
                                      text:
                                          '${cubit.profileModel!.body!.whatsappNumber}',
                                      color: ColorsManager.grey,
                                    ),
                                  ],
                                ),
                              ),
                        cubit.profileModel == null
                            ? const Center(
                                child: CircularProgressIndicator.adaptive(),
                              )
                            : CircleAvatar(
                                radius: 30.r,
                                backgroundImage: const NetworkImage(
                                    'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?t=st=1731512488~exp=1731516088~hmac=4607d9e5fb1491cc99c0a9fd3de1bac70f4d8c8f37079e9ea3894dcc36b29457&w=1380'),
                              ),
                      ],
                    ),
                    SizedBox(height: 20.00.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        CustomText(
                          text: 'التعليمات',
                          color: ColorsManager.darkOrange,
                          fontSize: 16.00.sp,
                          fontFamily: FontManager.extraBold,
                        ),
                        const Spacer(),
                        CustomButton(
                          text: 'دورات كاربول',
                          onPressed: () {
                            Navigator.pushNamed(
                                context, Routes.passengerCarpool);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 20.00.h),
                    SizedBox(
                      height: 100.00.h,
                      child: ListView.separated(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => buildInstructionItem(
                          instructionListItems[index],
                        ),
                        separatorBuilder: (context, index) => SizedBox(
                          width: 10.00.w,
                        ),
                        itemCount: instructionListItems.length,
                      ),
                    ),
                    SizedBox(height: 20.00.h),
                    CustomText(
                      text: 'رسائل من الإدارة',
                      color: ColorsManager.darkOrange,
                      fontFamily: FontManager.extraBold,
                      fontSize: 16.00.sp,
                    ),
                    SizedBox(height: 20.00.h),
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) => buildMessageItem(
                        messagesListItems[index],
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        width: 10.00.w,
                      ),
                      itemCount: messagesListItems.length,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
