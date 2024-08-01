import 'constants.dart';
import 'bounds.dart';
import 'location.dart';

class ApiResponse {
  final Constants constants;
  final List<Bounds> bounds;
  final List<Location> locations;

  ApiResponse({
    required this.constants,
    required this.bounds,
    required this.locations,
  });

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      constants: Constants.fromJson(json['constants']),
      bounds: (json['bounds'] as List).map((i) => Bounds.fromJson(i)).toList(),
      locations: (json['locations'] as List).map((i) => Location.fromJson(i)).toList(),
    );
  }
}