class Bounds {
  final double south;
  final double west;
  final double north;
  final double east;

  Bounds({
    required this.south,
    required this.west,
    required this.north,
    required this.east,
  });

  factory Bounds.fromJson(Map<String, dynamic> json) {
    return Bounds(
      south: (json['south'] as num?)?.toDouble() ?? 0.0,
      west: (json['west'] as num?)?.toDouble() ?? 0.0,
      north: (json['north'] as num?)?.toDouble() ?? 0.0,
      east: (json['east'] as num?)?.toDouble() ?? 0.0,
    );
  }
}