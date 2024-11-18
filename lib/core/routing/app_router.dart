import 'package:flutter/material.dart';
import 'package:meshwar/core/routing/routes.dart';
import 'package:meshwar/presentation/auth/login/login_screen.dart';
import 'package:meshwar/presentation/auth/register/ask_user_role/ask_user_role.dart';
import 'package:meshwar/presentation/auth/register/captain/captain_register_screen.dart';
import 'package:meshwar/presentation/auth/register/passenger/passenger_register_screen.dart';
import 'package:meshwar/presentation/auth/waiting_screen/waiting_screen.dart';
import 'package:meshwar/presentation/home/passenger/screen/passenger_home_screen.dart';
import 'package:meshwar/presentation/home/passenger/widget/passenger_carpool/build_new_carpool/screen/passenger_build_new_carpool.dart';
import 'package:meshwar/presentation/home/passenger/widget/passenger_carpool/my_carpools/screen/passenger_build_my_carpools.dart';
import 'package:meshwar/presentation/home/passenger/widget/passenger_carpool/my_current_carpools/screens/passenger_build_my_current_carpools.dart';
import 'package:meshwar/presentation/home/passenger/widget/passenger_carpool/passenger_carpool.dart';
import 'package:meshwar/presentation/home/passenger/widget/passenger_carpool/rate_carpool/screen/passenger_build_rate_carpools.dart';
import 'package:meshwar/presentation/home/passenger/widget/passenger_personal_page/screen/passenger_personal_page.dart';
import 'package:meshwar/presentation/home/passenger/widget/passenger_trips/passenger_accepted_trips/passenger_accepted_trips.dart';
import 'package:meshwar/presentation/home/passenger/widget/passenger_trips/passenger_finished_trips/passenger_finished_trips.dart';
import 'package:meshwar/presentation/home/passenger/widget/passenger_trips/passenger_request_trips/screen/passenger_request_trips.dart';
import 'package:meshwar/presentation/home/passenger/widget/passenger_trips/passenger_trips.dart';
import 'package:meshwar/presentation/start/start_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      // start screen
      case Routes.startScreen:
        return MaterialPageRoute(
          builder: (context) => const StartScreen(),
        );

      // auth routes
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
        );

      case Routes.waitingScreen:
        return MaterialPageRoute(
          builder: (context) => const WaitingScreen(),
        );

      case Routes.askUserRole:
        return MaterialPageRoute(
          builder: (context) => const AskUserRole(),
        );

      case Routes.passengerRegister:
        return MaterialPageRoute(
          builder: (context) => const PassengerRegisterScreen(),
        );

      case Routes.captainRegister:
        return MaterialPageRoute(
          builder: (context) => const CaptainRegisterScreen(),
        );

      // home passenger
      case Routes.passengerHome:
        return MaterialPageRoute(
          builder: (context) => PassengerHomeScreen(),
        );

      // home passenger ==> carpool section
      case Routes.passengerCarpool:
        return MaterialPageRoute(
          builder: (context) => const PassengerCarpool(),
        );

      case Routes.passengerBuildNewCarpool:
        return MaterialPageRoute(
          builder: (context) => const PassengerBuildNewCarpool(),
        );

      case Routes.passengerBuildMyCarpools:
        return MaterialPageRoute(
          builder: (context) => const PassengerBuildMyCarpools(),
        );

      case Routes.passengerBuildMyCurrentCarpools:
        return MaterialPageRoute(
          builder: (context) => const PassengerBuildMyCurrentCarpools(),
        );

      case Routes.passengerBuildRateCarpool:
        return MaterialPageRoute(
          builder: (context) => const PassengerBuildRateCarpools(),
        );

      // home passenger ==> personal page section
      case Routes.passengerPersonalPage:
        return MaterialPageRoute(
          builder: (context) => const PassengerPersonalPage(),
        );

      // home passenger ==> trips page section
      case Routes.passengerTrips:
        return MaterialPageRoute(
          builder: (context) => const PassengerTrips(),
        );

      case Routes.passengerRequestTrips:
        return MaterialPageRoute(
          builder: (context) => const PassengerRequestTrips(),
        );

      case Routes.passengerAcceptedTrips:
        return MaterialPageRoute(
          builder: (context) => const PassengerAcceptedTrips(),
        );

      case Routes.passengerFinishedTrips:
        return MaterialPageRoute(
          builder: (context) => const PassengerFinishedTrips(),
        );
    }
    return null;
  }
}
