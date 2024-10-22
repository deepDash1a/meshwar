import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:meshwar/core/routing/routes.dart';
import 'package:meshwar/core/shared/shared_preferences/shared_preferences.dart';
import 'package:meshwar/core/shared/shared_preferences/shared_preferences_keys.dart';
import 'package:meshwar/core/theme/colors/colors.dart';
import 'package:meshwar/core/theme/fonts/fonts.dart';

// Function to show Snack Bar
void customSnackBar({
  required BuildContext context,
  required String text,
  required Color color,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: color,
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 14.00.sp,
          color: ColorsManager.white,
          fontFamily: FontNamesManager.bold,
        ),
      ),
    ),
  );
}

Response handleStatusCode(Response response) {
  switch (response.statusCode) {
    case 200:
      return response; // Success
    case 400:
      throw Exception('Bad request: Invalid input.');
    case 401:
      throw Exception('Unauthorized: Invalid credentials.');
    case 403:
      throw Exception('Forbidden: Access denied.');
    case 404:
      throw Exception('Not Found: The endpoint was not found.');
    case 500:
      throw Exception(
          'Internal Server Error: Something went wrong on the server.');
    default:
      throw Exception('Unexpected error: ${response.statusCode}');
  }
}

logout(BuildContext context) {
  Navigator.pushReplacementNamed(context, Routes.login);
  SharedPreferencesService.removeData(key: SharedPreferencesKeys.userToken);
  SharedPreferencesService.removeData(key: SharedPreferencesKeys.fcmToken);
}
