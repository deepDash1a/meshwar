import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meshwar/core/shared/functions/functions.dart';
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
      final response = await dioHelper.postData(
        url: EndPoints.login,
        data: {
          'email': email,
          'password': password,
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

  Future<Response> register(
    String? walletNumber,
    String? bankAccountNumber,
    String? expirationLicenseDate,
    XFile? graduationCertificateImage,
    XFile? profileImage, {
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String whatsappNumber,
    required String anotherNumber,
    required String country,
    required String city,
    required String region,
    required String building,
    required String floor,
    required String flat,
    required XFile nationalIdFrontImage,
    required XFile nationalIdBackImage,
    required XFile licenseFrontImage,
    required XFile licenseBackImage,
    required XFile militaryCertificateImage,
    required XFile birthCertificate,
    required XFile feshTshbeeh,
  }) async {
    try {
      // nullable files of images
      File? graduationCertificateImageFile;
      if (graduationCertificateImage != null) {
        graduationCertificateImageFile = File(graduationCertificateImage.path);
      }

      File? profileImageFile;
      if (profileImage != null) {
        profileImageFile = File(profileImage.path);
      }

      // required files of images
      final nationalIdFrontImageFile = File(nationalIdFrontImage.path);
      final nationalIdBackImageFile = File(nationalIdBackImage.path);
      final licenseFrontImageFile = File(licenseFrontImage.path);
      final licenseBackImageFile = File(licenseBackImage.path);
      final militaryCertificateImageFile = File(militaryCertificateImage.path);
      final birthCertificateFile = File(birthCertificate.path);
      final feshTshbeehFile = File(feshTshbeeh.path);

      final response = await dioHelper.postData(
        url: EndPoints.register,
        isFormData: true,
        data: {
          'first_name': firstName,
          'last_name': lastName,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
          'whatsapp_number': whatsappNumber,
          'another_number': anotherNumber,
          'address': '$country - $city - $region - $building - $floor - $flat',
          'wallet_number': walletNumber,
          'bank_account_number': bankAccountNumber,
          'expiration_license_date': expirationLicenseDate,
          'national_id_front_image': await MultipartFile.fromFile(
            nationalIdFrontImageFile.path,
            filename: path.basename(nationalIdFrontImageFile.path),
          ),
          'national_id_back_image': await MultipartFile.fromFile(
            nationalIdBackImageFile.path,
            filename: path.basename(nationalIdBackImageFile.path),
          ),
          'license_front_image': await MultipartFile.fromFile(
            licenseFrontImageFile.path,
            filename: path.basename(licenseFrontImageFile.path),
          ),
          'license_back_image': await MultipartFile.fromFile(
            licenseBackImageFile.path,
            filename: path.basename(licenseBackImageFile.path),
          ),
          if (graduationCertificateImageFile != null)
            'graduation_certificate_image': await MultipartFile.fromFile(
              graduationCertificateImageFile.path,
              filename: path.basename(graduationCertificateImageFile.path),
            ),
          'military_certificate_image': await MultipartFile.fromFile(
            militaryCertificateImageFile.path,
            filename: path.basename(militaryCertificateImageFile.path),
          ),
          'birth_certificate': await MultipartFile.fromFile(
            birthCertificateFile.path,
            filename: path.basename(birthCertificateFile.path),
          ),
          'fesh_tshbeeh': await MultipartFile.fromFile(
            feshTshbeehFile.path,
            filename: path.basename(feshTshbeehFile.path),
          ),
          if (profileImageFile != null)
            'profile_image': await MultipartFile.fromFile(
              profileImageFile.path,
              filename: path.basename(profileImageFile.path),
            ),
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

  Future<Response> sendFCMToken({
    required String fcmToken,
  }) async {
    try {
      final response = await dioHelper.postData(
        url: EndPoints.fcmToken,
        data: {
          'fcm_token': fcmToken,
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
}
