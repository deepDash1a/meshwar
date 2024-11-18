import 'package:meshwar/core/shared/shared_models/base_response_model.dart';

class ProfileModel extends BaseResponseModel<User> {
  const ProfileModel({
    required super.status,
    required super.message,
    super.body,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      status: json['status'],
      message: json['message'],
      body: User.fromJson(json['user']),
    );
  }
}

class User {
  int? id;
  String? name;
  String? whatsappNumber;
  String? anotherNumber;
  String? profileImage;
  String? email;
  String? emailVerifiedAt;
  String? role;
  String? status;
  String? createdAt;
  String? updatedAt;
  Passenger? passenger;

  User({
    this.id,
    this.name,
    this.whatsappNumber,
    this.anotherNumber,
    this.profileImage,
    this.email,
    this.emailVerifiedAt,
    this.role,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.passenger,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    whatsappNumber = json['whatsapp_number'];
    anotherNumber = json['another_number'];
    profileImage = json['profile_image'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    role = json['role'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    passenger = json['passenger'] != null
        ? Passenger.fromJson(json['passenger'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['whatsapp_number'] = whatsappNumber;
    data['another_number'] = anotherNumber;
    data['profile_image'] = profileImage;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['role'] = role;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (passenger != null) {
      data['passenger'] = passenger!.toJson();
    }
    return data;
  }
}

class Passenger {
  int? id;
  String? province;
  String? district;
  String? subDistrict;
  String? street;
  String? building;
  String? landmark;
  String? nationalIdFrontImage;
  String? nationalIdBackImage;
  String? expirationNationalIdDate;
  int? agreesInfoCorrect;
  int? agreesNoSmoking;
  int? agreesOnSchedule;
  int? userId;
  String? createdAt;
  String? updatedAt;

  Passenger({
    this.id,
    this.province,
    this.district,
    this.subDistrict,
    this.street,
    this.building,
    this.landmark,
    this.nationalIdFrontImage,
    this.nationalIdBackImage,
    this.expirationNationalIdDate,
    this.agreesInfoCorrect,
    this.agreesNoSmoking,
    this.agreesOnSchedule,
    this.userId,
    this.createdAt,
    this.updatedAt,
  });

  Passenger.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    province = json['province'];
    district = json['district'];
    subDistrict = json['sub_district'];
    street = json['street'];
    building = json['building'];
    landmark = json['landmark'];
    nationalIdFrontImage = json['national_id_front_image'];
    nationalIdBackImage = json['national_id_back_image'];
    expirationNationalIdDate = json['expiration_national_id_date'];
    agreesInfoCorrect = json['agrees_info_correct'];
    agreesNoSmoking = json['agrees_no_smoking'];
    agreesOnSchedule = json['agrees_on_schedule'];
    userId = json['user_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['province'] = province;
    data['district'] = district;
    data['sub_district'] = subDistrict;
    data['street'] = street;
    data['building'] = building;
    data['landmark'] = landmark;
    data['national_id_front_image'] = nationalIdFrontImage;
    data['national_id_back_image'] = nationalIdBackImage;
    data['expiration_national_id_date'] = expirationNationalIdDate;
    data['agrees_info_correct'] = agreesInfoCorrect;
    data['agrees_no_smoking'] = agreesNoSmoking;
    data['agrees_on_schedule'] = agreesOnSchedule;
    data['user_id'] = userId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
