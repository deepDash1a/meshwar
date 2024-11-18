import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meshwar/business_logic/auth_cubit/auth_cubit.dart';
import 'package:meshwar/business_logic/carpool_cubit/carpool_cubit.dart';
import 'package:meshwar/business_logic/home_cubit/home_cubit.dart';
import 'package:meshwar/business_logic/trip_cubit/trip_cubit.dart';
import 'package:meshwar/core/di/di.dart';
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
          BlocProvider(create: (context) => getIt<AuthCubit>()),
          BlocProvider(
              create: (context) => getIt<HomeCubit>()..getProfileData()),
          BlocProvider(create: (context) => getIt<CarpoolCubit>()),
          BlocProvider(create: (context) => getIt<TripCubit>()),
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
              seedColor: ColorsManager.darkOrange,
            ),
            appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarColor: ColorsManager.darkOrange,
                statusBarIconBrightness: Brightness.light,
              ),
              backgroundColor: ColorsManager.darkOrange,
            ),
            scaffoldBackgroundColor: ColorsManager.white,
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: getStart(),
          onGenerateRoute: appRouter.generateRoute,
        ),
      ),
    );
  }

  String getStart() {
    final route = SharedPreferencesService.getData(
                key: SharedPreferencesKeys.startScreen) ==
            null
        ? Routes.startScreen
        : SharedPreferencesService.getData(
                    key: SharedPreferencesKeys.userToken) ==
                null
            ? Routes.loginScreen
            : Routes.passengerHome;

    return route;
  }
}
