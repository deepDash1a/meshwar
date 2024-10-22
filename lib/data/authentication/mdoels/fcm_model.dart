import 'package:meshwar/core/shared/shared_models/base_response_model.dart';

class FcmModel extends BaseResponseModel {
  const FcmModel({
    required super.status,
    required super.message,
  });

  factory FcmModel.fromJson(Map<String, dynamic> json) {
    return FcmModel(
      status: json['status'],
      message: json['message'],
    );
  }
}
