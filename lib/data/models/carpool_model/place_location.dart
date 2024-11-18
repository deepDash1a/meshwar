
import 'package:meshwar/core/shared/shared_models/base_response_model.dart';

class GetPlace extends BaseResponseModel<List<Place>> {
  const GetPlace({
    required super.status,
    required super.message,
    super.body,
  });

  factory GetPlace.fromJson(Map<String, dynamic> json) {
    return GetPlace(
      status: json['status'],
      message: json['message'],
      // Use an empty list as a fallback if 'results' is null
      body: json['results'] != null
          ? List<Place>.from(json['results'].map((e) => Place.fromJson(e)))
          : [],
    );
  }
}

class Place {
  final String? formattedAddress;
  final Geometry? geometry;
  final String? name;
  final String? placeId;

  const Place({
    this.formattedAddress,
    this.geometry,
    this.name,
    this.placeId,
  });

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      formattedAddress: json['formatted_address'],
      geometry:
      json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null,
      name: json['name'],
      placeId: json['place_id'],
    );
  }
}

class Geometry {
  final Location? location;

  const Geometry({this.location});

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      location:
      json['location'] != null ? Location.fromJson(json['location']) : null,
    );
  }
}

class Location {
  final double? lat;
  final double? lng;

  const Location({this.lat, this.lng});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      lat: json['lat'],
      lng: json['lng'],
    );
  }
}
