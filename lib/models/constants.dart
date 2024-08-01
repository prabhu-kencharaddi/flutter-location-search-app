class Constants {
  final String? getDirection;
  final String? findOutMore;
  final String? contactUs;
  final String? mailUs;
  final String? defaultDropdownValue;

  Constants({
    required this.getDirection,
    required this.findOutMore,
    required this.contactUs,
    required this.mailUs,
    required this.defaultDropdownValue,
  });

  factory Constants.fromJson(Map<String, dynamic> json) {
    return Constants(
      getDirection: json['getDirection'],
      findOutMore: json['findOutMore'],
      contactUs: json['contactUs'],
      mailUs: json['mailUs'],
      defaultDropdownValue: json['defaultDropdownValue'],
    );
  }
}