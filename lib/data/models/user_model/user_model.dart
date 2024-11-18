import 'package:equatable/equatable.dart';
import 'package:meshwar/core/shared/shared_models/base_response_model.dart';

class UserModel extends BaseResponseModel<User> {
  const UserModel({
    required super.status,
    required super.message,
    super.body,
    super.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      status: json['status'],
      message: json['message'],
      body: User.fromJson(json['user']),
      token: json['token'],
    );
  }
}

// ignore: must_be_immutable
class User extends Equatable {
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
    return data;
  }

  @override
  List<Object?> get props => [
        id,
        name,
        whatsappNumber,
        anotherNumber,
        profileImage,
        email,
        emailVerifiedAt,
        role,
        status,
        createdAt,
        updatedAt,
      ];
}
