import 'geometry.dart';
import 'website.dart';

class Location {
  final String area;
  final String geo;
  final String location;
  final List<String> officeType;
  final List<String> additionalInfo;
  final String address;
  final String phone;
  final Geometry geometry;
  final String email;
  final List<String> keywords;
  final List<Website> websites;
  final String id;

  Location({
    required this.area,
    required this.geo,
    required this.location,
    required this.officeType,
    required this.additionalInfo,
    required this.address,
    required this.phone,
    required this.geometry,
    required this.email,
    required this.keywords,
    required this.websites,
    required this.id,
  });

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      area: json['area'] ?? '',
      geo: json['geo'] ?? '',
      location: json['location'] ?? '',
      officeType: List<String>.from(json['officeType'] ?? []),
      additionalInfo: List<String>.from(json['additionalInfo'] ?? []),
      address: json['address'] ?? '',
      phone: json['phone'] ?? '',
      geometry: Geometry.fromJson(json['geometry'] ?? {}),
      email: json['email'] ?? '',
      keywords: List<String>.from(json['keywords'] ?? []),
      websites: (json['websites'] as List?)?.map((i) => Website.fromJson(i)).toList() ?? [],
      id: json['id'] ?? '',
    );
  }
}