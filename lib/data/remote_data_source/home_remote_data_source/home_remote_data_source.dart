import 'package:dio/dio.dart';
import 'package:meshwar/data/api/dio_helper.dart';
import 'package:meshwar/data/api/end_points.dart';

class HomeRemoteDataSource {
  final DioHelper dioHelper;

  HomeRemoteDataSource(this.dioHelper);

  Future<Response> getProfileData() async {
    try {
      final response = dioHelper.getData(url: EndPoints.profile);
      return response;
    } catch (error) {
      rethrow;
    }
  }
}
