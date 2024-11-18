import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meshwar/data/api/dio_helper.dart';
import 'package:meshwar/data/api/end_points.dart';
import 'package:path/path.dart' as path;

class AuthRemoteDataSource {
  final DioHelper dioHelper;

  AuthRemoteDataSource(this.dioHelper);

  Future<Response> login({
    required String email,
    required String password,
  }) async {
    try {
      Response response = await dioHelper.postData(
        url: EndPoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> forgetPassword({
    required String email,
  }) async {
    try {
      Response response = await dioHelper.postData(
        url: EndPoints.forgetPassword,
        data: {
          'email': email,
        },
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> passengerRegistration({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String confirmPassword,
    required String whatsAppNumber,
    required String anotherNumber,
    required XFile profileImage,
    required String role,
    required String governorate,
    required String residentialArea,
    required String neighborhood,
    required String street,
    required String building,
    required String distinctiveMark,
    required XFile faceIdCard,
    required XFile backIdCard,
    required String expireOfIdCard,
    required String isDataCorrect,
    required String isPassengerSmocking,
    required String isPassengerPunctual,
  }) async {
    final profileImageFile = File(profileImage.path);
    final faceIdCardFile = File(faceIdCard.path);
    final backIdCardFile = File(backIdCard.path);

    var data = {
      'name': '$firstName $lastName',
      'email': email,
      'password': password,
      'password_confirmation': confirmPassword,
      'whatsapp_number': whatsAppNumber,
      'another_number': anotherNumber,
      'profile_image': await MultipartFile.fromFile(
        profileImageFile.path,
        filename: path.basename(profileImageFile.path),
      ),
      'role': role,
      'province': governorate,
      'district': residentialArea,
      'sub_district': neighborhood,
      'street': street,
      'building': building,
      'landmark': distinctiveMark,
      'national_id_front_image': await MultipartFile.fromFile(
        faceIdCardFile.path,
        filename: path.basename(faceIdCardFile.path),
      ),
      'national_id_back_image': await MultipartFile.fromFile(
        backIdCardFile.path,
        filename: path.basename(backIdCardFile.path),
      ),
      'expiration_national_id_date': expireOfIdCard,
      'agrees_info_correct': isDataCorrect,
      'agrees_no_smoking': isPassengerSmocking,
      'agrees_on_schedule': isPassengerPunctual,
    };

    print('Dattttta: $data');
    try {
      Response response = await dioHelper.postData(
        url: EndPoints.register,
        isFormData: true,
        data: data,
      );
      return response;
    } catch (error) {
      rethrow;
    }
  }
}
