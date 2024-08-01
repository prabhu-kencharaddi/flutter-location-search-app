class Website {
  final String name;
  final String url;

  Website({
    required this.name,
    required this.url,
  });

  factory Website.fromJson(Map<String, dynamic> json) {
    return Website(
      name: json['name'] ?? '',
      url: json['url'] ?? '',
    );
  }
}