import 'package:meshwar/core/shared/shared_models/base_response_model.dart';

class ShiftModel extends BaseResponseModel<Shift> {
  const ShiftModel({
    required super.status,
    required super.message,
    super.body,
  });

  factory ShiftModel.fromJson(Map<String, dynamic> json) {
    return ShiftModel(
      status: json['status'],
      message: json['message'],
      body: Shift.fromJson(json['shift']),
    );
  }
}

class Shift {
  int? carTypeId;
  int? odometerReading;
  String? location;
  double? latitude;
  double? longitude;
  String? startDate;
  int? userId;
  String? imageOdometerReading;
  String? updatedAt;
  String? createdAt;
  int? id;

  Shift(
      {this.carTypeId,
      this.odometerReading,
      this.location,
      this.latitude,
      this.longitude,
      this.startDate,
      this.userId,
      this.imageOdometerReading,
      this.updatedAt,
      this.createdAt,
      this.id});

  Shift.fromJson(Map<String, dynamic> json) {
    carTypeId = json['car_type_id'];
    odometerReading = json['odometer_reading'];
    location = json['location'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    startDate = json['start_date'];
    userId = json['user_id'];
    imageOdometerReading = json['image_odometer_reading'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['car_type_id'] = this.carTypeId;
    data['odometer_reading'] = this.odometerReading;
    data['location'] = this.location;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    data['start_date'] = this.startDate;
    data['user_id'] = this.userId;
    data['image_odometer_reading'] = this.imageOdometerReading;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
