class Geometry {
  final double lat;
  final double lng;

  Geometry({
    required this.lat,
    required this.lng,
  });

  factory Geometry.fromJson(Map<String, dynamic> json) {
    return Geometry(
      lat: (json['lat'] as num?)?.toDouble() ?? 0.0,
      lng: (json['lng'] as num?)?.toDouble() ?? 0.0,
    );
  }
}