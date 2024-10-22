import 'package:flutter/material.dart';
import 'package:meshwar/core/routing/routes.dart';
import 'package:meshwar/presentation/authentication/login/screen/login_screen.dart';
import 'package:meshwar/presentation/authentication/register/screen/register_screen.dart';
import 'package:meshwar/presentation/authentication/waiting/screens/waiting_screen.dart';
import 'package:meshwar/presentation/layout/screens/layout_screen.dart';
import 'package:meshwar/presentation/layout/widgets/home/screens/home.dart';
import 'package:meshwar/presentation/layout/widgets/home/widgets/messages.dart';
import 'package:meshwar/presentation/layout/widgets/maps/screens/maps.dart';
import 'package:meshwar/presentation/layout/widgets/personal/screens/personal_screen.dart';
import 'package:meshwar/presentation/start/screen/start_screen.dart';

class AppRouter {
  Route? generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      // start route
      case Routes.start:
        return MaterialPageRoute(
          builder: (_) => const StartScreen(),
        );

      // auth routes
      case Routes.login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case Routes.register:
        return MaterialPageRoute(
          builder: (_) => const RegisterScreen(),
        );
      case Routes.waiting:
        return MaterialPageRoute(
          builder: (_) => const WaitingScreen(),
        );

      // layout routes
      case Routes.layout:
        return MaterialPageRoute(
          builder: (_) => const LayoutScreen(),
        );
      case Routes.home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      case Routes.personal:
        return MaterialPageRoute(
          builder: (_) => const PersonalScreen(),
        );
      case Routes.maps:
        return MaterialPageRoute(
          builder: (_) => const MapScreen(),
        );
      case Routes.messages:
        return MaterialPageRoute(
          builder: (_) => const MessagesScreen(),
        );
    }
    return null;
  }
}
