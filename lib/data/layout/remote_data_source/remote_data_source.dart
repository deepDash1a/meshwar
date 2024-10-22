import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meshwar/core/shared/functions/functions.dart';
import 'package:meshwar/data/api/dio_helper.dart';
import 'package:meshwar/data/api/end_points.dart';
import 'package:meshwar/data/layout/models/maps/place_details_model.dart';
import 'package:meshwar/data/layout/models/maps/place_suggestions.dart';
import 'package:path/path.dart' as path;

class LayoutRemoteDataSource {
  final DioHelper dioHelper;

  LayoutRemoteDataSource(this.dioHelper);

  // home
  Future<Response> getNotifications() async {
    try {
      final response = await dioHelper.getData(
        url: EndPoints.getNotifications,
      );

      return handleStatusCode(response);
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          throw Exception(
              'Error: ${e.response?.statusCode} - ${e.response?.statusMessage}');
        } else {
          throw Exception('Error: ${e.message}');
        }
      } else {
        throw Exception('Failed to log in: $e');
      }
    }
  }

  Future<Response> acceptTrip() async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.acceptTrip,
        data: {},
      );

      return handleStatusCode(response);
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          throw Exception(
              'Error: ${e.response?.statusCode} - ${e.response?.statusMessage}');
        } else {
          throw Exception('Error: ${e.message}');
        }
      } else {
        throw Exception('Failed to log in: $e');
      }
    }
  }

  Future<Response> startTrip() async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.startTrip,
        data: {},
      );

      return handleStatusCode(response);
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          throw Exception(
              'Error: ${e.response?.statusCode} - ${e.response?.statusMessage}');
        } else {
          throw Exception('Error: ${e.message}');
        }
      } else {
        throw Exception('Failed to log in: $e');
      }
    }
  }

  // shift
  Future<Response> startShift(
    XFile? odometerImage, {
    required int carTypeId,
    required String odometerStart,
    required String locationName,
    required double latitude,
    required double longitude,
  }) async {
    try {
      File? odometerImageFile;
      if (odometerImage != null) {
        odometerImageFile = File(odometerImage.path);
      }

      final response = await dioHelper.postData(
        url: EndPoints.startShift,
        isFormData: true,
        data: {
          'car_type_id': carTypeId,
          'odometerStart': odometerStart,
          'locationName': locationName,
          'latitude': latitude,
          'longitude': longitude,
          if (odometerImageFile != null)
            'odometerImage': await MultipartFile.fromFile(
              odometerImageFile.path,
              filename: path.basename(odometerImageFile.path),
            )
        },
      );

      return handleStatusCode(response);
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          throw Exception(
              'Error: ${e.response?.statusCode} - ${e.response?.statusMessage}');
        } else {
          throw Exception('Error: ${e.message}');
        }
      } else {
        throw Exception('Failed to log in: $e');
      }
    }
  }

  // map
  Future<List<dynamic>> getSuggestions(String place) async {
    try {
      Response response = await dioHelper.getData(
        url: 'https://maps.googleapis.com/maps/api/place/textsearch/json',
        query: {
          'query': place,
          'type': 'address',
          'components': 'country:eg',
          'key': 'AIzaSyBtpz1PYwlJoXX_OC4Mpi9-h4mDzyPZGvM',
        },
      );
      return response.data['results']
          .map((e) => PlacesSuggestion.fromJson(e))
          .toList();
    } catch (e) {
      return [];
    }
  }

  Future<dynamic> getPlaceLocation(String placeId) async {
    try {
      Response response = await dioHelper.getData(
        url: 'https://maps.googleapis.com/maps/api/place/details/json',
        query: {
          'place_id': placeId,
          'fields': 'geometry',
          'key': 'AIzaSyBtpz1PYwlJoXX_OC4Mpi9-h4mDzyPZGvM',
        },
      );
      return Place.fromJson(response.data);
    } catch (e) {
      return Future.error(
        'Place error: ',
        StackTrace.fromString('this is trace'),
      );
    }
  }

  // personal
  Future<Response> getProfileData() async {
    try {
      final response = await dioHelper.getData(
        url: EndPoints.getProfile,
      );

      return handleStatusCode(response);
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          throw Exception(
              'Error: ${e.response?.statusCode} - ${e.response?.statusMessage}');
        } else {
          throw Exception('Error: ${e.message}');
        }
      } else {
        throw Exception('Failed to log in: $e');
      }
    }
  }

  Future<Response> logout() async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.logout,
        data: {},
      );

      return handleStatusCode(response);
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          throw Exception(
              'Error: ${e.response?.statusCode} - ${e.response?.statusMessage}');
        } else {
          throw Exception('Error: ${e.message}');
        }
      } else {
        throw Exception('Failed to log in: $e');
      }
    }
  }

  Future<Response> updateProfile(
    XFile? profileImage, {
    required String firstName,
    required String lastName,
    required String email,
    required String whatsAppNumber,
    required String anotherNumber,
    required String address,
  }) async {
    try {
      File? profileImageFile;
      if (profileImage != null) {
        profileImageFile = File(profileImage.path);
      }

      final response = await dioHelper.postData(
        url: EndPoints.updateProfile,
        data: {
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'whatsapp_number': whatsAppNumber,
          'another_number': anotherNumber,
          'address': address,
          if (profileImageFile != null)
            'profile_image': await MultipartFile.fromFile(
              profileImageFile.path,
              filename: path.basename(profileImageFile.path),
            )
        },
      );

      return handleStatusCode(response);
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
          throw Exception(
              'Error: ${e.response?.statusCode} - ${e.response?.statusMessage}');
        } else {
          throw Exception('Error: ${e.message}');
        }
      } else {
        throw Exception('Failed to log in: $e');
      }
    }
  }
}
