import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meshwar/core/di/di.dart';
import 'package:meshwar/core/routing/app_router.dart';
import 'package:meshwar/core/shared/bloc_observer/bloc_observer.dart';
import 'package:meshwar/core/shared/location_helper/location_helper.dart';
import 'package:meshwar/core/shared/notification_helper/notification_helper.dart';
import 'package:meshwar/core/shared/shared_preferences/shared_preferences.dart';
import 'package:meshwar/core/theme/colors/colors.dart';
import 'package:meshwar/meshwar.dart';

import 'firebase_options.dart';

void main() async {
  setupServiceLocator();
  Bloc.observer = MyBlocObserver();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FCMNotificationService().init();
  await LocationHelper.getCurrentAddress();
  await SharedPreferencesService.init();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: ColorsManager.darkOrange,
    ),
  );
  runApp(MeshwarApp(
      appRouter: AppRouter()
  ));
}
