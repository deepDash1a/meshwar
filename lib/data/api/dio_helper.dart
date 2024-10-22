import 'package:dio/dio.dart';
import 'package:meshwar/core/shared/shared_preferences/shared_preferences.dart';
import 'package:meshwar/core/shared/shared_preferences/shared_preferences_keys.dart';
import 'package:meshwar/data/api/end_points.dart';

class DioHelper {
  static Dio? dio;

  // Initialize Dio
  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: EndPoints.baseUrl,
        receiveDataWhenStatusError: true,
        connectTimeout: const Duration(milliseconds: 5000),
        receiveTimeout: const Duration(milliseconds: 5000),
      ),
    );
  }

  // GET request
  Future<Response> getData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    SharedPreferencesService.getData(key: SharedPreferencesKeys.userToken) !=
            null
        ? dio!.options.headers['Authorization'] =
            'Bearer ${SharedPreferencesService.getData(key: SharedPreferencesKeys.userToken)}'
        : null;

    return await dio!.get(url, queryParameters: query);
  }

  // POST request
  Future<Response> postData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    bool isFormData = false,
  }) async {
    SharedPreferencesService.getData(key: SharedPreferencesKeys.userToken) !=
            null
        ? dio!.options.headers['Authorization'] =
            'Bearer ${SharedPreferencesService.getData(key: SharedPreferencesKeys.userToken)}'
        : null;

    return await dio!.post(
      url,
      queryParameters: query,
      data: isFormData ? FormData.fromMap(data) : data,
    );
  }

  // PUT request
  Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
    Map<String, dynamic>? query,
    bool isFormData = false,
  }) async {
    SharedPreferencesService.getData(key: SharedPreferencesKeys.userToken) !=
            null
        ? dio!.options.headers['Authorization'] =
            'Bearer ${SharedPreferencesService.getData(key: SharedPreferencesKeys.userToken)}'
        : null;

    return await dio!.put(
      url,
      queryParameters: query,
      data: isFormData ? FormData.fromMap(data) : data,
    );
  }

  // DELETE request
  Future<Response> deleteData({
    required String url,
    Map<String, dynamic>? query,
  }) async {
    SharedPreferencesService.getData(key: SharedPreferencesKeys.userToken) !=
            null
        ? dio!.options.headers['Authorization'] =
            'Bearer ${SharedPreferencesService.getData(key: SharedPreferencesKeys.userToken)}'
        : null;

    return await dio!.delete(
      url,
      queryParameters: query,
    );
  }
}
