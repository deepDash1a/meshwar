import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meshwar/business_logic/authentication/cubit/cubit.dart';
import 'package:meshwar/business_logic/layout/cubit/cubit.dart';
import 'package:meshwar/core/di/dependency_injection.dart';
import 'package:meshwar/core/routing/app_router.dart';
import 'package:meshwar/core/routing/routes.dart';
import 'package:meshwar/core/shared/shared_preferences/shared_preferences.dart';
import 'package:meshwar/core/shared/shared_preferences/shared_preferences_keys.dart';
import 'package:meshwar/core/theme/colors/colors.dart';

// ignore: must_be_immutable
class MeshwarApp extends StatelessWidget {
  MeshwarApp({super.key, required this.appRouter});

  AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => getIt<AuthenticationAppCubit>(),
          ),
          BlocProvider(
            create: (context) => getIt<LayoutAppCubit>()
              ..getProfileData()
              ..getNotifications(),
          ),
        ],
        child: MaterialApp(
          title: 'Meshwar',
          localizationsDelegates: const [
            GlobalCupertinoLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale(
              "ar",
            ),
          ],
          locale: const Locale(
            "ar",
          ),
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: ColorsManager.mainAppColor,
            ),
            appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: ColorsManager.mainAppColor,
                statusBarIconBrightness: Brightness.light,
              ),
              backgroundColor: ColorsManager.mainAppColor,
            ),
            scaffoldBackgroundColor: ColorsManager.white,
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: getStarted(),
          onGenerateRoute: appRouter.generateRoute,
        ),
      ),
    );
  }

  String getStarted() {
    if (SharedPreferencesService.getData(key: SharedPreferencesKeys.start) ==
        null) {
      return Routes.start;
    } else if (SharedPreferencesService.getData(
            key: SharedPreferencesKeys.userToken) ==
        null) {
      return Routes.login;
    } else {
      return Routes.layout;
    }
  }
}
