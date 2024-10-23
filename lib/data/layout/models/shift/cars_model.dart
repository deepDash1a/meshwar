import 'package:equatable/equatable.dart';
import 'package:meshwar/core/shared/shared_models/base_response_model.dart';

class GetAllCarsModel extends BaseResponseModel<List<CarType>> {
  const GetAllCarsModel({
    required super.status,
    required super.message,
    super.body,
  });

  factory GetAllCarsModel.fromJson(Map<String, dynamic> json) {
    return GetAllCarsModel(
      status: json['status'],
      message: json['message'],
      body: List<CarType>.from(json['car_types'].map(
        (e) => CarType.fromJson(e),
      )).toList(),
    );
  }
}

class CarType extends Equatable {
  final int userId;
  final String firstName;
  final String lastName;
  final String whatsappNumber;
  final int carTypeId;
  final String carType;
  final String carMake;
  final String carModel;

  const CarType({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.whatsappNumber,
    required this.carTypeId,
    required this.carType,
    required this.carMake,
    required this.carModel,
  });

  factory CarType.fromJson(Map<String, dynamic> json) {
    return CarType(
      userId: json['user_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      whatsappNumber: json['whatsapp_number'],
      carTypeId: json['car_type_id'],
      carType: json['car_type'],
      carMake: json['car_make'],
      carModel: json['car_model'],
    );
  }

  // Method to convert a CarType object to JSON
  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'first_name': firstName,
      'last_name': lastName,
      'whatsapp_number': whatsappNumber,
      'car_type_id': carTypeId,
      'car_type': carType,
      'car_make': carMake,
      'car_model': carModel,
    };
  }

  @override
  List<Object?> get props => [
        userId,
        firstName,
        lastName,
        whatsappNumber,
        carTypeId,
        carType,
        carMake,
        carModel,
      ];
}
