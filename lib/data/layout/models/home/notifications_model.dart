import 'package:meshwar/core/shared/shared_models/base_response_model.dart';

class GetAllNotificationsModel extends BaseResponseModel<List<Notifications>> {
  const GetAllNotificationsModel(
      {required super.status, required super.message, super.body});

  factory GetAllNotificationsModel.fromJson(Map<String, dynamic> json) {
    return GetAllNotificationsModel(
      status: json['status'],
      message: json['message'],
      body: List<Notifications>.from(
          json['notifications'].map((e) => Notifications.fromJson(e))).toList(),
    );
  }
}

class Notifications {
  String? id;
  String? type;
  String? notifiableType;
  int? notifiableId;
  Data? data;
  String? readAt;
  String? createdAt;
  String? updatedAt;

  Notifications({
    this.id,
    this.type,
    this.notifiableType,
    this.notifiableId,
    this.data,
    this.readAt,
    this.createdAt,
    this.updatedAt,
  });

  Notifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    notifiableType = json['notifiable_type'];
    notifiableId = json['notifiable_id'];

    // Safely parse `data`, checking if it's a Map
    if (json['data'] is Map<String, dynamic>) {
      data = Data.fromJson(json['data']);
    } else {
      data = null;
    }

    readAt = json['read_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['type'] = type;
    data['notifiable_type'] = notifiableType;
    data['notifiable_id'] = notifiableId;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['read_at'] = readAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Data {
  int? tripId;
  String? pickupPoint;
  String? tripDate;
  Destinations? destinations;
  String? message;
  Content? content;

  Data({
    this.tripId,
    this.pickupPoint,
    this.tripDate,
    this.destinations,
    this.message,
    this.content,
  });

  Data.fromJson(Map<String, dynamic> json) {
    tripId = json['trip_id'];
    pickupPoint = json['pickup_point'];
    tripDate = json['trip_date'];

    // Safely parse `destinations`, checking if it's a Map
    if (json['destinations'] is Map<String, dynamic>) {
      destinations = Destinations.fromJson(json['destinations']);
    } else {
      destinations = null;
    }

    message = json['message'];

    // Safely parse `content`, checking if it's a Map
    if (json['content'] is Map<String, dynamic>) {
      content = Content.fromJson(json['content']);
    } else {
      content = null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['trip_id'] = tripId;
    data['pickup_point'] = pickupPoint;
    data['trip_date'] = tripDate;
    if (destinations != null) {
      data['destinations'] = destinations!.toJson();
    }
    data['message'] = message;
    if (content != null) {
      data['content'] = content!.toJson();
    }
    return data;
  }
}

class Destinations {
  String? a;
  String? b;
  String? c;
  String? d;

  Destinations({this.a, this.b, this.c, this.d});

  Destinations.fromJson(Map<String, dynamic> json) {
    a = json['A'];
    b = json['B'];
    c = json['C'];
    d = json['D'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['A'] = a;
    data['B'] = b;
    data['C'] = c;
    data['D'] = d;
    return data;
  }
}

class Content {
  int? userId;
  String? content;
  String? passengerId;
  String? senderType;
  String? updatedAt;
  String? createdAt;
  int? id;

  Content(
      {this.userId,
      this.content,
      this.passengerId,
      this.senderType,
      this.updatedAt,
      this.createdAt,
      this.id});

  Content.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    content = json['content'];
    passengerId = json['passenger_id'];
    senderType = json['sender_type'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['content'] = content;
    data['passenger_id'] = passengerId;
    data['sender_type'] = senderType;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
