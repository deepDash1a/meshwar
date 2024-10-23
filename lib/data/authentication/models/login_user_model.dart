import 'package:meshwar/core/shared/shared_models/base_response_model.dart';

class LoginUserModel extends BaseResponseModel<UserModel> {
  const LoginUserModel({
    required super.status,
    required super.message,
    super.body,
    super.token,
  });

  factory LoginUserModel.fromJson(Map<String, dynamic> json) {
    return LoginUserModel(
      status: json['status'],
      message: json['message'],
      body: UserModel.fromJson(json['user']),
      token: json['token'],
    );
  }
}

class UserModel {
  String? firstName;
  String? lastName;
  String? email;
  String? whatsappNumber;
  String? anotherNumber;
  String? address;
  String? walletNumber;
  String? bankAccountNumber;
  String? expirationLicenseDate;
  String? nationalIdFrontImage;
  String? nationalIdBackImage;
  String? licenseFrontImage;
  String? licenseBackImage;
  String? graduationCertificateImage;
  String? militaryCertificateImage;
  String? birthCertificate;
  String? feshTshbeeh;
  String? profileImage;
  String? status;
  String? updatedAt;
  String? createdAt;
  int? id;

  UserModel({
    this.firstName,
    this.lastName,
    this.email,
    this.whatsappNumber,
    this.anotherNumber,
    this.address,
    this.walletNumber,
    this.bankAccountNumber,
    this.expirationLicenseDate,
    this.nationalIdFrontImage,
    this.nationalIdBackImage,
    this.licenseFrontImage,
    this.licenseBackImage,
    this.graduationCertificateImage,
    this.militaryCertificateImage,
    this.birthCertificate,
    this.feshTshbeeh,
    this.profileImage,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    whatsappNumber = json['whatsapp_number'];
    anotherNumber = json['another_number'];
    address = json['address'];
    walletNumber = json['wallet_number'];
    bankAccountNumber = json['bank_account_number'];
    expirationLicenseDate = json['expiration_license_date'];
    nationalIdFrontImage = json['national_id_front_image'];
    nationalIdBackImage = json['national_id_back_image'];
    licenseFrontImage = json['license_front_image'];
    licenseBackImage = json['license_back_image'];
    graduationCertificateImage = json['graduation_certificate_image'];
    militaryCertificateImage = json['military_certificate_image'];
    birthCertificate = json['birth_certificate'];
    feshTshbeeh = json['fesh_tshbeeh'];
    profileImage = json['profile_image'];
    status = json['status'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['email'] = email;
    data['whatsapp_number'] = whatsappNumber;
    data['another_number'] = anotherNumber;
    data['address'] = address;
    data['wallet_number'] = walletNumber;
    data['bank_account_number'] = bankAccountNumber;
    data['expiration_license_date'] = expirationLicenseDate;
    data['national_id_front_image'] = nationalIdFrontImage;
    data['national_id_back_image'] = nationalIdBackImage;
    data['license_front_image'] = licenseFrontImage;
    data['license_back_image'] = licenseBackImage;
    data['graduation_certificate_image'] = graduationCertificateImage;
    data['military_certificate_image'] = militaryCertificateImage;
    data['birth_certificate'] = birthCertificate;
    data['fesh_tshbeeh'] = feshTshbeeh;
    data['profile_image'] = profileImage;
    data['status'] = status;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
